class VolumeJson {
  final int? totalItems;
  final String? kind;
  final List<Item>? items;

  VolumeJson({this.items, this.kind, this.totalItems});

  factory VolumeJson.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;

    List<Item> itemList = list.map((i) => Item.fromJson(i)).toList();
    print(itemList.length);

    return VolumeJson(
        items: itemList,
        kind: parsedJson['kind'],
        totalItems: parsedJson['totalItems']);
  }
}

class Item {
  final String? kind;
  final String? id;
  final String? etag;
  final String? selfLink;

  final VolumeInfo? volumeinfo;
  final SearchInfo? searchInfo;

  Item({this.kind, this.id, this.etag, this.selfLink, this.volumeinfo, this.searchInfo});

  factory Item.fromJson(Map<String, dynamic> parsedJson) {
    return Item(
        kind: parsedJson['kind'],
        id: parsedJson['id'],
        etag: parsedJson['etag'],
        selfLink: parsedJson['selfLink'],
        volumeinfo: parsedJson['volumeInfo'] != null ? VolumeInfo.fromJson(parsedJson['volumeInfo']) : null,
        searchInfo: parsedJson['searchInfo'] != null
            ? new SearchInfo.fromJson(parsedJson['searchInfo'])
            : null);
  }
}

class VolumeInfo {
  final String? title;
  List<String>? autores;
  final String? description;
  List<IndustryIdentifiers>? isbns;
  final int? pageCount;
  final String? publisher;
  final String? printType;
  final ImageLinks? image;
  final String? publishedDate;
  final List<String>? categorias;

  VolumeInfo(
      {this.printType, this.title, this.publisher, this.image, this.description, this.autores, this.isbns,this.pageCount, this.publishedDate,this.categorias});

  factory VolumeInfo.fromJson(Map<String, dynamic> parsedJson) {

    return VolumeInfo(
      title: parsedJson['title'],
      autores: parsedJson['authors'] != null ? parsedJson['authors'].cast<String>() : null,
      description: parsedJson['description'],
      //isbns: obter(parsedJson['description']),
      pageCount: parsedJson['pageCount'],
      publisher: parsedJson['publisher'],
      categorias: parsedJson['categories'] != null ? parsedJson['categories'].cast<String>() : null,
      printType: parsedJson['printType'],
      publishedDate: parsedJson['publishedDate'],
      image: ImageLinks.fromJson(
        parsedJson['imageLinks'],
      ),

    );
  }

  obter(json) {
    if (json['industryIdentifiers'] != null) {
      isbns = <IndustryIdentifiers>[];
      json['industryIdentifiers'].forEach((v) {
        isbns?.add(new IndustryIdentifiers.fromJson(v));
      });
    }
  }
}

class IndustryIdentifiers {
  String? type;
  String? identifier;

  IndustryIdentifiers({this.type, this.identifier});

  IndustryIdentifiers.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    identifier = json['identifier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['identifier'] = this.identifier;
    return data;
  }
}

class ImageLinks {
  final String? thumb;

  ImageLinks({this.thumb});

  factory ImageLinks.fromJson(Map<String, dynamic> parsedJson) {
    return ImageLinks(thumb: parsedJson != null ? parsedJson['thumbnail'] : null);
  }
}

class ISBN {
  final String? iSBN13;
  final String? type;

  ISBN({this.iSBN13, this.type});

  factory ISBN.fromJson(Map<String, dynamic> parsedJson) {
    return ISBN(
      iSBN13: parsedJson['identifier'],
      type: parsedJson['type'],
    );
  }
}

class SearchInfo {
  String? textSnippet;

  SearchInfo({this.textSnippet});

  SearchInfo.fromJson(Map<String, dynamic> json) {
    textSnippet = json['textSnippet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['textSnippet'] = this.textSnippet;
    return data;
  }
}