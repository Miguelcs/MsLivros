import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:livros/shared/bloc/atualizar_bloc.dart';
import 'package:livros/shared/bloc/sincronizacao_bloc.dart';
import 'package:livros/shared/database/dao/livro_dao.dart';
import 'package:livros/shared/database/data/dao_factory.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/shared/services/model/preferences.dart';
import 'package:livros/shared/util/util.dart';
import 'package:livros/ui/pages/detalhes/detalhes_livro_page.dart';
import 'package:livros/ui/pages/drawer/drawer_list.dart';
import 'package:livros/ui/pages/home/tabs/lendo_page.dart';
import 'package:livros/ui/pages/home/tabs/lidos_page.dart';
import 'package:livros/ui/pages/home/tabs/nao_lidos_page.dart';
import 'package:livros/ui/pages/home/tabs/todos_page.dart';
import 'package:livros/ui/pages/home/widgets/home_page_icons.dart';
import 'package:livros/ui/pages/pesquisar/pesquisa_livros_page.dart';
import 'package:livros/ui/widgets/home_tab_controller.dart';
import 'package:livros/shared/util/nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin<HomePage> {
  TabController? tabController;

  final _blocSincronizacao = BlocProvider.getBloc<SincronizacaoBloc>();
  final _bloc = BlocProvider.getBloc<AtualizarBloc>();

  bool grid = true;

  int qtdeTodos = 0;
  int qtdeLendo = 0;
  int qtdeLidos = 0;
  int qtdeNaoLidos = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    verificarUrl();
    _bloc.exibir(false);
  }

  @override
  Widget build(BuildContext context) {
    iniciouCadastro = false;

    return FutureBuilder<bool>(
      initialData: false,
      future: _obterValores(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Livros'),
            actions: <Widget>[
              HomePageIcons(grid, _onClickGridList, _pesquisar, _onClickOrdenar)
            ],
          ),
          body: HomeTabController(
              _blocSincronizacao,
              tabController,
              _bloc,
              qtdeNaoLidos,
              qtdeTodos,
              qtdeLendo,
              qtdeLidos,
              grid),
          drawer: const DrawerList(),
        );
      },
    );
  }

  _onClickGridList(grid) {
    this.grid = !grid;
    _blocSincronizacao.exibir(false, todos: qtdeTodos, lendo: qtdeLendo, lidos: qtdeLidos, naoLidos: qtdeNaoLidos);

    setState(() {});
  }

  _onClickOrdenar(ordenar) async {
    Preferences.salvarOrdenacao(ordenar);
    ordenacao = await Preferences.obterOrdenacao();
    _blocSincronizacao.exibir(true, mensagem: '', todos: qtdeTodos, lendo: qtdeLendo, lidos: qtdeLidos, naoLidos: qtdeNaoLidos);

    Future.delayed(const Duration(seconds: 1)).then((v) => _blocSincronizacao.exibir(false, todos: qtdeTodos, lendo: qtdeLendo, lidos: qtdeLidos, naoLidos: qtdeNaoLidos));
  }

  Future _pesquisar() async {
    Livro livro = await push(context, PesquisarLivrosPage(provider: this,));

    if (livro != null && livro.id != null) {
      push(context, DetalhesLivroPage(livro));
    }
  }

  Future<bool> _obterValores() async {
    LivroDAO livroDAO = DaoFactory.obterLivroDAO();
    List<Livro> todos = await livroDAO.obterTodos();
    List<Livro> lendo = await livroDAO.obterLivrosPorCategoria(1);
    List<Livro> lidos = await livroDAO.obterLivrosPorCategoria(2);
    List<Livro> naoLidos = await livroDAO.obterLivrosPorCategoria(3);
    qtdeTodos = todos.length ?? 0;
    qtdeLendo = lendo.length ?? 0;
    qtdeLidos = lidos.length ?? 0;
    qtdeNaoLidos = naoLidos.length ?? 0;
    return true;
  }

  List<Widget> obterFragments() {
    return [
      TodosPage(_blocSincronizacao, _bloc, grid),
      LendoPage(_blocSincronizacao, _bloc, grid),
      LidosPage(_blocSincronizacao, _bloc, grid),
      NaoLidosPage(_blocSincronizacao, _bloc, grid),
    ];
  }
}