import 'dart:convert';
import 'package:bookify_mobile/book_page/models/buku.dart';
import 'package:flutter/material.dart';
import 'package:bookify_mobile/book_page/utils/fetch_buku.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bookify_mobile/pinjamBuku/utils/fetch_borrowed_book.dart';
import 'package:bookify_mobile/homepage/drawer.dart';
import 'package:bookify_mobile/pinjamBuku/models/pinjam.dart';
import 'package:bookify_mobile/pinjamBuku/screen/borrowed_book.dart';
import 'package:bookify_mobile/profilUser/models/favorit_model.dart';

class PinjamBuku extends StatefulWidget {
  const PinjamBuku({Key? key, required this.username}) : super(key: key);
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
    //var url = Uri.parse('https://bookify-b08-tk.pbp.cs.ui.ac.id/pinjamBuku/show_borrow_books/');
    var url = Uri.parse("https://bookify-b08-tk.pbp.cs.ui.ac.id/pinjamBuku/get_books_by_user_flutter/");
    var response = await request.get(
      url.toString(),
    );

    List<Pinjam> bukuPinjaman = [];
    if (response['status'] == 'success') {
      var result = response;
      for (var d in result["data"]) {
        if (d != null) {
          bukuPinjaman.add(Pinjam.fromJson(d));
        }
      }
    }
    return bukuPinjaman;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Buku"),
      ),
      drawer: buildDrawer(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.blueAccent, Colors.blueGrey],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: TextField(
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
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Masukkan judul buku yang ingin dicari!",
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.blueAccent,
                ),
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LIST BUKU YANG DIPINJAM',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                FutureBuilder<List<Pinjam>>(
                  future: fetchBorrowedBooks(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              isThreeLine: true,
                              title: Text(snapshot.data![index].title),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Penulis: ${snapshot.data![index].authors}",
                                  ),
                                  Text(
                                    "Kode Bahasa: ${snapshot.data![index].languageCode}",
                                  ),
                                  Text(
                                    "Jumlah Halaman: ${snapshot.data![index].numPages.toString()}",
                                  ),
                                  Text(
                                    "Tanggal Publikasi: ${snapshot.data![index].publicationDate}",
                                  ),
                                  Text(
                                    "Penerbit: ${snapshot.data![index].publisher}",
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final request = context.read<CookieRequest>();

                                      var url = Uri.parse(
                                        "https://bookify-b08-tk.pbp.cs.ui.ac.id/pinjamBuku/delete_pinjaman_flutter/${snapshot.data![index].idBook}/" ,
                                      
                                      );

                                      var response = await request.post(
                                        url.toString(),
                                        {},
                                      );

                                      var result = response;

                                      final snackBar = SnackBar(
                                        content: Text(result['msg']),
                                        duration: Duration(seconds: 2),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      setState(() {});
                                    },
                                    child: Text("Kembalikan Buku"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder(
                future: fetchBook(judul),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (!snapshot.hasData) {
                      return Column(
                        children: const [
                          Text(
                            "Tidak ada buku :(",
                            style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                          ),
                          SizedBox(height: 8),
                        ],
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => InkWell(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: const [
                                BoxShadow(color: Colors.black, blurRadius: 2.0),
                              ],
                            ),
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
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "${snapshot.data![index].fields.languageCode}",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "${snapshot.data![index].fields.numPages}",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "${snapshot.data![index].fields.publicationDate}",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 5),


                                Text(
                                  "${snapshot.data![index].fields.publisher}",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                

                                ElevatedButton(
                              onPressed: () async {
                                try {
                                  var url = Uri.parse(
                                      "https://bookify-b08-tk.pbp.cs.ui.ac.id/pinjamBuku/borrow_books_flutter/${snapshot.data![index].pk}/");
                                  var response = await request.post(
                                    url.toString(),
                                    {}
                                  );

                                  if (response['status'] == 'success') {
                                    var result = response;
                                    final snackBar = SnackBar(
                                      content: Text(result['msg']),
                                      duration: Duration(seconds: 2),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);

                                    // Return selected book data to the previous page
                                    // Navigator.pop(
                                    //   context,
                                    //   snapshot.data![index].fields.toJson(),
                                    // );
                                  } else if (response['status'] == 'failed') {
                                    var result = response;

                                    final snackBar = SnackBar(
                                      content: Text(result['msg']),
                                      duration: Duration(seconds: 2),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    final snackBar = SnackBar(
                                      content: Text("Error"),
                                      duration: Duration(seconds: 2),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                } catch (e) {
                                  print(e.toString());
                                }
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
                            //     builder: (context) => SingleDestination(
                            //       data: snapshot.data![index],
                            //     ),
                            //   ),
                            // );
                          },
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
