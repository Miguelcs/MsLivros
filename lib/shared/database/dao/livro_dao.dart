import 'package:livros/shared/database/data/base_dao.dart';
import 'package:livros/shared/database/model/livro.dart';
import 'package:sqflite/sqflite.dart';

class LivroDAO extends BaseDAO<Livro> {
  @override
  String get tableName => 'livro';

  @override
  Livro fromJson(Map<String, dynamic> map) {
    return Livro.fromJsonDB(map);
  }

  Future<List<Livro>> obterLivrosPorDescricao(String descricao) async {
    try {
      final dbClient = await db;
      final map = await dbClient?.rawQuery(
          "SELECT * from $tableName WHERE ${Livro.TITULO} LIKE '%$descricao%' OR ${Livro.SUBTITULO} LIKE '%$descricao%'");

      if (map != null && map.isNotEmpty) {
        final livros =
            map.map<Livro>((json) => Livro.fromJsonDB(json)).toList();
        return livros;
      }
      return [];
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<Livro?> obterPorDescricao(String descricao) async {
    try {
      final dbClient = await db;
      final map = await dbClient?.query(tableName,
          where: '${Livro.TITULO} = ?', whereArgs: [descricao]);

      if (map != null && map.isNotEmpty) {
        final livro = Livro.fromJsonDB(map.first);
        return livro;
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<Livro>> obterLivrosPorAutor() async {
    try {
      final dbClient = await db;
      final map = await dbClient?.query(tableName, orderBy: Livro.AUTOR);

      if (map != null && map.isNotEmpty) {
        final livros =
            map.map<Livro>((json) => Livro.fromJsonDB(json)).toList();
        return livros;
      }
      return [];
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<List<Livro>> obterLivrosPorCategoria(int categoria, {ordenar = 1}) async {
    // Categoria -> 1 - Lendo; 2 - Lidos; 3 - Não Lidos
    var ordenacao = Livro.TITULO;

    if (ordenar == 2) {
      ordenacao = Livro.AUTOR;
    } else if (ordenar == 3) {
      ordenacao = Livro.ANO_EDICAO;
    } else if (ordenar == 4) {
      ordenacao = Livro.EDITORA;
    } else if (ordenar == 5) {
      ordenacao = '${Livro.ID} DESC';
    }

    try {
      final dbClient = await db;
      final map = await dbClient?.query(tableName,
          where: '${Livro.STATUS} = ?',
          whereArgs: [categoria],
          orderBy: ordenacao);

      if (map != null && map.isNotEmpty) {
        final livros =
            map.map<Livro>((json) => Livro.fromJsonDB(json)).toList();
        return livros;
      }
      return [];
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<List<Livro>> obterLivrosPorAno() async {
    // Categoria -> 1 - Lendo; 2 - Lidos; 3 - Não Lidos
    try {
      final dbClient = await db;
      final map = await dbClient?.rawQuery(
          'SELECT ${Livro.ANO_EDICAO} FROM $tableName group by "${Livro.ANO_EDICAO}" ORDER BY ${Livro.ANO_EDICAO}');

      if (map != null && map.isNotEmpty) {
        final livros =
            map.map<Livro>((json) => Livro.fromJsonDB(json)).toList();
        return livros;
      }
      return [];
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<double?> obterQtdePorAno(String? ano) async {
    // Categoria -> 1 - Lendo; 2 - Lidos; 3 - Não Lidos
    try {
      final dbClient = await db;
      var value = firstIntValueAno(ano);
      //var value = Sqflite.firstIntValue(await dbClient?.rawQuery('SELECT COUNT(${Livro.ANO_EDICAO}) FROM $tableName WHERE ${Livro.ANO_EDICAO} = $ano'));
      return value.toDouble();
    } catch (error) {
      print(error);
      return null;
    }
  }

  firstIntValueAno(String? ano) async {
    final dbClient = await db;
    return await dbClient?.rawQuery('SELECT COUNT(${Livro.ANO_EDICAO}) FROM $tableName WHERE ${Livro.ANO_EDICAO} = $ano');
  }

  firstIntValueAutor(String? autor) async {
    final dbClient = await db;
    return await dbClient?.rawQuery('SELECT COUNT(${Livro.AUTOR}) FROM $tableName WHERE ${Livro.AUTOR} = $autor');
  }

  Future<double?> obterQtdePorAutor(String? autor) async {
    try {
      final dbClient = await db;
      //return Sqflite.firstIntValue(await dbClient?.rawQuery('SELECT COUNT(${Livro.AUTOR}) FROM $tableName WHERE ${Livro.AUTOR} = "$autor"')).toDouble();
      var value = firstIntValueAutor(autor);
      return value.toDouble();
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<Livro>?> obterLivrosPor(int ordenar) async {
    var ordenacao = Livro.TITULO;

    if (ordenar == 2) {
      ordenacao = Livro.AUTOR;
    } else if (ordenar == 3) {
      ordenacao = Livro.ANO_EDICAO;
    } else if (ordenar == 4) {
      ordenacao = Livro.EDITORA;
    } else if (ordenar == 5) {
      ordenacao = '${Livro.ID} DESC';
    }

    try {
      final dbClient = await db;
      final map = await dbClient?.query(tableName, orderBy: ordenacao);

      if (map != null && map.isNotEmpty) {
        return map.map<Livro>((json) => fromJson(json)).toList();
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<Livro?> obterUltimoRegistro() async {
    try {
      final dbClient = await db;
      final map =
      await dbClient?.query(tableName, orderBy: '${Livro.ID} DESC');

      if (map != null && map.isNotEmpty) {
        final filme = Livro.fromJsonDB(map.first);
        return filme;
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
