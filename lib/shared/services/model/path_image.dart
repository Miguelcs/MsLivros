class PathImage {
  String? link;
  String? path;

  PathImage(
      {this.link,
        this.path,});

  factory PathImage.fromJson(Map<String, dynamic> json) {
    print(json);
    return PathImage(
      link: json['link'] as String,
      path: json['path'] as String,
    );
  }

  static PathImage parseData1(json) {
    var pat = json['data'];
    PathImage pathImage = PathImage.fromJson(pat);
    return pathImage;
  }

  static List<PathImage> parseData(json) {
    var list = json['data'] as List;
    List<PathImage> livros = list.map((dat) => PathImage.fromJson(dat)).toList();
    return livros;
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "link": link,
      "path": path,
    };
    return map;
  }
}