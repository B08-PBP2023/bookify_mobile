import 'package:flutter/material.dart';
import 'edit_profile.dart';
import 'package:bookify_mobile/homepage/drawer.dart';
import 'listbuku_favorit.dart';
import 'package:bookify_mobile/book_page/models/buku.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key});

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  // Data profil
  String nama = "Cilor Maklor";
  String role = "Reguler";
  String tanggalLahir = "01 Januari 1990";
  String description = "cilor maklor adalah kucing kembar";

  List<Fields> favoriteBooks = [];

  void _showFavoritSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Buku ditambahkan ke Favorit!'),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      drawer: buildDrawer(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DataTable(
                    dataRowHeight: 50.0,
                    columns: [
                      DataColumn(
                        label: Text(
                          'Attribute',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Value',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('Nama')),
                        DataCell(Text(nama)),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Role')),
                        DataCell(Text(role)),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Tanggal Lahir')),
                        DataCell(Text(tanggalLahir)),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Deskripsi')),
                        DataCell(Text(description)),
                      ]),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilPage(
                            initialTanggalLahir: tanggalLahir,
                            initialDescription: description,
                            onUpdate: (newTanggalLahir, newDescription) {
                              setState(() {
                                tanggalLahir = newTanggalLahir;
                                description = newDescription;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: Text('Edit Profil'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DaftarBukuFavorit(),
                        ),
                      );

                      if (result != null) {
                        setState(() {
                          favoriteBooks.add(Fields.fromJson(result));
                        });
                        _showFavoritSnackBar(context);
                      }
                    },
                    child: Text('Buku Favorit'),
                  ),
                  SizedBox(height: 10), // Tambahkan jarak agar tidak terjadi overflow

                  // Tampilkan buku favorit menggunakan card
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LIST BUKU FAVORIT',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: favoriteBooks.length,
                        itemBuilder: (context, index) {
                          Fields book = favoriteBooks[index];
                          return Card(
                            child: ListTile(
                              title: Text(book.title),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Penulis: ${book.authors}"),
                                  Text("Kode Bahasa: ${book.languageCode}"),
                                  Text("Jumlah Halaman: ${book.numPages.toString()}"),
                                  Text("Tanggal Publikasi: ${book.publicationDate}"),
                                  Text("Penerbit: ${book.publisher}"),
                                ],
                              ),
                              // ... (tambahkan detail lain jika diperlukan)
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
