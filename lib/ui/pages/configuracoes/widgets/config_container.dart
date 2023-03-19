import 'package:flutter/material.dart';

class ConfigContainer extends StatelessWidget {
  final String texto;
  final Color cor;
  final double bottom;
  final double top;

  const ConfigContainer(this.texto, this.bottom, this.top, {this.cor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20.0, bottom: bottom, top: top),
        child: new Text(texto, style: TextStyle(color: cor),)
    );
  }
}