import 'package:bookify_mobile/faq/models/questionanswer.dart';
import 'package:http/http.dart' as http;
import 'package:bookify_mobile/authentication/login.dart';
import 'dart:convert';

import 'package:bookify_mobile/faq/models/question.dart';

Future<List<QuestionAnswer>> fetchQuestionAnswer(int idbuku) async {
  // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
  var url = Uri.parse('https://bookify-b08-tk.pbp.cs.ui.ac.id/FAQ/get_questions_answers_filtered_json/$idbuku/');
  // var url = Uri.parse('http://127.0.0.1:8000/FAQ/get_questions_answers_filtered_json/$idbuku/');
  var response = await http.get(
    url,
    // "Access-Control-Allow-Origin": "*",
    headers: {
      "Content-Type": "application/json",
      // "Access-Control-Allow-Origin": "*",
    },
  );
  // print(response.bodyBytes);
  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));
  // melakukan konversi data json menjadi object Item
  List<QuestionAnswer> list_book = [];
  // print(data);
  for (var d in data) {
    if (d != null) {
      list_book.add(QuestionAnswer.fromJson(d));
    }
  }
  return list_book;
}