// To parse this JSON data, do
//
//     final questionAnswer = questionAnswerFromJson(jsonString);

import 'dart:convert';

List<QuestionAnswer> questionAnswerFromJson(String str) => List<QuestionAnswer>.from(json.decode(str).map((x) => QuestionAnswer.fromJson(x)));

String questionAnswerToJson(List<QuestionAnswer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionAnswer {
    String model;
    int pk;
    Fields fields;

    QuestionAnswer({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory QuestionAnswer.fromJson(Map<String, dynamic> json) => QuestionAnswer(
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
    String isiJawaban;
    int buku;

    Fields({
        required this.isiPertanyaan,
        required this.isiJawaban,
        required this.buku,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        isiPertanyaan: json["isi_pertanyaan"],
        isiJawaban: json["isi_jawaban"],
        buku: json["buku"],
    );

    Map<String, dynamic> toJson() => {
        "isi_pertanyaan": isiPertanyaan,
        "isi_jawaban": isiJawaban,
        "buku": buku,
    };
}
