import 'dart:io';

import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/shared/services/firebase_service.dart';
import 'package:livros/shared/services/livro_service.dart';
import 'package:livros/shared/services/model/pais_origem.dart';
import 'package:livros/ui/pages/cadastro/widgets/cadastro_layout.dart';

class CadastroLivroExtension {
  Livro obterLivro(
    Livro? livroObtido,
    CadastroLayout lyt,
    int lido,
    int categoria,
    PaisOrigem? origem,
  ) {
    var livro = Livro();

    if (livroObtido != null && livroObtido.id != null) {
      livro.id = livroObtido.id;
    }

    livro.autor = lyt.tAutor.text;
    livro.descricao = lyt.tDescricao.text;
    livro.anoEdicao = lyt.tAnoEdicao.text;
    livro.numeroPaginas = int.tryParse(lyt.tNumeroPaginas.text);
    livro.titulo = lyt.tTitulo.text;
    livro.editora = lyt.tEditora.text;
    livro.status = categoria;
    livro.isbn10 = lyt.tISBN10.text;
    livro.isbn13 = lyt.tISBN13.text;
    livro.numeroEdicao = int.tryParse(lyt.tNumeroEdicao.text);
    livro.dataCompra = lyt.tDataCompra.text;
    livro.preco = lyt.tPreco.text;
    livro.categoria = lyt.tCategorias.text;
    livro.subtitulo = lyt.tSubtitulo.text;

    if (origem != null) {
      livro.paisOrigem = origem.descricao;
    }
    return livro;
  }

  Future<int>  salvar(context, Livro livro) async {
    int? id = 0;

    if (livro.id == null) {
      id = null;
    } else {
      id = livro.id;
    }

    if (livro.firebaseCodigo == null) {
      livro.dataHoraCriacao = DateTime.now();
    } else {
      livro.dataHoraCriacao ??= DateTime.now();
    }
    livro.dataHoraAlteracao = DateTime.now();

    await FirebaseService().salvar(livro);

    return id ?? 0;
  }

  salvarImagem(File imageFile, text, Livro livro) async {
    LivroService service = LivroService();

    var lista = <String>[];

    int? id = 0;

    if (livro.id == null) {
      id = 0;
    } else {
      id = livro.id;
    }

    //var result = await service.uploadImage2(imageFile, id.toString(), livro.foto != null && livro.foto.isNotEmpty ? livro.foto : 'null');
    var result = await LivroService.uploadFirebaseStorage(livro.titulo ?? '', imageFile);

    /*if (result != null && result.erros != null && result.erros.isNotEmpty)
      toast(result.erros);

    lista.add(result.data.path ?? '');
    lista.add(result.data.link ?? '');*/
    lista.add('');
    lista.add(result ?? '');

    return lista;
  }
}
