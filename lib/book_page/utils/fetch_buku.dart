import 'package:http/http.dart' as http;
import 'package:bookify_mobile/authentication/login.dart';
import 'dart:convert';

import 'package:bookify_mobile/book_page/models/buku.dart';

Future<List<Buku>> fetchBook(String judul) async {
  // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
  var url;
  if(judul == "") {
    url = Uri.parse('https://bookify-b08-tk.pbp.cs.ui.ac.id/pinjamBuku/get_books/');
  } else {
    url = Uri.parse('https://bookify-b08-tk.pbp.cs.ui.ac.id/pinjamBuku/get_books_by_judul/$judul/');
  }
  // var url = Uri.parse('http://127.0.0.1:8000/pinjamBuku/get_books/');

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
  List<Buku> list_book = [];
  // print(data);
  for (var d in data) {
    if (d != null) {
      list_book.add(Buku.fromJson(d));
    }
  }
  return list_book;
}