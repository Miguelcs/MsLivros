import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:livros/shared/bloc/sincronizacao_bloc.dart';
import 'package:livros/shared/database/dao/livro_dao.dart';
import 'package:livros/shared/database/data/dao_factory.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/ui/pages/cadastro/cadastro_livro_page.dart';
import 'package:livros/ui/pages/configuracoes/configuracoes_page.dart';
import 'package:livros/ui/pages/drawer/extensions/drawe_list_extension.dart';
import 'package:livros/ui/pages/drawer/livro_drawer_header.dart';
import 'package:livros/ui/pages/drawer/livro_drawer_item.dart';
import 'package:livros/ui/pages/home/home_page.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:livros/shared/util/nav.dart';
import 'package:livros/shared/util/strings.dart';
import 'package:livros/shared/util/alertas.dart';
import 'package:livros/ui/pages/relatorio/page/graficos_page.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({super.key});

  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  final _blocSincronizacao = BlocProvider.getBloc<SincronizacaoBloc>();
  final _extension = DrawerListExtension();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 300,
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            LivroDrawerHeader(),
            LivroDrawerItem(
              MENU,
              Icons.menu,
              onClick: _irParaHome,
            ),
            LivroDrawerItem(
              CONFIGURACOES,
              Icons.settings,
              onClick: _irParaConfiguracoes,
            ),
            LivroDrawerItem(
              CADASTROS,
              Icons.add,
              onClick: _onClickCad,
            ),
            LivroDrawerItem(SINCRONIZAR, Icons.sync, onClick: _sincronizar,),
            // LivroDrawerItem(
            //   RELATORIO,
            //   Icons.assessment,
            //   onClick: _onClickRelatorio,
            // ),
          ],
        ),
      ),
    );
  }

  void _irParaHome(context) => pushReplacement(context, HomePage());

  void _irParaConfiguracoes(context) {
    pop(context);
    push(context, const ConfiguracoesPage());
  }

  void _onClickCad(context) {
    pop(context);
    //push(context, CadastrosPage());
    push(context, const CadastroLivroPage(null));
  }

  Future _onClickRelatorio(context) async {
    pop(context);
    push(context, const RelatorioPage());
  }

  _sincronizar(context) async {
    pop(context);
    _blocSincronizacao.exibir(true);

    var documents = await FirebaseFirestore.instance.collection("livros_m").get();
    var livros = documents.docs.map((document) => Livro.fromJson(document.data()) ).toList();
    var sucesso = true;

    await _extension.deletarTodos();

    for (Livro livro in livros) {
      sucesso = await _extension.salvarLivro(livro);
    }
    toast(!sucesso ? FALHA_SALVAR_LIVRO : SINCRONIZACAO_REALIZADA);

    if (sucesso) {
      var manager = DefaultCacheManager();
      manager.emptyCache();
    }

    LivroDAO livroDAO = DaoFactory.obterLivroDAO();
    List<Livro> todos = await livroDAO.obterTodos();
    List<Livro> lendo = await livroDAO.obterLivrosPorCategoria(1);
    List<Livro> lidos = await livroDAO.obterLivrosPorCategoria(2);
    List<Livro> naoLidos = await livroDAO.obterLivrosPorCategoria(3);

    Future.delayed(const Duration(milliseconds: 200), () {
      _blocSincronizacao.exibir(false, mensagem: '', todos: todos.length, lendo: lendo.length, lidos: lidos.length, naoLidos: naoLidos.length);
    });
  }
}
