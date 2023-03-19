import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:xml2json/xml2json.dart';

class HttpResponseService {
  static Future<String> get(String _authority, String metodo, bool authorization, {Map<String, String>? map}) async {
    Uri _uri;

    if (map != null) {
      _uri = Uri.http(_authority, '/api/$metodo', map);
    } else {
      _uri = Uri.http(_authority, '/api/$metodo');
    }

    var response = await http.get(_uri, headers: _getHeader(_uri, authorization)).timeout(Duration(seconds: 15), onTimeout: _onTimeOut);
    return obterJson(response);
  }

  static Future<String> getIsbn(String metodo, bool authorization, {Map<String, String>? map}) async {
    Uri _uri;

    if (map != null) {
      _uri = Uri.http('goodreads.com', '/$metodo', map);
    } else {
      _uri = Uri.http('goodreads.com', '/$metodo');
    }

    var response = await http.get(_uri, headers: _getHeader(_uri, authorization)).timeout(Duration(seconds: 15), onTimeout: _onTimeOut);

    String json = response.body;

    var bookshelfXml = json;
    final Xml2Json myTransformer = Xml2Json();

    // Parse a simple XML string
    myTransformer.parse(bookshelfXml);
    // Transform to JSON using Badgerfish
    json = myTransformer.toBadgerfish();

    if (json.isEmpty) {
      json = _obterErroJson(json, response);
    }
    return json;
  }

  static Future<String> post1(String _authority, String metodo, bool authorization, {Map? map, Object? value}) async {
    final _uri = Uri.http(_authority, "/api/$metodo");
    final headers = _getHeader(_uri, authorization);
    http.Response response;

    if (map != null) {
      final body = convert.json.encode(map);
      response = await http.post(_uri, headers: headers, body: body).timeout(Duration(seconds: 15), onTimeout: _onTimeOut);
    } else if (value != null) {
      final body = convert.json.encode(value);
      response = await http.post(_uri, headers: headers, body: body).timeout(Duration(seconds: 15), onTimeout: _onTimeOut);
    } else {
      response = await http.post(_uri, headers: headers).timeout(Duration(seconds: 15), onTimeout: _onTimeOut);
    }
    return obterJson(response);
  }

  static Future<String> uploadImagem(String _authority, String metodo, File file) async {
    final _uri = Uri.http(_authority, "/api/$metodo");
    var stream = new http.ByteStream(file.openRead());
    var length = await file.length();
    var request = new http.MultipartRequest("POST", _uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length, filename: basename(file.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    String json = await response.stream.bytesToString();

    if (json.isEmpty) {
      json = _obterErroJson(json, response);
    }
    return json;
  }

  static Future<String> put(String _authority, String metodo, bool authorization, {Map? map, Object? value}) async {
    final _uri = Uri.http(_authority, "/api/$metodo");
    final headers = _getHeader(_uri, authorization);
    http.Response response;

    if (map != null) {
      final body = convert.json.encode(map);
      response = await http.put(_uri, headers: headers, body: body).timeout(Duration(seconds: 15), onTimeout: _onTimeOut);
    } else if (value != null) {
      final body = convert.json.encode(value);
      response = await http.put(_uri, headers: headers, body: body).timeout(Duration(seconds: 15), onTimeout: _onTimeOut);
    } else {
      response = await http.put(_uri, headers: headers).timeout(Duration(seconds: 15), onTimeout: _onTimeOut);
    }

    return obterJson(response);
  }

  static Future<String> path1(String _authority, String metodo, bool authorization, {Map? map}) async {
    final _uri = Uri.http(_authority, "/api/$metodo");
    final headers = _getHeader(_uri, authorization);
    final body = convert.json.encode(map);
    final response = await http.patch(_uri, headers: headers, body: body).timeout(Duration(seconds: 15), onTimeout: _onTimeOut);

    return obterJson(response);
  }

  static Future<String> delete(String _authority, String metodo, bool authorization) async {
    final _uri = Uri.http(_authority, "/api/$metodo");
    final headers = _getHeader(_uri, authorization);
    final response = await http.delete(_uri, headers: headers).timeout(Duration(seconds: 15), onTimeout: _onTimeOut);

    return obterJson(response);
  }

  static String obterJson(http.Response response) {
    String json = response.body;

    if (json.isEmpty) {
      json = _obterErroJson(json, response);
    }
    return json;
  }

  static _getHeader(Uri _uri, bool authorization) {
    if (authorization) {
      return {
        HttpHeaders.contentTypeHeader: 'application/json'
      };
    } else {
      return {HttpHeaders.contentTypeHeader: 'application/json'};
    }
  }

  static FutureOr<http.Response> _onTimeOut() {
    throw SocketException("Não foi possível se comunicar com o servidor.");
  }

  static _obterErroJson(json, response) {
    if (json == "") {
      switch (response.statusCode) {
        case 400:
          return "{\"success\": false,\"errors\":[\"Usuário não autorizado\"]}";
          break;
        case 401:
          return "{\"success\": false,\"errors\": [\"Usuário sem permissão\"]}";
          break;
        case 403:
          return "{\"success\": false,\"errors\": [\"Usuário sem permissão\"]}";
          break;
        case 404:
          return "{\"success\": false,\"errors\": [\"Nenhum dado localizado\"]}";
          break;
      }
      return "{\"success\": false,\"errors\": [\"Erro ${response.statusCode}\"]}";
    }
  }
}
//260
