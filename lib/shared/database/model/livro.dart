import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livros/shared/database/data/entity.dart';

class Livro extends Entity {
  int? id;
  String? firebaseCodigo;
  String? anoEdicao;
  String? autor;
  String? descricao;
  String? editora;
  int? numeroPaginas;
  String? paisOrigem;
  String? titulo;
  int? status;
  String? isbn10;
  String? isbn13;
  int? numeroEdicao;
  String? dataCompra;
  String? preco;
  String? tag;
  String? link;
  String? subtitulo;
  String? categoria;
  DateTime? dataHoraCriacao;
  DateTime? dataHoraAlteracao;

  Livro({
    this.id,
    this.firebaseCodigo,
    this.anoEdicao,
    this.autor,
    this.descricao,
    this.editora,
    this.numeroPaginas,
    this.paisOrigem,
    this.titulo,
    this.status,
    this.isbn10,
    this.isbn13,
    this.numeroEdicao,
    this.dataCompra,
    this.preco,
    this.tag,
    this.link,
    this.subtitulo,
    this.categoria,
    this.dataHoraCriacao,
    this.dataHoraAlteracao
  });

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      id: json['id'],
      firebaseCodigo: json['firebaseCodigo'],
      anoEdicao: json['anoEdicao'],
      autor: json['autor'],
      descricao: json['descricao'],
      editora: json['editora'],
      numeroPaginas: json['numeroPaginas'],
      paisOrigem: json['paisOrigem'],
      titulo: json['titulo'],
      status: json['status'],
      //status: json['categoria'],
      isbn10: json['isbn10'],
      isbn13: json['isbn13'],
      numeroEdicao: json['numeroEdicao'],
      dataCompra: json['dataCompra'],
      preco: json['preco'],
      link: json['url'],
      subtitulo: json['subtitulo'],
      //categoria: json['categorias'] ?? '',
      //dataHoraCriacao: json['dataHoraCriacao'],
      //dataHoraAlteracao: json['dataHoraAlteracao'],
      categoria: json['categoria'] ?? '',
      //dataHoraCriacao: obterData(json),
      //dataHoraAlteracao: obterData(json),
      dataHoraCriacao: DateTime.now(),
      dataHoraAlteracao: DateTime.now(),
    );
  }

  static obterData(json) {
    if (json['dataHoraCriacao'] != null) {
      if (json['dataHoraCriacao']  is Timestamp) {
        return readTimestamp(json['dataHoraCriacao'] as Timestamp);
      }
      return readTimestamp(json['dataHoraCriacao'] as Timestamp);
    }

    if (json['dataHoraAlteracao'] != null) {
      if (json['dataHoraAlteracao']  is Timestamp) {
        return readTimestamp(json['dataHoraAlteracao']);
      }
      return readTimestamp(json['dataHoraAlteracao'] as Timestamp);
    }
    return null;
  }

  factory Livro.fromJsonDB(Map<String, dynamic> json) {
    return Livro(
      id: json['_id'],
      firebaseCodigo: json['firebase_codigo'],
      anoEdicao: json['ano_edicao'],
      autor: json['autor'],
      descricao: json['descricao'],
      editora: json['editora'],
      numeroPaginas: json['numero_paginas'],
      paisOrigem: json['pais_origem'],
      titulo: json['titulo'],
      status: json['status'],
      isbn10: json['isbn_10'],
      isbn13: json['isbn_13'],
      numeroEdicao: json['numero_edicao'],
      dataCompra: json['data_compra'],
      preco: json['preco'],
      link: json['link'],
      subtitulo: json['subtitulo'],
      categoria: json['categoria'],
      dataHoraCriacao: converterParaData(json['data_hora_criacao']),
      dataHoraAlteracao: converterParaData(json['data_hora_alteracao']),
    );
  }

  static List<Livro>? fromJsonList(json) {
    if (json != null) {
      var list = json['data'] as List;
      List<Livro> livros = list.map((dat) => Livro.fromJson(dat)).toList();
      return livros;
    }
    return null;
  }

  static List<Livro>? parseDataAssets(json) {
    if (json != null) {
      List<Livro> livros = json.map<Livro>((dat) => Livro.fromJson(dat)).toList();
      return livros;
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "firebaseCodigo": firebaseCodigo,
      "anoEdicao": anoEdicao,
      "autor": autor,
      "descricao": descricao,
      "editora": editora,
      "numeroPaginas": numeroPaginas,
      "paisOrigem": paisOrigem,
      "titulo": titulo,
      "status": status,
      //"categoria": status,
      "isbn10": isbn10,
      "isbn13": isbn13,
      "numeroEdicao": numeroEdicao,
      "dataCompra": dataCompra,
      "preco": preco,
      "url": link,
      "subtitulo": subtitulo,
      //"categorias": categoria,
      "categoria": categoria,
      "dataHoraCriacao": converterParaInt(dataHoraCriacao),
      //"dataHoraCriacao": converterParaInt(DateTime.now()),
      //"dataHoraCriacao": Timestamp.fromMillisecondsSinceEpoch(dataHoraCriacao.millisecondsSinceEpoch),
      //"dataHoraAlteracao": converterParaInt(DateTime.now()),
      "dataHoraAlteracao": converterParaInt(dataHoraAlteracao),
      //"dataHoraAlteracao": Timestamp.fromMillisecondsSinceEpoch(dataHoraAlteracao.millisecondsSinceEpoch),
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  @override
  Map<String, dynamic> toMapDB() {
    Map<String, dynamic> map = {
      "firebase_codigo": firebaseCodigo,
      "ano_edicao": anoEdicao,
      "autor": autor,
      "descricao": descricao,
      "editora": editora,
      "numero_paginas": numeroPaginas,
      "pais_origem": paisOrigem,
      "titulo": titulo,
      "status": status,
      "isbn_10": isbn10,
      "isbn_13": isbn13,
      "numero_edicao": numeroEdicao,
      "data_compra": dataCompra,
      "preco": preco,
      "link": link,
      "subtitulo": subtitulo,
      "categoria": categoria,
      "data_hora_criacao": converterParaInt(dataHoraCriacao),
      "data_hora_alteracao": converterParaInt(dataHoraAlteracao),
    };
    if (id != null) {
      map["_id"] = id;
    }
    return map;
  }

  @override
  int get iD => id ?? 0;

  static const String ID = '_id';
  static const String ANO_EDICAO = 'ano_edicao';
  static const String AUTOR = 'autor';
  static const String DESCRICAO = 'descricao';
  static const String EDITORA = 'editora';
  static const String NUMERO_PAGINAS = 'numero_paginas';
  static const String PAIS_ORIGEM = 'pais_origem';
  static const String TITULO = 'titulo';
  static const String SUBTITULO = 'subtitulo';
  static const String FOTO = 'foto';
  static const String STATUS = 'status';
  static const String ISBN_10 = 'isbn_10';
  static const String ISBN_13 = 'isbn_13';
  static const String NUMERO_EDICAO = 'numero_edicao';
  static const String DATA_COMPRA = 'data_compra';
  static const String PRECO = 'preco';

  static DateTime readTimestamp(Timestamp timestamp) {
    var times = timestamp.seconds * 1000;
    var date = DateTime.fromMillisecondsSinceEpoch(times);
    return date;
  }

  static converterParaData(dataHora) {
    return new DateTime.fromMillisecondsSinceEpoch(dataHora);
  }

  static converterParaInt(dataHora) {
    return dataHora.millisecondsSinceEpoch;
  }
}
