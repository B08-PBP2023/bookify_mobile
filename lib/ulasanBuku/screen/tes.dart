// import 'package:flutter/material.dart';
// import 'package:bookify_mobile/ulasanBuku/models/models_ulasan.dart';

// class UlasanPage extends StatefulWidget {
//   final BookReview ulasan; // Terima data ulasan sebagai parameter

//   UlasanPage({required this.ulasan});

//   @override
//   _UlasanPageState createState() => _UlasanPageState();
// }

// class _UlasanPageState extends State<UlasanPage> {
//   TextEditingController inputController = TextEditingController();
//   String hasilUlasan = ""; // Variabel untuk menyimpan hasil ulasan
//   String ratingTerpilih = '1'; // Variabel untuk menyimpan rating yang dipilih
//   List<Map<String, dynamic>> daftarUlasan = []; // Daftar untuk menyimpan ulasan

//   void tambahUlasan() {
//     setState(() {
//       // Menambahkan ulasan dan rating ke daftar
//       daftarUlasan.add({
//         "content": inputController.text,
//         "rating": ratingTerpilih,
//       });
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
//               // Tombol Kembali
//               Align(
//                 alignment: Alignment.topLeft,
//               ),
//               SizedBox(height: 16),

//               // Form Ulasan
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

//                       // Dropdown untuk Rating
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

//                       // Bagian untuk menampilkan Daftar Ulasan
//                       Text(
//                         "Daftar Ulasan",
//                         style: TextStyle(
//                             fontSize: 22, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 8),
//                       daftarUlasan.isEmpty
//                           ? Text("Tidak ada ulasan yang tersedia.")
//                           : ListView.builder(
//                               shrinkWrap:
//                                   true, // Penting untuk ListView di dalam Column
//                               physics:
//                                   NeverScrollableScrollPhysics(), // Disable scrolling
//                               itemCount: daftarUlasan.length,
//                               itemBuilder: (context, index) {
//                                 return Card(
//                                   child: ListTile(
//                                     title: Text(
//                                         "Rating: ${daftarUlasan[index]['rating']}"),
//                                     subtitle:
//                                         Text(daftarUlasan[index]['content']),
//                                   ),
//                                 );
//                               },
//                             ),
//                     ],
//                   ),
//                 ),
//               ),
//               // SizedBox(
//               //   height: 200, // Tinggi tetap untuk ListView
//               //   child: ListView.builder(
//               //     itemCount: daftarUlasan.length,
//               //     itemBuilder: (context, index) {
//               //       return Card(
//               //         // ... Tampilkan isi ulasan dari daftarUlasan
//               //         child: ListTile(
//               //           title: Text("Rating: ${daftarUlasan[index]["rating"]}"),
//               //           subtitle: Text("${daftarUlasan[index]["content"]}"),
//               //         ),
//               //       );
//               //     },
//               //   ),
//               // ),

//               // Bagian Daftar Ulasan tanpa Expanded
//               Text(
//                 "Daftar Ulasan",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               daftarUlasan.isEmpty
//                   ? Text("Tidak ada ulasan yang tersedia.")
//                   : Column(
//                       children: daftarUlasan.map((ulasan) {
//                         return Card(
//                           child: ListTile(
//                             title: Text("Rating: ${ulasan["rating"]}"),
//                             subtitle: Text(ulasan["content"]),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//               // Tampilkan review di sini
//               // Contoh: Card untuk satu ulasan
//               // Anda dapat menggunakan ListView.builder untuk daftar ulasan
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
