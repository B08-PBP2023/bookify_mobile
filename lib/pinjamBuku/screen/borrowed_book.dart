// import 'package:bookify_mobile/pinjamBuku/models/pinjam.dart';
// import 'package:flutter/material.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:bookify_mobile/homepage/drawer.dart';
// import 'package:bookify_mobile/book_page/models/buku.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:bookify_mobile/authentication/login.dart';


// class BorrowedBooks extends StatefulWidget {
//   final String username;

//   const BorrowedBooks({Key? key, required this.username}) : super(key: key);

//   @override
//   _BorrowedBooksState createState() => _BorrowedBooksState(username: username);
// }

// class _BorrowedBooksState extends State<BorrowedBooks> {
//   late String nama;
//   late String role = "Reguler";
//   late String tanggalLahir = "";
//   late String description = "";

//   _BorrowedBooksState({required String username}) {
//     nama = username;
//   }

//   List<Fields> bukuPinjaman = [];

//   Future<List<Pinjam>> fetchBorrowedBooks() async {
//     final request = context.watch<CookieRequest>();
//     var url = Uri.parse("https://bookify-b08-tk.pbp.cs.ui.ac.id/pinjamBuku/show_borrow_books/");
//     var response = await request.get(
//       url.toString(),
//     );

//     List<Pinjam> list_pinjaman = [];
//     if (response['status'] == 'success') {
//       var result = response;
//       for (var d in result["data"]) {
//         if (d != null) {
//           list_pinjaman.add(Pinjam.fromJson(d));
//         }
//       }
//     }
//     return list_pinjaman;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Buku yang Dipinjam"),
//       ),
//       drawer: buildDrawer(context),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Container(
//               padding: EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.blue[200],
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   FutureBuilder<UserProfile?>(
//                     future: _loadProfileData(context),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       } else {
//                         UserProfile? userProfile = UserProfile(
//                           username: nama,
//                           role: role,
//                           tanggalLahir: tanggalLahir,
//                           description: description,
//                         );

//                         if (snapshot.hasData) {
//                           userProfile = snapshot.data;
//                         }

//                         return DataTable(
//                           dataRowHeight: 50.0,
//                           columns: [
//                             DataColumn(
//                               label: Text(
//                                 'Data User',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                             DataColumn(
//                               label: Text(
//                                 'Keterangan',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                           rows: [
//                             DataRow(cells: [
//                               DataCell(Text("Username")),
//                               DataCell(Text(userProfile!.username)),
//                             ]),
//                             DataRow(cells: [
//                               DataCell(Text("Role")),
//                               DataCell(Text(userProfile.role)),
//                             ]),
//                             DataRow(cells: [
//                               DataCell(Text("Tanggal Lahir")),
//                               DataCell(Text(userProfile.tanggalLahir)),
//                             ]),
//                             DataRow(cells: [
//                               DataCell(Text("Deskripsi")),
//                               DataCell(Text(userProfile.description)),
//                             ]),
//                           ],
//                         );
//                       }

//                       return SizedBox();
//                     },
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => EditProfilPage(
//                             initialTanggalLahir: tanggalLahir,
//                             initialDescription: description,
//                             onUpdate: (newTanggalLahir, newDescription) {
//                               setState(() {
//                                 tanggalLahir = newTanggalLahir;
//                                 description = newDescription;
//                               });
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                     child: Text("Edit Profil"),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       final result = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => DaftarBukuFavorit(),
//                         ),
//                       );

//                       if (result != null) {
//                         setState(() {
                         
//                         });
                        
//                       }
//                     },
//                     child: Text('Buku Favorit'),
//                   ),
//                   SizedBox(height: 10),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'LIST BUKU FAVORIT',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       FutureBuilder<List<FavoriteModel>>(
//                         future: fetchFavoriteBooks(),
//                         builder: (context, snapshot) {
//                           if (snapshot.hasData) {
//                             return ListView.builder(
//                               physics: NeverScrollableScrollPhysics(),
//                               shrinkWrap: true,
//                               itemCount: snapshot.data!.length,
//                               itemBuilder: (context, index) {
//                                 return Card(
//                                   child: ListTile(
//                                     isThreeLine: true,
//                                     title: Text(snapshot.data![index].title),
//                                     subtitle: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Penulis: ${snapshot.data![index].authors}",
//                                         ),
//                                         Text(
//                                           "Kode Bahasa: ${snapshot.data![index].languageCode}",
//                                         ),
//                                         Text(
//                                           "Jumlah Halaman: ${snapshot.data![index].numPages.toString()}",
//                                         ),
//                                         Text(
//                                           "Tanggal Publikasi: ${snapshot.data![index].publicationDate}",
//                                         ),
//                                         Text(
//                                           "Penerbit: ${snapshot.data![index].publisher}",
//                                         ),
//                                         ElevatedButton(
//                                           onPressed: () async {
//                                             final request =
//                                                 context.read<CookieRequest>();

//                                             var url = Uri.parse(
//                                               "https://bookify-b08-tk.pbp.cs.ui.ac.id/profilUser/delete_favorite_flutter/${snapshot.data![index].idBook}/",
//                                             );

//                                             var response = await request.post(
//                                               url.toString(),{}
                                              
//                                             );

//                                             var result = response;

//                                             final snackBar = SnackBar(
//                                               content: Text(result['msg']),
//                                               duration: Duration(seconds: 2),
//                                             );
//                                             ScaffoldMessenger.of(context)
//                                                 .showSnackBar(snackBar);
//                                             setState(() {});
//                                           },
//                                           child: Text("Hapus Favorit"),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           }
//                           return SizedBox();
//                         },
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 100,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }