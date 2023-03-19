import 'package:flutter/material.dart';
import 'package:livros/ui/pages/livros/widgets/livro_input.dart';

class CadEdicao extends StatelessWidget {
  final TextEditingController _tAnoEdicao;
  final TextEditingController _tNumeroEdicao;
  final FocusNode _fEdicao;
  final FocusNode _fEditora;
  final FocusNode _fNumeroEdicao;

  const CadEdicao(this._tAnoEdicao, this._tNumeroEdicao, this._fEdicao,
      this._fEditora, this._fNumeroEdicao);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Card(
            margin: EdgeInsets.only(top: 2, bottom: 3, right: 5),
            child: LivroInput(
                _tAnoEdicao, 'Insira um Ano de Edição', 'Ano de Edição',
                type: TextInputType.number,
                focus: _fEdicao,
                focusNext: _fNumeroEdicao),
          ),
        ),
        Expanded(
          flex: 1,
          child: Card(
            margin: EdgeInsets.only(top: 2, bottom: 3),
            child: LivroInput(_tNumeroEdicao, '', 'Número de Edição',
                type: TextInputType.number,
                focus: _fNumeroEdicao,
                focusNext: _fEditora),
          ),
        ),
      ],
    );
  }
}
