import 'package:flutter/material.dart';
import 'package:livros/shared/bloc/url_bloc.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/shared/services/model/book.dart';
import 'package:livros/shared/services/model/resultweb_book.dart';
import 'package:livros/shared/services/model/volume_json.dart';
import 'package:translator/translator.dart';

class CadastroLayout {
  final tAutor = TextEditingController();
  final tDescricao = TextEditingController();
  final tAnoEdicao = TextEditingController();
  final tNumeroPaginas = TextEditingController();
  final tTitulo = TextEditingController();
  final tSubtitulo = TextEditingController();
  final tEditora = TextEditingController();
  final tISBN10 = TextEditingController(text: '0');
  final tISBN13 = TextEditingController(text: '0');
  final tNumeroEdicao = TextEditingController(text: '1');
  final tDataCompra = TextEditingController(text: '2019');
  final tPreco = TextEditingController(text: '0.00');
  final tCategorias = TextEditingController();

  final fTitulo = FocusNode();
  final fSubtitulo = FocusNode();
  final fFoto = FocusNode();
  final fAutor = FocusNode();
  final fEdicao = FocusNode();
  final fEditora = FocusNode();
  final fPaginas = FocusNode();
  final fDescricao = FocusNode();
  final fIsbn10 = FocusNode();
  final fIsbn13 = FocusNode();
  final fNumeroEdicao = FocusNode();
  final fDataCompra = FocusNode();
  final fPreco = FocusNode();
  final fCategorias = FocusNode();

  preencherCamposComLivro(Livro? livroObtido) {
    tAutor.text = livroObtido?.autor ?? '';
    tDescricao.text = livroObtido?.descricao ?? '';
    tAnoEdicao.text = livroObtido?.anoEdicao ?? '';
    tNumeroPaginas.text = '${livroObtido?.numeroPaginas}';
    tTitulo.text = livroObtido?.titulo ?? '';
    tSubtitulo.text = livroObtido?.subtitulo ?? '';
    tEditora.text = livroObtido?.editora ?? '';
    tISBN10.text = livroObtido?.isbn10 ?? '';
    tISBN13.text = livroObtido?.isbn13 ?? '';
    tDataCompra.text = livroObtido?.dataCompra ?? '';
    tPreco.text = livroObtido?.preco ?? '';
    tNumeroEdicao.text = '${livroObtido?.numeroEdicao}';
    tCategorias.text = livroObtido?.categoria ?? '';
  }

  preencherCamposEscaneado(ResultWebBook<Book> result) {
    tTitulo.text = result.data?.title?.titulo ?? '';
    tAnoEdicao.text = result.data?.publicationYear?.publicacao ?? '';

    if (result.data?.isbn?.isbn?.isNotEmpty == true) {
      tISBN10.text = result.data?.isbn?.isbn ?? '';
    }

    tISBN13.text = result.data?.isbn13?.isbn13 ?? '';
    tNumeroEdicao.text = result.data?.editionInformation?.edicao ?? '';

    tNumeroPaginas.text = result.data?.numPages?.paginas ?? '';
    tDescricao.text = result.data?.description?.descricao ?? '';
  }

  preencherCamposComLivroPesquisa(VolumeInfo? info, UrlBloc _bloc) async {
    if (info?.autores != null && info?.autores?.isNotEmpty == true) {
      var autor = '';
      var autores = info?.autores ?? [];

      for (String a in autores) {
        autor += a + ',';
      }
      tAutor.text = autor.substring(0, autor.length - 1);
    }

    if (info?.categorias != null && info?.categorias?.isNotEmpty == true) {
      var categoria = '';
      var categorias = info?.categorias ?? [];

      for (String c in categorias) {
        var cat = await c.translate(to: 'pt');
        categoria += cat + ',';
      }
      tCategorias.text = categoria.substring(0, categoria.length - 1);
    }

    tDescricao.text = info?.description ?? '';
    tAnoEdicao.text = info?.publishedDate ?? '';
    tNumeroPaginas.text = '${info?.pageCount}';
    tTitulo.text = info?.title ?? '';
    tEditora.text = info?.publisher ?? '';
    linkInfo = info?.image?.thumb ?? '';
    _bloc.obterUrl(true);
  }
}

String linkInfo = '';