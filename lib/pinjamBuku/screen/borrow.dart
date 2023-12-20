import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bookify_mobile/book_page/utils/fetch_buku.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bookify_mobile/book_page/utils/fetch_buku.dart';
import 'package:bookify_mobile/homepage/drawer.dart';
import 'package:bookify_mobile/pinjamBuku/models/pinjam.dart';
import 'package:bookify_mobile/pinjamBuku/screen/borrowed_book.dart';

class PinjamBuku extends StatefulWidget {
  const PinjamBuku({super.key,required this.username});
  final String username;

  @override
  State<PinjamBuku> createState() => _PinjamBukuState();
}

class _PinjamBukuState extends State<PinjamBuku> {
  bool value = false;
  String judul = "";

  List<Fields> borrowedBooks = [];

  Future<List<Pinjam>> fetchBorrowedBooks() async {
    final request = context.watch<CookieRequest>();
    var url = Uri.parse('https://bookify-b08-tk.pbp.cs.ui.ac.id/pinjamBuku/show_borrow_books/');
    var response = await request.get(
      url.toString(),
    );

    List<Pinjam> buku_pinjaman = [];
    if (response['status'] == 'success') {
      var result = response;
      for (var d in result["data"]) {
        if (d != null) {
          buku_pinjaman.add(Pinjam.fromJson(d));
        }
      }
    }
    return buku_pinjaman;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.green[100],
        appBar: AppBar(
          title: Text("Daftar Buku",),
        ),
        // menambahkan Drawer untuk navigasi antarhalaman
        drawer: buildDrawer(context),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.blueAccent, Colors.blueGrey])),
          child: Column(children: [
            SizedBox(height: 20,),
            Center(child: TextField(
                        onChanged: (value) {
                          setState(() {
                            judul = value;
                          });
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none),
                            hintText:
                                "Masukkan judul buku yang ingin dicari!",
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: Colors.blueAccent),
              )),
            ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BorrowedBooks (),
                        ),
                      );

                      if (result != null) {
                        setState(() {
                          // favoriteBooks.add(Fields.fromJson(result));
                        });
                        // _showFavoritSnackBar(context);
                      }
                    },
                    child: Text('Buku yang Dipinjam'),
                  ),
                  
            SizedBox(height: 20,),
            Expanded(child: FutureBuilder(
              future: fetchBook(judul),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return Column(
                      children: const [
                        Text(
                          "Tidak ada buku :(",
                          style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => InkWell(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 12),
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black, blurRadius: 2.0)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${snapshot.data![index].fields.title}",
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${snapshot.data![index].fields.authors}",
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${snapshot.data![index].fields.languageCode}",
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${snapshot.data![index].fields.numPages}",
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${snapshot.data![index].fields.publicationDate}",
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${snapshot.data![index].fields.publisher}",
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(height: 5),
                                  const SizedBox(height: 5),
                          ElevatedButton(
                            onPressed: () {
                               

                               ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Buku berhasil dipinjam!'),
                                ),
                              );
                            },
                            child: Text("Pinjam Buku Ini"),
                          ),               
                                  
                                ],
                              ),
                            ),
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => SingleDestination(
                              //             data: snapshot.data![index],
                              //           )),
                              // );
                            }));
                  }
                }
              }),)

          ],)
        ));
  }
}