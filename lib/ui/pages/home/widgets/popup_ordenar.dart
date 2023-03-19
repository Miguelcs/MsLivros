import 'package:flutter/material.dart';
import 'package:livros/shared/util/util.dart';

class PopupOrdenar extends StatefulWidget {
  final Function _onClick;
  final bool expand;
  final IconData icone;
  final double iconSize;
  final Color iconColor;

  const PopupOrdenar(this._onClick,
      {super.key, this.expand = true,
      this.icone = Icons.edit,
      this.iconSize = 24.0,
      this.iconColor = Colors.black});

  @override
  _PopupOrdenarState createState() => _PopupOrdenarState();
}

class _PopupOrdenarState extends State<PopupOrdenar> {
  Function get _onClick => widget._onClick;
  String ordenar = 'Título';
  int? ordenacaoObtida;

  @override
  void initState() {
    ordenacaoObtida = ordenacao;

    if (ordenacaoObtida != null) {
      if (ordenacaoObtida == 2) {
        ordenar = 'Autor';
      } else if (ordenacaoObtida == 3) {
        ordenar = 'Ano de Edição';
      } else if (ordenacaoObtida == 4) {
        ordenar = 'Editora';
      } else if (ordenacaoObtida == 5) {
        ordenar = 'Último Registro';
      } else {
        ordenar = 'Título';
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.expand) {
      return Row(
        children: <Widget>[
          Expanded(flex: 1, child: Text(ordenar)),
          _obterPopup()
        ],
      );
    }
    return _obterPopup();
  }

  _obterPopup() {
    return PopupMenuButton<int>(
      initialValue: ordenacaoObtida,
      onSelected: (int situacao) {
        if (situacao == 2) {
          ordenar = 'Autor';
        } else if (situacao == 3) {
          ordenar = 'Ano de Edição';
        } else if (situacao == 4) {
          ordenar = 'Editora';
        } else if (situacao == 5) {
          ordenar = 'Último Registro';
        } else {
          ordenar = 'Título';
        }

        ordenacaoObtida = situacao;
        _onClick(situacao);

        setState(() {});
      },
      icon: Icon(widget.icone, size: widget.iconSize, color: Colors.white),
      itemBuilder: (context) => [
        menuItem(1, "Título"),
        menuItem(2, "Autor"),
        menuItem(3, "Ano de Edição"),
        menuItem(4, "Editora"),
        menuItem(5, "Último Registro"),
      ],
    );
  }

  menuItem(int valor, String texto) {
    return PopupMenuItem(
      value: valor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(texto),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
