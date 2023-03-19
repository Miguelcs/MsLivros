import 'package:flutter/material.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/ui/pages/detalhes/detalhes_livro_page.dart';
import 'package:livros/ui/pages/home/widgets/livro_gridview.dart';
import 'package:livros/shared/util/nav.dart';
import 'package:livros/ui/widgets/livro_listview.dart';

class HomePageLivros extends StatelessWidget {
  final bool grid;
  final List<Livro> lista;
  final Animation<double> animation;
  final TickerProviderStateMixin provider;

  const HomePageLivros(this.lista, this.grid, this.animation, this.provider, {super.key});

  @override
  Widget build(BuildContext context) {
    return grid
        ? LivroGridView(lista, animation, provider)
        : LivroListView(lista, _detalhes, animation, provider);
  }

  _detalhes(context, Livro livro) async {
    push(context, DetalhesLivroPage(livro));
  }
}
