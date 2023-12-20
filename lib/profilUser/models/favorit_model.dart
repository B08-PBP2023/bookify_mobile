class FavoriteModel{
  final int userId;
  final int idBook;
  final String authors;
  final String title;
  final String languageCode;
  final int numPages;
  final String publicationDate;
  final String publisher;

  FavoriteModel({
    required this.userId,
    required this.idBook,
    required this.authors,
    required this.title,
    required this.languageCode,
    required this.numPages,
    required this.publicationDate,
    required this.publisher,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    userId: json["user_id"],
    idBook: json["id_book"],
    authors: json["authors"],
    title: json["title"],
    languageCode: json["language_code"],
    numPages: json["num_pages"],
    publicationDate: json["publication_date"],
    publisher: json["publisher"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "id_book": idBook,
    "authors": authors,
    "title": title,
    "language_code": languageCode,
    "num_pages": numPages,
    "publication_date": publicationDate,
    "publisher": publisher,
  };
}