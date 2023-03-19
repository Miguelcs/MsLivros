import 'package:flutter/material.dart';
import 'package:livros/shared/database/model/livro.dart';

class InfoDetalhesLivro extends StatelessWidget {
  final Livro _livro;

  const InfoDetalhesLivro(this._livro, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10.0, top: 3.0),
            child: const Text(
              'Autor',
              style: TextStyle(
                fontSize: 11.0,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: Text(
              _livro.autor ?? '',
              style: const TextStyle(
                fontSize: 16.0,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: const Text(
              'Ano de Edição',
              style: TextStyle(
                fontSize: 11.0,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: Text(
              _livro.anoEdicao ?? '',
              style: const TextStyle(
                fontSize: 16.0,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: const Text(
              'Páginas',
              style: TextStyle(
                fontSize: 11.0,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: Text(
              _livro.numeroPaginas.toString(),
              style: const TextStyle(
                fontSize: 16.0,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: const Text(
              'Editora',
              style: TextStyle(
                fontSize: 11.0,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: Text(
              _livro.editora ?? '',
              style: const TextStyle(
                fontSize: 16.0,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Divider(),
              Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: const Text(
                  'Pais Origem',
                  style: TextStyle(
                    fontSize: 11.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: Text(
                  _livro.paisOrigem ?? '',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
