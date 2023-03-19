import 'package:flutter/material.dart';

class LivroDrawerItem extends StatelessWidget {
  final Function? onClick;
  final String _texto;
  final IconData _icone;

  const LivroDrawerItem(
    this._texto,
    this._icone, {super.key,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (onClick != null) {
          onClick!(context);
        }
      },
      title: Text(_texto),
      leading: Icon(
        _icone,
        color: const Color(0xFF002171),
      ),
    );
  }
}
