import 'package:flutter/material.dart';

class LivroTitulo extends StatelessWidget {
  final String _titulo;
  final String _subtitulo;

  LivroTitulo(this._titulo, this._subtitulo);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(_titulo),
        Text(
          '$_subtitulo',
          maxLines: 2,
          style: TextStyle(fontSize: 14.0, color: Colors.yellow),
        ),
      ],
    );
  }
}
