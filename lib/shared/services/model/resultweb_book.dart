import 'package:livros/shared/services/model/book.dart';

class ResultWebBook<T> {
  bool? success;
  final T? data;
  String? erros;
  final String? versao;

  ResultWebBook({this.success, this.data, this.erros, this.versao});

  factory ResultWebBook.fromJson(Map<String, dynamic> json) {
    return ResultWebBook(
        data: verificarDados(json),
    );
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

  static verificarDados(json) {
    if (json != null) {
      var jsons = json['GoodreadsResponse'];
      return Book.parseData(jsons);
    }
    return null;
  }
}
