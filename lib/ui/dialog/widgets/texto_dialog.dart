import 'package:flutter/material.dart';

class TextoDialog extends StatelessWidget {
  final String _texto;

  const TextoDialog(this._texto);

  @override
  Widget build(BuildContext context) {
    return Text(_texto,);
  }
}
