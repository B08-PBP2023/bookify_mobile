import 'package:bookify_mobile/ulasanBuku/models/models_ulasan.dart';
import 'package:bookify_mobile/ulasanBuku/screen/ulasan_page.dart';
import 'package:flutter/material.dart';
import 'package:bookify_mobile/book_page/utils/fetch_buku.dart';
import 'package:bookify_mobile/homepage/drawer.dart';

class DaftarUlasan extends StatefulWidget {
  const DaftarUlasan({Key? key});

  @override
  State<DaftarUlasan> createState() => _DaftarUlasanState();
}

class _DaftarUlasanState extends State<DaftarUlasan> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Buku",
        ),
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
        child: FutureBuilder(
          future: fetchBook(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return const Column(
                  children: [
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
                      margin: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 12,
                      ),
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
                            onPressed: () {
                              // Tindakan yang akan diambil saat tombol ditekan
                              // Misalnya, navigasi ke halaman tambah ulasan
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => TambahUlasanPage()));
                              // Navigasi ke halaman ulasan dengan mengirim objek BookReview
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UlasanPage(ulasan: BookReview(
                              username: "Nama Pengguna Default",
                              nama: "Nama Penulis Default",
                              tanggalReview: "Tanggal Review Default",
                              reviewText: "Ulasan Default",
                              rating: "Rating Default",
                            )),
                          ),
                        );
                            },
                            child: Text("Tambah Ulasan"),
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
    );
  }
}
