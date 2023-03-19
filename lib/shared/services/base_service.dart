import 'dart:async';
import 'dart:io';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:livros/shared/services/api_response.dart';
import 'package:livros/shared/services/http_response.dart.dart';
import 'package:livros/shared/services/model/path_image.dart';
import 'package:livros/shared/services/model/preferences.dart';
import 'package:path/path.dart' as path;

class BaseServiceLivro {
  static String _authority = '';

  static Future<String> obterUrl() => Preferences.obterUrl();

  static Future<String> obter(String metodo, {Map<String, String>? map}) async {
    _authority = await obterUrl();
    return HttpResponseService.get(_authority, metodo, false, map: map);
  }

  static Future<String> obterComAutorizacao(String metodo, {Map<String, String>? map}) async {
    _authority = await obterUrl();
    return HttpResponseService.get(_authority, metodo, true, map: map);
  }

  static Future<String> obterIsbn(String metodo, {Map<String, String>? map}) async {
    return HttpResponseService.getIsbn(metodo, true, map: map);
  }

  static Future<String> enviar(String metodo, {Map<String, String>? map, Object? value}) async {
    _authority = await obterUrl();
    return HttpResponseService.post1(_authority, metodo, false, map: map, value: value);
  }

  static Future<String> enviarComAutorizacao(String metodo, {Map<String, String>? map, Object? value}) async {
    _authority = await obterUrl();
    return HttpResponseService.post1(_authority, metodo, true, map: map, value: value);
  }

  static Future<String> atualizarComAutorizacao(String metodo, {Map<String, String>? map, Object? value}) async {
    _authority = await obterUrl();
    return HttpResponseService.put(_authority, metodo, true, map: map, value: value);
  }

  static Future<String> uploadFoto(String metodo, File file) async {
    _authority = await obterUrl();
    return HttpResponseService.uploadImagem(_authority, metodo, file);
  }

  // static Future<ApiResponse<PathImage>> uploadFotoLivro(String id, File file) async {
  //   try {
  //     _authority = await obterUrl();
  //     var bytes = await file.readAsBytes();
  //     var base64 = convert.base64Encode(bytes);
  //     var name = path.basename(file.path);
  //     var extension = '.jpg';
  //
  //     if (name.length > 4) {
  //       extension = name.substring(name.length - 4);
  //     }
  //
  //     var params = {
  //       "base64image": base64
  //     };
  //
  //     String json = convert.jsonEncode(params);
  //
  //     final headers = {
  //       "content-type": "application/json",
  //     };
  //
  //     final _uri = Uri.http('$_authority', "/api/ui.pages.livros/upload-base64/$id/$extension");
  //     http.Response response = await http
  //         .post(_uri, body: json, headers: headers)
  //         .timeout(Duration(seconds: 120), onTimeout: _onTimeOut);
  //
  //     final mapResult = convert.json.decode(response.body);
  //     final result = PathImage.parseString(mapResult);
  //
  //     return ApiResponse.ok(result: result);
  //   } catch (error, exception) {
  //     print("Erro ao fazer upload: $error - $exception");
  //     return ApiResponse.error(msg: "Não foi possível fazer o upload");
  //   }
  // }

  // static Future<ApiResponse<PathImage>> uploadFotoLivroNovo(String titulo,  File file) async {
  //   try {
  //     _authority = await obterUrl();
  //     var bytes = await file.readAsBytes();
  //     var base64 = convert.base64Encode(bytes);
  //     var name = path.basename(file.path);
  //     var extension = '.jpg';
  //
  //     if (name.length > 4) {
  //       extension = name.substring(name.length - 4);
  //     }
  //
  //     var params = {
  //       "base64image": base64
  //     };
  //
  //     String json = convert.jsonEncode(params);
  //
  //     final headers = {
  //       "content-type": "application/json",
  //     };
  //
  //     final _uri = Uri.http('$_authority', "/api/ui.pages.livros/upload-base64-novo/$titulo/$extension");
  //     http.Response response = await http
  //         .post(_uri, body: json, headers: headers)
  //         .timeout(Duration(seconds: 120), onTimeout: _onTimeOut);
  //
  //     final mapResult = convert.json.decode(response.body);
  //     final result = PathImage.parseString(mapResult);
  //
  //     return ApiResponse.ok(result: result);
  //   } catch (error, exception) {
  //     print("Erro ao fazer upload: $error - $exception");
  //     return ApiResponse.error(msg: "Não foi possível fazer o upload");
  //   }
  // }

  static Future<String> excluir(String metodo) async {
    _authority = await obterUrl();
    return HttpResponseService.delete(_authority, metodo, false);
  }

  static FutureOr<http.Response> _onTimeOut() {
    throw Exception("Não foi possível se comunicar com o servidor.");
  }
}
