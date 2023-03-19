import 'package:flutter/material.dart';

class LivroInput extends StatelessWidget {
  final TextEditingController _controller;
  final String _validacao;
  final String _label;
  final TextInputType type;
  final int maxLines;
  final FocusNode? focus;
  final FocusNode? focusNext;
  final TextInputAction action;
  final bool validar;
  final bool obscureText;
  final Color color;
  final Function? onChanged;

  const LivroInput(
    this._controller,
    this._validacao,
    this._label, {super.key,
    this.type = TextInputType.text,
    this.maxLines = 1,
    this.focus,
    this.focusNext,
    this.action = TextInputAction.next,
    this.validar = true,
    this.obscureText = false,
    this.color = Colors.black,
        this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 16, bottom: 6),
      child: TextFormField(
        textInputAction: action,
        focusNode: focus,
        maxLines: maxLines,
        obscureText: obscureText,
        keyboardType: type,
        controller: _controller,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(focusNext);
        },
        onChanged: (String texto) {
          if (onChanged != null) onChanged!(texto);
        },
        validator: (value) {
          if (!validar) return null;

          if (value?.isEmpty == true) {
            return _validacao;
          }
          return null;
        },
        style: TextStyle(
          color: color,
        ),
        decoration: InputDecoration(
          labelText: _label,
          labelStyle: TextStyle(color: color),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
