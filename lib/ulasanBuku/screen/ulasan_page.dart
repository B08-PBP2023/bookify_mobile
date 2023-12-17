import 'package:bookify_mobile/ulasanBuku/models/models_ulasan.dart';
import 'package:flutter/material.dart';

class UlasanPage extends StatefulWidget {
  final BookReview ulasan; // Terima data ulasan sebagai parameter

  UlasanPage({required this.ulasan});

  @override
  _UlasanPageState createState() => _UlasanPageState();
}

class _UlasanPageState extends State<UlasanPage> {
  TextEditingController inputController = TextEditingController();
  String hasilUlasan = ""; // Variabel untuk menyimpan hasil ulasan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ulasan Buku"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Penulis: ${widget.ulasan.nama}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Tanggal Ulasan: ${widget.ulasan.tanggalReview}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Rating: ${widget.ulasan.rating}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Masukkan Ulasan Anda:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: inputController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Tulis ulasan Anda di sini",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Menggunakan nilai yang dimasukkan oleh pengguna
                String ulasanPengguna = inputController.text;
                
                // Lakukan sesuatu dengan ulasanPengguna, misalnya simpan ke database atau tampilkan
                // Anda dapat menggantinya dengan tindakan yang sesuai dengan kebutuhan aplikasi Anda.

                // Menampilkan hasil ulasan menggunakan SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Ulasan Anda: $ulasanPengguna"),
                  ),
                );

                // Mengupdate hasil ulasan
                setState(() {
                  hasilUlasan = ulasanPengguna;
                });
              },
              child: Text("Kirim Ulasan"),
            ),
            SizedBox(height: 16),
            Text(
              "Hasil Ulasan:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              hasilUlasan, // Menampilkan hasil ulasan di sini
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }
}
