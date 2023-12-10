import 'package:bookify_mobile/ulasanBuku/models/models_ulasan.dart';
import 'package:flutter/material.dart'; // Pastikan mengimpor model BookReview

class UlasanPage extends StatelessWidget {
  final BookReview ulasan; // Terima data ulasan sebagai parameter

  UlasanPage({required this.ulasan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ulasan Buku"), // Ganti judul sesuai kebutuhan
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Penulis: ${ulasan.nama}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Tanggal Ulasan: ${ulasan.tanggalReview}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Rating: ${ulasan.rating}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Ulasan:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              ulasan.reviewText,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
