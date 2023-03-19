import 'package:flutter/material.dart';
import 'package:livros/ui/pages/configuracoes/widgets/config_container.dart';

class ConfigInputText extends StatelessWidget {
  final String _titulo;
  final String _texto;

  const ConfigInputText(
      this._titulo, this._texto);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ConfigContainer(_titulo, 3.0, 10.0),
          ConfigContainer(_texto, 10.0, 0.0),
        ],
      ),
    );
  }
}
