import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/shared/services/base_service.dart';
import 'package:livros/shared/services/model/book.dart';
import 'package:livros/shared/services/model/path_image.dart';
import 'package:livros/shared/services/model/resultweb.dart';
import 'package:livros/shared/services/model/resultweb_book.dart';

import 'package:path/path.dart' as path;

class LivroService {
  static Future<ResultWeb<List<Livro>>> obterTodos() async {
    try {
      String json = await BaseServiceLivro.obterComAutorizacao("livros/obter-todos");
      final mapProdutos = convert.json.decode(json);
      final produtos = ResultWeb<List<Livro>>.fromJsonList(mapProdutos);
      return produtos;
    } catch (error) {
      return ResultWeb<List<Livro>>(
      erros: error is SocketException
          ? "Internet indisponível. Por favor verifique sua conexão! $error"
          : "Erro Genério $error");
    }
  }

  Future<ResultWeb<List<Livro>>> obterLivrosPorUsuario(int id) async {
    try {
      String json = await BaseServiceLivro.obterComAutorizacao("livros/obter-livros-por-usuario-id/$id");
      final mapProdutos = convert.json.decode(json);
      final produtos = ResultWeb<List<Livro>>.fromJsonList(mapProdutos);
      return produtos;
    } catch (error) {
      return ResultWeb<List<Livro>>(erros: error is SocketException
          ? "Internet indisponível. Por favor verifique sua conexão! $error"
          : "Erro Genério $error");
    }
  }

  Future<ResultWeb<int>> registrar(Livro livro) async {
    try {
      String json = livro.id == null ?
      await BaseServiceLivro.enviarComAutorizacao("livros/registrar-livro",
          value: livro.toMap())
      : await BaseServiceLivro.atualizarComAutorizacao("livros/atualizar-livro",
          value: livro.toMap());

      final mapResult = convert.json.decode(json);
      final result = ResultWeb<int>.fromJson(mapResult);
      return result;
    } catch (error) {
      return ResultWeb<int>(success: false,
      erros: error is SocketException
          ? "Internet indisponível. Por favor verifique sua conexão! $error"
          : "Erro Genério $error");
    }
  }

  Future<ResultWeb<bool>> upload(Livro livro) async {
    try {
      String json =
      await BaseServiceLivro.enviarComAutorizacao("livros/upload-livro",
          value: livro.toMap());

      final mapResult = convert.json.decode(json);
      final result =
      ResultWeb<bool>.fromJson(mapResult);
      return result;
    } catch (error) {
      var result = ResultWeb<bool>();
      result.success = false;
      result.erros = error is SocketException
          ? "Internet indisponível. Por favor verifique sua conexão! $error"
          : "Erro Genério $error";
      return result;
    }
  }

  Future<ResultWeb<String>> uploadImage(File file, String id) async {
    try {
      String metodo = "livros/upload/" + id;
      String json = await BaseServiceLivro.uploadFoto(metodo, file);

      final mapResult = convert.json.decode(json);
      final result = ResultWeb<String>.fromJson(mapResult);
      return result;
    } catch (error) {
      return ResultWeb<String>(
      success: false,
      erros: error is SocketException
          ? "Internet indisponível. Por favor verifique sua conexão! $error"
          : "Erro Genério $error");
    }
  }

  Future<ResultWeb<PathImage>> uploadImage2(File file, String id, String pathFoto) async {
    try {
      String metodo = "livros/upload/" + id + "/" + pathFoto;
      String json = await BaseServiceLivro.uploadFoto(metodo, file);

      final mapResult = convert.json.decode(json);
      final result = ResultWeb<PathImage>.fromJson(mapResult);
      return result;
    } catch (error) {
      return ResultWeb<PathImage>(
      success: false,
      erros: error is SocketException
          ? "Internet indisponível. Por favor verifique sua conexão! $error"
          : "Erro Genério $error");
    }
  }

  Future<ResultWebBook<Book>> obterPorIsbn(String isbn) async {
    try {
      String json = await BaseServiceLivro.obterIsbn('book/isbn/$isbn?key=V7O7NTODWXiyal34rdczw');

      final mapResult = convert.json.decode(json);
      final result = ResultWebBook<Book>.fromJson(mapResult);
      return result;
    } catch (error) {
      return ResultWebBook<Book>(
      success: false,
      erros: error is SocketException
          ? "Internet indisponível. Por favor verifique sua conexão! $error"
          : "Erro Genério $error");
    }
  }

  Future<ResultWeb<bool>> excluirLivro(int id) async {
    try {
      String json = await BaseServiceLivro.excluir("livros/deletar-livro/$id");
      final mapProdutos = convert.json.decode(json);
      final produtos = ResultWeb<bool>.fromJson(mapProdutos);
      return produtos;
    } catch (error) {
      return ResultWeb<bool>(
      erros: error is SocketException
          ? "Internet indisponível. Por favor verifique sua conexão! $error"
          : "Erro Genério $error");
    }
  }

  static Future<String> uploadFirebaseStorage(String titulo, File file) async {
    print("Upload to Storage $file");
    var name = removerCaracteres(titulo);
    String fileName = path.basename(name);
    final storageRef = FirebaseStorage.instance.ref().child(fileName);

    final task = await storageRef.putFile(file);
    final String urlFoto = await task.ref.getDownloadURL();
    print("Storage > $urlFoto");
    return urlFoto;
  }

  static String removerCaracteres(String texto) {
    var novo = texto.toLowerCase().replaceAll("\s+", "_");
    novo = texto.toLowerCase().replaceAll(" ", "_");
    novo = novo.replaceAll("â", "a");
    novo = novo.replaceAll("à", "a");
    novo = novo.replaceAll("á", "a");
    novo = novo.replaceAll("ã", "a");
    novo = novo.replaceAll("è", "e");
    novo = novo.replaceAll("é", "e");
    novo = novo.replaceAll("ê", "e");
    novo = novo.replaceAll("í", "i");
    novo = novo.replaceAll("ì", "i");
    novo = novo.replaceAll("î", "i");
    novo = novo.replaceAll("ó", "o");
    novo = novo.replaceAll("ò", "o");
    novo = novo.replaceAll("ô", "o");
    novo = novo.replaceAll("õ", "o");
    novo = novo.replaceAll("ú", "u");
    novo = novo.replaceAll("ù", "u");
    novo = novo.replaceAll("û", "u");
    novo = novo.replaceAll("-", "_");
    novo = novo.replaceAll("@", "_");
    novo = novo.replaceAll("!", "_");
    novo = novo.replaceAll("\$", "_");
    novo = novo.replaceAll("%", "_");
    novo = novo.replaceAll("¨", "_");
    novo = novo.replaceAll("&", "_");
    novo = novo.replaceAll("*", "_");
    novo = novo.replaceAll("(", "_");
    novo = novo.replaceAll(")", "_");
    novo = novo.replaceAll("[", "_");
    novo = novo.replaceAll("]", "_");
    novo = novo.replaceAll("{", "_");
    novo = novo.replaceAll("}", "_");
    novo = novo.replaceAll("´", "_");
    novo = novo.replaceAll("`", "_");
    novo = novo.replaceAll("+", "_");
    novo = novo.replaceAll("=", "_");
    novo = novo.replaceAll("/", "_");
    novo = novo.replaceAll("\\", "_");
    novo = novo.replaceAll("|", "_");
    novo = novo.replaceAll(",", "_");
    novo = novo.replaceAll(".", "");
    novo = novo.replaceAll("?", "_");
    novo = novo.replaceAll("ç", "c");
    novo = novo.replaceAll(":", "");
    novo = novo.replaceAll(";", "");

    return novo;
  }
}
