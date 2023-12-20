import 'dart:math';

class BukuReq {
  final String id;
  String bookTitle;
  String author;
  String language;
  int numPages;
  String publicationDate;
  String penerbit;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookTitle': bookTitle,
      'author': author,
      'language': language,
      'numPages': numPages,
      'publicationDate': publicationDate,
      'penerbit': penerbit,
    };
  }

  factory BukuReq.fromJson(Map<String, dynamic> json) {
    return BukuReq(
      bookTitle: json['bookTitle'] as String,
      author: json['author'] as String,
      language: json['language'] as String,
      numPages: json['numPages'] as int,
      publicationDate: json['publicationDate'] as String,
      penerbit: json['penerbit'] as String,
      id: json['id'] as String, 
    );
  }

  BukuReq({
    String? id,
    required this.bookTitle,
    required this.author,
    required this.language,
    required this.numPages,
    required this.publicationDate,
    required this.penerbit,
  }) : id = id ?? Random().nextInt(999999).toString(); 
}
