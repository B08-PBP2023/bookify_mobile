// To parse this JSON data, do
//
//     final pinjam = pinjamFromJson(jsonString);

import 'dart:convert';

List<Pinjam> pinjamFromJson(String str) => List<Pinjam>.from(json.decode(str).map((x) => Pinjam.fromJson(x)));

String pinjamToJson(List<Pinjam> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pinjam {
    String model;
    int pk;
    Fields fields;

    Pinjam({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Pinjam.fromJson(Map<String, dynamic> json) => Pinjam(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String title;
    int idBook;
    String authors;
    String languageCode;
    int numPages;
    String publicationDate;
    String publisher;
    int user;

    Fields({
        required this.title,
        required this.idBook,
        required this.authors,
        required this.languageCode,
        required this.numPages,
        required this.publicationDate,
        required this.publisher,
        required this.user,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        idBook: json["id_book"],
        authors: json["authors"],
        languageCode: json["language_code"],
        numPages: json["num_pages"],
        publicationDate: json["publication_date"],
        publisher: json["publisher"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "id_book": idBook,
        "authors": authors,
        "language_code": languageCode,
        "num_pages": numPages,
        "publication_date": publicationDate,
        "publisher": publisher,
        "user": user,
    };
}

enum LanguageCode {
    ENG,
    EN_US,
    FRE
}

final languageCodeValues = EnumValues({
    "eng": LanguageCode.ENG,
    "en-US": LanguageCode.EN_US,
    "fre": LanguageCode.FRE
});

enum Model {
    PINJAM_BUKU_BUKU
}

final modelValues = EnumValues({
    "pinjamBuku.buku": Model.PINJAM_BUKU_BUKU
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}