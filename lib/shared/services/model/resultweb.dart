import 'package:livros/shared/database/model/livro.dart';
import 'package:livros/shared/services/model/pais_origem.dart';
import 'package:livros/shared/services/model/path_image.dart';

class ResultWeb<T> {
  bool? success;
  T? data;
  String? erros;
  final String? versao;

  ResultWeb({this.success, this.data, this.erros, this.versao});

  factory ResultWeb.fromJson(Map<String, dynamic> json) {
    return ResultWeb(
        success: json['success'],
        data: verificarDados<T>(json),
        erros: json['errors'] != null ? parseData(json) : null,
        versao: json['versao']);
  }

  factory ResultWeb.fromJsonList(Map<String, dynamic> json) {
    return ResultWeb(
        success: json['success'],
        data: verificarDadosList<T>(json),
        erros: json['errors'] != null ? parseData(json) : null,
        versao: json['versao']);
  }

  static String? parseData(json) {
    var list = json['errors'] as List;
    var erros = "";

    if (list != null) {
      for (String erro in list) {
        erros = erro + "\n";
      }
    } else {
      return null;
    }
    return erros;
  }

  static String parseString(json) {
    var list = json['data'] as String;
    return list;
  }

  static verificarDados<T>(json) {
    if (json != null) {
      if (T == String) {
        return parseString(json);
      } else if (T == int) {
        return parseInt(json);
      } else if (T == PathImage) {
        return PathImage.fromJson(json['data']);
      }
    }
    return null;
  }

  static verificarDadosList<T>(json) {
    if (json != null) {
      var typeT = T.toString();
      var typeLivros = <Livro>[].runtimeType.toString();
      var typePaises = <PaisOrigem>[].runtimeType.toString();

      if (typeT == typeLivros) {
        return Livro.fromJsonList(json);
      } else if (typeT == typePaises) {
        return PaisOrigem.fromJsonList(json);
      }
    }
    return null;
  }

  static int parseInt(json) {
    var list = json['data'] as int;
    return list;
  }
}
