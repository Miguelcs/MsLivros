import 'package:flutter/material.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/ui/widgets/app_network_image.dart';

class InfoFotoLivro extends StatelessWidget {
  final Livro _livro;
  final bool heroCad;

  const InfoFotoLivro(this._livro, {super.key, this.heroCad = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5.0),
      child: Card(
        elevation: 5.0,
        child: Hero(
          tag: '${_livro.descricao}_foto_${_livro.id}',
          child:
              SizedBox(height: 240, width: 160, child: _obterImagem(_livro.link)),
        ),
      ),
    );
  }

  _obterImagem(livro) {
    return AppNetworkImage(livro);
  }
}
