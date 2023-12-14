// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

List<Question> questionFromJson(String str) => List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));

String questionToJson(List<Question> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Question {
    String model;
    int pk;
    Fields fields;

    Question({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Question.fromJson(Map<String, dynamic> json) => Question(
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
    String isiPertanyaan;
    int buku;

    Fields({
        required this.isiPertanyaan,
        required this.buku,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        isiPertanyaan: json["isi_pertanyaan"],
        buku: json["buku"],
    );

    Map<String, dynamic> toJson() => {
        "isi_pertanyaan": isiPertanyaan,
        "buku": buku,
    };
}
