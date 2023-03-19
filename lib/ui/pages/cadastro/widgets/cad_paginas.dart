import 'package:flutter/material.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/shared/interfaces/on_select_listener.dart';
import 'package:livros/shared/services/model/pais_origem.dart';
import 'package:livros/ui/pages/livros/widgets/livro_input.dart';
import 'package:livros/ui/widgets/dropdown.dart';
import 'package:livros/ui/widgets/popup_categoria.dart';

class CadPaginas extends StatefulWidget {
  final TextEditingController _tNumeroPaginas;
  final FocusNode _fPaginas;
  final FocusNode _fDescricao;
  final Livro? livroObtido;
  final OnSelectedListener _listener;
  final Function _onClick;

  CadPaginas(this._tNumeroPaginas, this._fPaginas, this._fDescricao,
      this.livroObtido, this._listener, this._onClick,);

  @override
  _CadPaginasState createState() => _CadPaginasState();
}

class _CadPaginasState extends State<CadPaginas> {
  int? categoria;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Card(
        margin: EdgeInsets.only(top: 2, bottom: 3),
        child: Container(
          padding: EdgeInsets.only(left: 5, right: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              LivroInput(
                widget._tNumeroPaginas,
                'Insira a quantidade de Páginas',
                'Páginas',
                type: TextInputType.number,
                focus: widget._fPaginas,
                focusNext: widget._fDescricao,
              ),
              DropDownItens<PaisOrigem>(
                PaisOrigem.origens(),
                widget._listener,
                "País Origem",
                value: PaisOrigem.origens()[0],
              ),
              Text('Categoria', style: TextStyle()),
              PopupCategoria(
                widget._onClick,
                categoriaObtida: widget.livroObtido != null ? widget.livroObtido?.status : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
