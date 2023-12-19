// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:bookify_mobile/ulasanBuku/models/models_ulasan.dart';
// import 'package:http/http.dart' as http;

// class UlasanPage extends StatefulWidget {
//   const UlasanPage({super.key, required this.idBuku});
//   final int idBuku;

//   @override
//   _UlasanPageState createState() => _UlasanPageState();
// }

// class _UlasanPageState extends State<UlasanPage> {
//   TextEditingController inputController = TextEditingController();
//   String hasilUlasan = "";
//   String ratingTerpilih = '1';

//   void kirimUlasanKeServer() async {
//     final data = {
//       'isi_ulasan': hasilUlasan,
//       'rating': ratingTerpilih,
//     };

//     // Ganti URL sesuai dengan endpoint API server Anda
//     final url =
//         "https://bookify-b08-tk.pbp.cs.ui.ac.id/ulasanBuku/add_ulasan_flutter/${widget.idBuku}/";

//     try {
//       final request = context.read<CookieRequest>();
//       final response = await request.postJson(url, jsonEncode(data));

//       if (response['status'] == 'success') {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Ulasan berhasil dikirim!")),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Gagal mengirim ulasan, coba lagi.")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Terjadi kesalahan: $e")),
//       );
//     }
//   }

//   void tambahUlasan() {
//     setState(() {
//       hasilUlasan = inputController.text;
//       // Kirim ulasan ke server
//       kirimUlasanKeServer();

//       // Bersihkan input setelah submit
//       inputController.clear();
//       ratingTerpilih = '1';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Ulasan Buku"),
//         backgroundColor: Color.fromARGB(255, 91, 84, 230),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 color: Colors.lightBlue[50],
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Kotak Ulasan",
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       TextFormField(
//                         controller: inputController,
//                         maxLines: 5,
//                         decoration: InputDecoration(
//                           hintText: "Tulis ulasan Anda di sini",
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       DropdownButtonFormField<String>(
//                         value: ratingTerpilih,
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             ratingTerpilih = newValue!;
//                           });
//                         },
//                         items: <String>['1', '2', '3', '4', '5']
//                             .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                         decoration: InputDecoration(
//                           labelText: 'Rating',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: tambahUlasan,
//                         child: Text("Submit Ulasan"),
//                         style: ElevatedButton.styleFrom(primary: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Tampilkan daftar ulasan
//               // FutureBuilder<List<Review>>(
//               //   future: fetchUlasan(),
//               //   builder: (context, snapshot) {
//               //     if (snapshot.connectionState == ConnectionState.waiting) {
//               //       return Center(child: CircularProgressIndicator());
//               //     } else if (snapshot.hasError) {
//               //       return Center(child: Text("Error: ${snapshot.error}"));
//               //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               //       return Center(child: Text("Tidak ada ulasan"));
//               //     } else {
//               //       return ListView.builder(
//               //         shrinkWrap: true,
//               //         physics: NeverScrollableScrollPhysics(),
//               //         itemCount: snapshot.data!.length,
//               //         itemBuilder: (context, index) {
//               //           Review ulasan = snapshot.data![index];
//               //           return Card(
//               //             child: ListTile(
//               //               title: Text(ulasan.fields.content),
//               //               subtitle: Text("Rating: ${ulasan.fields.rating}"),
//               //             ),
//               //           );
//               //         },
//               //       );
//               //     }
//               //   },
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
