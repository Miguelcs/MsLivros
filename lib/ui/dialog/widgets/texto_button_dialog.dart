import 'package:flutter/material.dart';

class TextoButtonDialog extends StatelessWidget {
  final String _texto;

  const TextoButtonDialog(this._texto);

  @override
  Widget build(BuildContext context) {
    return Text(_texto, style: TextStyle(color: Colors.blue, fontSize: 17));
  }
}
