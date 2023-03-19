import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class TituloDialog extends StatelessWidget {
  final String _titulo;

  const TituloDialog(this._titulo);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(FontAwesome.attention, color: Colors.blue,),
        SizedBox(width: 10,),
        Text(
          _titulo,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}
