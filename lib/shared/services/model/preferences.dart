import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static String _prefPaginas = "paginas";
  static String _prefUrl = "url";
  static String _prefAlteracaoPaginas = "alteracao-paginas";
  static String _prefISBN = "isbn";
  static String _prefCompra = "compra";
  static String _prefCadastro = "cadastro";
  static String _prefOrdenar = "ordenar";

  static Future<int> obterItensPorPagina() async {
    return _getInt(_prefPaginas);
  }

  static void salvarItensPorPagina(int paginas) {
    _setInt(_prefPaginas, paginas);
  }

  static Future<String> obterUrl() async {
    return _getString(_prefUrl);
  }

  static void salvarUrl(String url) async {
    _setString(_prefUrl, url);
  }

  static Future<bool> obterISBN() async {
    return _getBool(_prefISBN);
  }

  static void salvarISBN(bool isbn) async {
    _setBool(_prefISBN, isbn);
  }

  static Future<bool> obterCompra() async {
    return _getBool(_prefCompra);
  }

  static void salvarCompra(bool compra) async {
    _setBool(_prefCompra, compra);
  }

  static Future<bool> obterAlteracaoPaginas() async {
    return _getBool(_prefAlteracaoPaginas);
  }

  static void salvarAlteracaoPaginas(bool alterou) async {
    _setBool(_prefAlteracaoPaginas, alterou);
  }

  static Future<bool> obterCadastroSite() async {
    return _getBool(_prefCadastro);
  }

  static void salvarCadastroSite(bool cadastro) async {
    _setBool(_prefCadastro, cadastro);
  }

  static Future<int> obterOrdenacao() async {
    return _getInt(_prefOrdenar);
  }

  static void salvarOrdenacao(int ordenar) {
    _setInt(_prefOrdenar, ordenar);
  }





  static Future<bool> _getBool(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static void _setBool(String key, bool b) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setBool(key, b);
  }

  static Future<int> _getInt(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getInt(key) ?? 0;
  }

  static void _setInt(String key, int i) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setInt(key, i);
  }

  static Future<String> _getString(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static void _setString(String key, String s) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, s);
  }
}
