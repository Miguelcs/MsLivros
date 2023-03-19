import 'package:flutter/material.dart';
import 'package:livros/ui/pages/configuracoes/widgets/config_container.dart';

class ConfigTitulo extends StatelessWidget {
  final String _titulo;

  const ConfigTitulo(this._titulo);

  @override
  Widget build(BuildContext context) {
    return ConfigContainer(_titulo.toUpperCase(), 15.0, 20.0, cor: Colors.white,);
  }
}
