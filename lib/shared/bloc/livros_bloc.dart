import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/services.dart';
import 'package:livros/shared/database/dao/livro_dao.dart';
import 'package:livros/shared/database/data/dao_factory.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/shared/enumeradores/livro_enum.dart';
import 'package:livros/shared/util/util.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:convert' as convert;

class LivrosBloc extends BlocBase {
  final _controller = BehaviorSubject<List<Livro>?>();

  get stream => _controller.stream;

  Future obterLivros({bool exibir = true}) async {
    if (exibir) {
      LivroDAO livroDAO = DaoFactory.obterLivroDAO();

      var livros = await livroDAO.obterLivrosPorCategoria(ordenacao);
      _controller.sink.add(livros);
    } else {
      _controller.sink.add([]);
    }
    return null;
  }

  Future obterLivrosPorDescricao(String descricao, {bool exibir = true}) async {
    if (exibir) {
      LivroDAO livroDAO = DaoFactory.obterLivroDAO();

      var livros = await livroDAO.obterLivrosPorDescricao(descricao);
      _controller.sink.add(livros);
    } else {
      _controller.sink.add([]);
    }
    return null;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}