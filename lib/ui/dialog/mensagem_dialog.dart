import 'package:flutter/material.dart';
import 'package:livros/ui/dialog/widgets/flap_button_dialog.dart';
import 'package:livros/ui/dialog/widgets/texto_dialog.dart';
import 'package:livros/ui/dialog/widgets/titulo_dialog.dart';

class MensagemDialog extends StatelessWidget {
  final String _texto;
  final String titulo;
  final Function _onClick;
  final int index;

  const MensagemDialog(this.titulo, this._texto, this._onClick, {this.index = 0,});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.only(left: 15.0, right: 15.0, top: 7.0),
      title: TituloDialog(titulo),
      content: TextoDialog(_texto),
      actions: <Widget>[
        FlapButtonDialog('Não', null),
        FlapButtonDialog('Sim', _onClick, index: index),
      ],
    );
  }
}
