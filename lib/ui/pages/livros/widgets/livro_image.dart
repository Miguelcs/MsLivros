import 'package:flutter/material.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/ui/widgets/app_network_image.dart';

class LivroImage extends StatelessWidget {
  final Livro? livro;

  const LivroImage(this.livro, {super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: livro?.tag ?? '',
      child: Container(
          margin: const EdgeInsets.only(right: 5.0),
          height: 220,
          width: 160,
          child: _obterImagem(livro?.link)),
    );
  }

  _obterImagem(livro) {
    return AppNetworkImage(livro);
  }
}
