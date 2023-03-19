class Book {
  Title? title;
  Isbn? isbn;
  Isbn13? isbn13;
  ImageUrl? imageUrl;
  PublicationYear? publicationYear;
  IsEbook? isEbook;
  Description? description;
  AverageRating? averageRating;
  NumPages? numPages;
  Format? format;
  EditionInformation? editionInformation;
  RatingsCount? ratingsCount;
  List<Author>? autores;
  Author? autor;

  Book({ this.title,
    this.isbn,
    this.isbn13,
    this.imageUrl,
    this.publicationYear,
    this.isEbook,
    this.description,
    this.averageRating,
    this.numPages,
    this.format,
    this.editionInformation,
    this.ratingsCount,
    this.autores});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: Title.parseData(json),
      isbn: Isbn.parseData(json),
      isbn13: Isbn13.parseData(json),
      imageUrl: ImageUrl.parseData(json),
      publicationYear: PublicationYear.parseData(json),
      isEbook: IsEbook.parseData(json),
      description: Description.parseData(json),
      averageRating: AverageRating.parseData(json),
      numPages: NumPages.parseData(json),
      format: Format.parseData(json),
      editionInformation: EditionInformation.parseData(json),
      ratingsCount: RatingsCount.parseData(json),
      autores: parseAuthors(json),
    );
  }

  static Book? parseData(json) {
    if (json != null) {
      var book = Book.fromJson(json['book']);
      return book;
    }
    return null;
  }

  static  parseAuthors(json) {
    if (json != null) {
      var aut = Author.fromJson1(json['authors']);
      return aut;
    }
    return null;
  }
}

class Title {
  String? titulo;

  Title({ this.titulo,});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
      titulo: json['\$'] != null ? json['\$'] : json['__cdata'],
    );
  }

  static Title? parseData(json) {
    if (json != null) {
      var titulo = Title.fromJson(json['title']);
      return titulo;
    }
    return null;
  }
}

class Isbn {
  String? isbn;

  Isbn({ this.isbn,});

  factory Isbn.fromJson(Map<String, dynamic> json) {
    return Isbn(
      isbn: json['\$'] != null ? json['\$'] : json['__cdata'],
    );
  }

  static Isbn? parseData(json) {
    if (json != null) {
      var isbn = Isbn.fromJson(json['isbn']);
      return isbn;
    }
    return null;
  }
}

class Isbn13 {
  String? isbn13;

  Isbn13({ this.isbn13,});

  factory Isbn13.fromJson(Map<String, dynamic> json) {
    return Isbn13(
      isbn13: json['\$'] != null ? json['\$'] : json['__cdata'],
    );
  }

  static Isbn13? parseData(json) {
    if (json != null) {
      var isbn13 = Isbn13.fromJson(json['isbn13']);
      return isbn13;
    }
    return null;
  }
}

class ImageUrl {
  String? url;

  ImageUrl({ this.url,});

  factory ImageUrl.fromJson(Map<String, dynamic> json) {
    return ImageUrl(
      url: json['\$'] != null ? json['\$'] : json['__cdata'],
    );
  }

  static ImageUrl? parseData(json) {
    if (json != null) {
      var url = ImageUrl.fromJson(json['image_url']);
      return url;
    }
    return null;
  }
}

class PublicationYear {
  String? publicacao;

  PublicationYear({ this.publicacao,});

  factory PublicationYear.fromJson(Map<String, dynamic> json) {
    return PublicationYear(
      publicacao: json['\$'] != null ? json['\$'] : json['__cdata'],
    );
  }

  static PublicationYear? parseData(json) {
    if (json != null) {
      var ano = PublicationYear.fromJson(json['publication_year']);
      return ano;
    }
    return null;
  }
}

class IsEbook {
  String? ebook;

  IsEbook({ this.ebook,});

  factory IsEbook.fromJson(Map<String, dynamic> json) {
    return IsEbook(
      ebook: json['\$'] != null ? json['\$'] : json['__cdata'],
    );
  }

  static IsEbook? parseData(json) {
    if (json != null) {
      var ebook = IsEbook.fromJson(json['is_ebook']);
      return ebook;
    }
    return null;
  }
}

class Description {
  String? descricao;

  Description({ this.descricao,});

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(
      descricao: json['\$'] != null ? json['\$'] : json['__cdata'],
    );
  }

  static Description? parseData(json) {
    if (json != null) {
      var descricao = Description.fromJson(json['description']);
      return descricao;
    }
    return null;
  }
}

class AverageRating {
  String? classificacao;

  AverageRating({ this.classificacao,});

  factory AverageRating.fromJson(Map<String, dynamic> json) {
    return AverageRating(
      classificacao: json['\$'] != null ? json['\$'] : json['__cdata'],
    );
  }

  static AverageRating? parseData(json) {
    if (json != null) {
      var classificacao = AverageRating.fromJson(json['average_rating']);
      return classificacao;
    }
    return null;
  }
}

class NumPages {
  String? paginas;

  NumPages({ this.paginas,});

  factory NumPages.fromJson(Map<String, dynamic> json) {
    return NumPages(
      paginas: json['\$'] != null ? json['\$'] : json['__cdata'],
    );
  }

  static NumPages? parseData(json) {
    if (json != null) {
      var paginas = NumPages.fromJson(json['num_pages']);
      return paginas;
    }
    return null;
  }
}

class Format {
  String? formato;

  Format({ this.formato,});

  factory Format.fromJson(Map<String, dynamic> json) {
    return Format(
      formato: json['\$'] != null ? json['\$'] : json['__cdata'],
    );
  }

  static Format? parseData(json) {
    if (json != null) {
      var formato = Format.fromJson(json['format']);
      return formato;
    }
    return null;
  }
}

class EditionInformation {
  String? edicao;

  EditionInformation({ this.edicao,});

  factory EditionInformation.fromJson(Map<String, dynamic> json) {
    return EditionInformation(
      edicao: json['\$'] != null ? json['\$'] : json['__cdata'],
    );
  }

  static EditionInformation? parseData(json) {
    if (json != null) {
      var edicao = EditionInformation.fromJson(json['edition_information']);
      return edicao;
    }
    return null;
  }
}

class RatingsCount {
  String? cdata;

  RatingsCount({ this.cdata,});

  factory RatingsCount.fromJson(Map<String, dynamic> json) {
    return RatingsCount(
      cdata: json['\$'] != null ? json['\$'] : json['__cdata'],
    );
  }

  static RatingsCount? parseData(json) {
    if (json != null) {
      var avaliacao = RatingsCount.fromJson(json['ratings_count']);
      return avaliacao;
    }
    return null;
  }
}

class Author {
  Funcao? funcao;
  Name? nome;

  Author({ this.nome, this.funcao});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      nome: json['name'] != null ? Name.parseData(json) : null,
      funcao: json['role'] != null ? Funcao.parseData(json) : null,
    );
  }

  static List<Author> fromJson1(Map<String, dynamic> json) {
    List<Author> autores = [];

    if(json["author"] is List) {
      List<Author> list = [];
      list = json['author'].cast<Author>();
      return list;
    }
    var autor = Author.fromJson(json["author"]);
    autores.add(autor);
    return autores;
  }

  static Author? parseData(json) {
    if (json != null) {
      var autor = Author.fromJson(json['author']);
      return autor;
    }
    return null;
  }

  static List<Author?>? parseAuthors(json) {
    if (json != null) {
      var list = json['author'] as List;
      var livros = list.map((dat) => Author.parseData(dat)).toList();
      return livros;
    }
    return null;
  }
}

class Name {
  String? cdata;

  Name({ this.cdata,});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      cdata: json['\$'] != null ? json['\$'] : json['__cdata'],
    );
  }

  static Name? parseData(json) {
    if (json != null) {
      var nome = Name.fromJson(json['name']);
      return nome;
    }
    return null;
  }
}

class Funcao {
  String? cdata;

  Funcao({ this.cdata,});

  factory Funcao.fromJson(Map<String, dynamic> json) {
    return Funcao(
      cdata: json['\$'] != null ? json['\$'] : json['__cdata'],
    );
  }

  static Funcao? parseData(json) {
    if (json != null) {
      var funcao = Funcao.fromJson(json['role']);
      return funcao;
    }
    return null;
  }
}