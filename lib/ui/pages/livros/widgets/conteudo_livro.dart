import 'package:flutter/material.dart';
import 'package:livros/shared/database/model/livro.dart';

class ConteudoLivro extends StatelessWidget {
  final Livro livro;

  const ConteudoLivro(this.livro, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: new EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(right: 10.0),
                    child: const Text(
                      "Descrição",
                      style: TextStyle(
                        fontSize: 11.0,
                      ),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    livro.descricao ?? '',
                    style: const TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
