import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livros/shared/bloc/atualizar_bloc.dart';
import 'package:livros/shared/database/dao/livro_dao.dart';
import 'package:livros/shared/database/data/dao_factory.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/shared/util/util.dart';
import 'package:livros/ui/widgets/popup_categoria.dart';
import 'package:livros/shared/services/firebase_service.dart';
import 'package:livros/shared/util/alertas.dart';

class TituloLivro extends StatefulWidget {
  const TituloLivro({super.key, required this.livro});

  final Livro livro;

  @override
  _TituloLivroState createState() => _TituloLivroState();
}

class _TituloLivroState extends State<TituloLivro> {
  Livro get livro => widget.livro;
  final _bloc = AtualizarBloc();
  bool atualizou = false;

  @override
  Widget build(BuildContext context) {
    bool subtitulo = livro.subtitulo != null && livro.subtitulo?.isNotEmpty == true;

    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(true);
      },
      child: Card(
        elevation: 1.0,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: subtitulo
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            livro.titulo ?? '',
                            style: const TextStyle(
                                fontSize: 20.0, color: Color(0xFF004ba0)),
                          ),
                          Text(
                            subtitulo ? livro.subtitulo ?? '' : '',
                            style: const TextStyle(
                                fontSize: 17.0,
                                color: Color(0xFF004ba0),
                                fontStyle: FontStyle.italic),
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy').format(livro.dataHoraCriacao ?? DateTime.now()),
                            style: const TextStyle(
                                fontSize: 17.0,
                                color: Color(0xFF004ba0),
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            livro.titulo ?? '',
                            style:
                                const TextStyle(fontSize: 20.0, color: Color(0xFF004ba0)),
                          ),
                        Text(
                          'Cadastrado em ${DateFormat('dd/MM/yyyy - HH:mm:ss').format(livro.dataHoraCriacao ?? DateTime.now())}',
                          style: const TextStyle(
                              fontSize: 10.0,
                              color: Color(0xFF004ba0),
                              fontStyle: FontStyle.italic),
                        ),
                        Text(
                          'Atualizado em  ${DateFormat('dd/MM/yyyy - HH:mm:ss').format(livro.dataHoraAlteracao ?? DateTime.now())}',
                          style: const TextStyle(
                              fontSize: 10.0,
                              color: Color(0xFF004ba0),
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
              ),
              Row(
                children: <Widget>[
                  StreamBuilder<bool>(
                    initialData: true,
                    stream: _bloc.stream,
                    builder: (context, snapshot) {
                      if (snapshot.data == true) {
                        return PopupCategoria(
                          _atualizar,
                          categoriaObtida: livro != null ? livro.status : null,
                          expand: false,
                          icone: Icons.favorite,
                          iconSize: 40.0,
                          iconColor: _obterCor(),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Color _obterCor() {
    if (livro.status == 1) {
      return Colors.yellow;
    } else if (livro.status == 2) {
      return Colors.red;
    }
    return Colors.grey;
  }

  void _atualizar(int categoria) async {
    _bloc.exibir(false);
    livro.status = categoria;

    await FirebaseService().salvar(livro);

    LivroDAO livroDAO = DaoFactory.obterLivroDAO();
    bool salvou = await livroDAO.salvar(livro);

    toast(
        salvou ? 'Livro atualizado!' : 'Falha ao atualizar o livro no sqlite!');

    Future.delayed(const Duration(milliseconds: 400), () {
      atualizou = true;
      cadastro = true;
      _bloc.exibir(true);
    });
  }
}
//158
