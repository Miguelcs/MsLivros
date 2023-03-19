import 'package:flutter/material.dart';
import 'package:livros/ui/dialog/widgets/texto_button_dialog.dart';
import 'package:livros/shared/util/nav.dart';

class FlapButtonDialog extends StatelessWidget {
  final String _texto;
  final Function? _onClick;
  final int index;

  const FlapButtonDialog(
    this._texto,
    this._onClick, {
    super.key,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        pop(context);

        if (_onClick != null) {
          _onClick!(context, index);
        }
      },
      child: TextoButtonDialog(_texto),
    );
  }
}
