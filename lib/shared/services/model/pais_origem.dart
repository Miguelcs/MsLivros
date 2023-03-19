import 'package:livros/ui/widgets/dropdown.dart';

class PaisOrigem extends DropDownItem{
  int? id;
  String? descricao;

  PaisOrigem({
    this.id,
    this.descricao,
  });

  factory PaisOrigem.fromJson(Map<String, dynamic> json) {
    return PaisOrigem(
      id: json['id'] as int,
      descricao: json['descricao'] as String,
    );
  }

  static List<PaisOrigem> fromJsonList(json) {
    var list = json['data'] as List;
    List<PaisOrigem> origens =
    list.map((dat) => PaisOrigem.fromJson(dat)).toList();
    return origens;
  }

  static List<PaisOrigem> origens() {
    var origem = PaisOrigem();
    origem.id = 1;
    origem.descricao = 'Brasil';

    List<PaisOrigem> origens = [];
    origens.add(origem);
    return origens;
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "descricao": descricao,
    };
    if (id != null) {
      map["_id"] = id;
    }
    return map;
  }

  @override
  String text() {
    return descricao ?? '';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PaisOrigem &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              descricao == other.descricao;

  @override
  int get hashCode =>
      id.hashCode ^
      descricao.hashCode;

}
