import 'package:flutter/material.dart';
import 'package:livros/shared/database/dao/livro_dao.dart';
import 'package:livros/shared/database/data/dao_factory.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/shared/util/nav.dart';
import 'package:livros/ui/pages/cadastro/cadastro_livro_page.dart';
import 'package:livros/ui/pages/detalhes/detalhes_livro_page.dart';
import 'package:livros/ui/pages/livros/widgets/detalhes_livro.dart';
import 'package:livros/ui/pages/pesquisa/livro_container_erro.dart';
import 'package:livros/ui/widgets/app_network_image.dart';
import 'package:livros/ui/widgets/container_progress.dart';

class PesquisarLivrosPage extends SearchDelegate<Livro> {
  final bool cadastro;

  PesquisarLivrosPage({this.cadastro = false});

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColorDark: const Color(0xFF002171),
      accentColor: const Color(0xFFFFFFFF),
      //textTheme: theme.textTheme.copyWith(title: theme.textTheme.title.copyWith(color: theme.primaryTextTheme.title.color)),
      primaryColor: theme.primaryColor,
      primaryIconTheme: theme.primaryIconTheme,
      primaryColorBrightness: theme.primaryColorBrightness,
      primaryTextTheme: theme.primaryTextTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, Livro());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    LivroDAO livroDAO = DaoFactory.obterLivroDAO();

    return FutureBuilder<List<Livro>>(
      future: livroDAO.obterLivrosPorDescricao(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return cadastro
              ? ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  primary: false,
                  padding: const EdgeInsets.all(0.5),
                  itemBuilder: (BuildContext context, int index) {
                    Livro livro = snapshot.data![index];
                    return DetalhesLivro(
                      livro,
                      () {
                        _detalhesCadastro(context, livro);
                      },
                      heroCad: false,
                      detalhes: false,
                    );
                  },
                )
              : GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(0.5),
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                  children: List.generate(
                    snapshot.data?.length ?? 0,
                    (index) {
                      Livro livro = snapshot.data![index];
                      return _containers(livro, context, true);
                    },
                  ),
                );
        } else if (snapshot.hasError) {
          return LivroContainerErro(snapshot.error.toString() ?? '');
        } else {
          return ContainerProgress();
        }
      },
    );
  }

  _containers(Livro livro, BuildContext context, bool grid) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      padding: const EdgeInsets.all(0.5),
      child: Card(
        child: InkWell(
          onTap: () {
            _detalhes(context, livro);
          },
          child: Container(
            child: Hero(
              tag: livro.descricao ?? '',
              child: Container(
                  height: 560, width: 340, child: _obterImagem(livro.link)),
            ),
          ),
        ),
      ),
    );
  }

  _detalhes(context, Livro livro) async {
    pop(context);
    push(context, DetalhesLivroPage(livro));
  }

  _detalhesCadastro(context, Livro livro) {
    pop(context);
    push(context, CadastroLivroPage(livro));
  }

  _obterImagem(livro) {
    //if (cadastroSite) {
      return AppNetworkImage(livro);
    /*} else {
      return LivroFotoFile(livro);
    }*/
  }
}
