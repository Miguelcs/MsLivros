import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:livros/shared/database/dao/livro_dao.dart';
import 'package:livros/shared/database/data/dao_factory.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/ui/pages/drawer/extensions/drawe_list_extension.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:livros/shared/util/alertas.dart';
import 'package:livros/shared/util/strings.dart';

class SincronizacaoBloc extends BlocBase {
  final _controller = BehaviorSubject<Sincroniza>();

  get stream => _controller.stream;

  exibir(bool exibir,
      {String mensagem = 'Sincronizando...',
        int todos = 0,
        int lendo = 0,
        int lidos = 0,
        int naoLidos = 0}) {
    _controller.sink.add(Sincroniza(mensagem, exibir,
        qtdeTodos: todos,
        qtdeLendo: lendo,
        qtdeLidos: lidos,
        qtdeNaoLidos: naoLidos));
  }

  Future sincronizar(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) async {
    var sucesso = true;
    exibir(true);
    final _extension = DrawerListExtension();

    await _extension.deletarTodos();

    toast(!sucesso ? FALHA_SALVAR_LIVRO : SINCRONIZACAO_REALIZADA);

    if (sucesso) {
      var manager = new DefaultCacheManager();
      manager.emptyCache();
    }

    LivroDAO livroDAO = DaoFactory.obterLivroDAO();
    List<Livro> todos = await livroDAO.obterTodos();
    List<Livro> lendo = await livroDAO.obterLivrosPorCategoria(1);
    List<Livro> lidos = await livroDAO.obterLivrosPorCategoria(2);
    List<Livro> naoLidos = await livroDAO.obterLivrosPorCategoria(3);

    Future.delayed(const Duration(milliseconds: 200), () {
      exibir(false, mensagem: '', todos: todos.length, lendo: lendo.length, lidos: lidos.length, naoLidos: naoLidos.length);
    });
  }

  sincronizacao(context) async {
    exibir(true, mensagem: '');

    LivroDAO livroDAO = DaoFactory.obterLivroDAO();
    List<Livro> todos = await livroDAO.obterTodos();
    List<Livro> lendo = await livroDAO.obterLivrosPorCategoria(1);
    List<Livro> lidos = await livroDAO.obterLivrosPorCategoria(2);
    List<Livro> naoLidos = await livroDAO.obterLivrosPorCategoria(3);

    Future.delayed(const Duration(milliseconds: 200), () {
      exibir(false, mensagem: '', todos: todos.length, lendo: lendo.length, lidos: lidos.length, naoLidos: naoLidos.length);
    });
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}

class Sincroniza {
  String mensagem;
  bool exibir;
  int qtdeTodos;
  int qtdeLendo;
  int qtdeLidos;
  int qtdeNaoLidos;

  Sincroniza(this.mensagem, this.exibir,
      {this.qtdeTodos = 0,
        this.qtdeLendo = 0,
        this.qtdeLidos = 0,
        this.qtdeNaoLidos = 0});
}