import 'package:flutter/material.dart';

class PopupCategoria extends StatefulWidget {
  final Function _onClick;
  final int? categoriaObtida;
  final bool expand;
  final IconData icone;
  final double iconSize;
  final Color iconColor;

  const PopupCategoria(this._onClick,
      {this.categoriaObtida = 1,
      this.expand = true,
      this.icone = Icons.edit,
      this.iconSize = 24.0,
      this.iconColor = Colors.black});

  @override
  _PopupCategoriaState createState() => _PopupCategoriaState();
}

class _PopupCategoriaState extends State<PopupCategoria> {
  Function get _onClick => widget._onClick;
  String categoria = 'Não Lido';
  int? categoriaObtida;

  @override
  void initState() {
    categoriaObtida = widget.categoriaObtida;

    if (categoriaObtida != null) {
      if (categoriaObtida == 2) {
        categoria = 'Lido';
      } else if (categoriaObtida == 3) {
        categoria = 'Não Lido';
      } else
        categoria = 'Lendo';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.expand) {
      return Row(
        children: <Widget>[
          Expanded(flex: 1, child: Text(categoria)),
          _obterPopup()
        ],
      );
    }
    return _obterPopup();
  }

  _obterPopup() {
    return PopupMenuButton<int>(
      initialValue: categoriaObtida,
      onSelected: (int situacao) {
        if (situacao == 2) {
          categoria = 'Lido';
        } else if (situacao == 3) {
          categoria = 'Não Lido';
        } else
          categoria = 'Lendo';

        categoriaObtida = situacao;
        _onClick(situacao);

        setState(() {});
      },
      icon: Icon(widget.icone, size: widget.iconSize, color: widget.iconColor),
      itemBuilder: (context) => [
        menuItem(1, "Lendo"),
        menuItem(2, "Lido"),
        menuItem(3, "Não Lido"),
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
          Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
