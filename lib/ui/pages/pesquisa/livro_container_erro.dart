import 'package:flutter/material.dart';
import 'package:livros/shared/util/alertas.dart';

class LivroContainerErro extends StatefulWidget {
  final String _erro;

  const LivroContainerErro(this._erro);

  @override
  _LivroContainerErroState createState() => _LivroContainerErroState();
}

class _LivroContainerErroState extends State<LivroContainerErro> {
  String get erro => widget._erro;

  @override
  Widget build(BuildContext context) {
    toast(erro);

    return SizedBox.expand(
      child: Container(
        //color: Color(Cor.backgroundLight),
      ),
    );
  }
}
