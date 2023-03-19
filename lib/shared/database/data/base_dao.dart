import 'package:livros/shared/database/data/entity.dart';
import 'package:livros/shared/database/data/livro_db.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDAO<T extends Entity> {
  Future<Database?> get db => LivroDB.getInstance().db;

  String get tableName;

  T fromJson(Map<String, dynamic> map);

  Future<bool> salvar(T entity) async {
    return entity.iD == null ? _inserir(entity) : _atualizar(entity);
  }

  Future<bool> _inserir(T entity) async {
    try {
      var dbClient = await db;
      var id = await dbClient?.insert(tableName, entity.toMapDB()) ?? 0;
      return id > 0;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> inserirComId(T entity) async {
    try {
      var dbClient = await db;
      var id = await dbClient?.insert(tableName, entity.toMapDB()) ?? 0;
      return id > 0;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<int?> inserirEObterId(T entity) async {
    try {
      var dbClient = await db;
      var id = await dbClient?.insert(tableName, entity.toMapDB()) ?? 0;
      return id;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> _atualizar(T entity) async {
    try {
      var dbClient = await db;

      var linha = await dbClient?.update(tableName, entity.toMapDB(),
          where: '_id = ?', whereArgs: [entity.iD]) ?? 0;
      return linha > 0;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<T?> obterPorId(int? id) async {
    try {
      final dbClient = await db;
      final map =
          await dbClient?.query(tableName, where: '_id = ?', whereArgs: [id]);

      if (map != null && map.isNotEmpty) {
        return fromJson(map.first);
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<T>> obterTodos() async {
    try {
      final dbClient = await db;
      final map = await dbClient?.query(tableName);

      if (map != null && map.isNotEmpty) {
        for (Map<String, dynamic> m in map) {
          fromJson(m);
        }
        return map.map<T>((json) => fromJson(json)).toList();
      }
      return [];
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<List<T>> obterTodosPorId() async {
    try {
      final dbClient = await db;
      final map = await dbClient?.rawQuery("SELECT * FROM $tableName l "
          "ORDER BY l._id;");

      if (map != null && map.isNotEmpty) {
        for (Map<String, dynamic> m in map) {
          fromJson(m);
        }
        return map.map<T>((json) => fromJson(json)).toList();
      }
      return [];
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<bool> deletar(int? id) async {
    try {
      final dbClient = await db;
      final deletou = await dbClient?.delete(tableName, where: '_id = ?', whereArgs: [id]) ?? 0;
      return  deletou > 0;
    } catch (error){
      print(error);
      return false;
    }
  }

  Future<bool> deletarTodos() async {
    try {
      final dbClient = await db;
      final deletou = await dbClient?.delete(tableName) ?? 0;
      return deletou > 0;
    } catch (error){
      print(error);
      return false;
    }
  }
}
