import 'package:flutter/material.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/ui/widgets/app_network_image.dart';
import 'package:livros/ui/widgets/livro_foto_link.dart';

class FotoDialog extends StatelessWidget {
  final Livro _livro;

  FotoDialog(this._livro);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Hero(
        tag: '${_livro.descricao}_foto_${_livro.id}',
        child: Container(child: _obterImagem(_livro.link)),
      ),
    );
  }

  Widget _obterImagem(livro) {
    return AppNetworkImage(livro);
  }
}
