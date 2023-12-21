import 'package:http/http.dart' as http;
import 'package:bookify_mobile/authentication/login.dart';
import 'dart:convert';

import 'package:bookify_mobile/pinjamBuku/models/pinjam.dart';

Future<List<Pinjam>> fetchBorrowedBooks(int idBuku) async {
  // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
  
  var url = Uri.parse('https://bookify-b08-tk.pbp.cs.ui.ac.id/pinjamBuku/show_borrow_books/');
  

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
  List<Pinjam> list_book = [];
  // print(data);
  for (var d in data) {
    if (d != null) {
      list_book.add(Pinjam.fromJson(d));
    }
  }
  return list_book;
}