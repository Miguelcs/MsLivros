import 'package:flutter/material.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/shared/util/nav.dart';
import 'package:livros/ui/pages/detalhes/detalhes_livro_page.dart';
import 'package:livros/ui/widgets/app_network_image.dart';

class LivroGridView extends StatelessWidget {
  final List<Livro> lista;
  final Animation<double> animation;
  final TickerProviderStateMixin provider;

  const LivroGridView(this.lista, this.animation, this.provider, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FadeTransition(
        opacity: animation,
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(0.2),
          crossAxisCount: 3,
          childAspectRatio: 0.68,
          children: List.generate(
            lista.length,
            (index) {
              Livro livro = lista[index];
              return _containers(livro, context, true);
            },
          ),
        ),
      ),
    );
  }

  _containers(Livro livro, BuildContext context, bool grid) {
    return Card(
      margin: const EdgeInsets.all(3.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 3.0,
      child: InkWell(
        onTap: () {
          _detalhes(context, livro);
        },
        child: Hero(
          tag: '${livro.descricao}_foto_${livro.id}',
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: _obterImagem(livro.link)),
        ),
      ),
    );
  }

  _detalhes(context, Livro livro) => push(context, DetalhesLivroPage(livro));

  Widget _obterImagem(livro) {
    return AppNetworkImage(livro);
  }
}
