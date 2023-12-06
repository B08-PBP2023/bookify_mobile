// To parse this JSON data, do
//
//     final buku = bukuFromJson(jsonString);

import 'dart:convert';

List<Buku> bukuFromJson(String str) => List<Buku>.from(json.decode(str).map((x) => Buku.fromJson(x)));

String bukuToJson(List<Buku> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Buku {
    Model model;
    int pk;
    Fields fields;

    Buku({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Buku.fromJson(Map<String, dynamic> json) => Buku(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String title;
    String authors;
    LanguageCode languageCode;
    int numPages;
    String publicationDate;
    String publisher;

    Fields({
        required this.title,
        required this.authors,
        required this.languageCode,
        required this.numPages,
        required this.publicationDate,
        required this.publisher,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        authors: json["authors"],
        languageCode: languageCodeValues.map[json["language_code"]]!,
        numPages: json["num_pages"],
        publicationDate: json["publication_date"],
        publisher: json["publisher"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "authors": authors,
        "language_code": languageCodeValues.reverse[languageCode],
        "num_pages": numPages,
        "publication_date": publicationDate,
        "publisher": publisher,
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
