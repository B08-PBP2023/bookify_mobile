import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:bookify_mobile/ulasanBuku/models/models_ulasan.dart';
import 'package:bookify_mobile/ulasanBuku/utils/fetch_ulasan.dart';
import 'package:bookify_mobile/profilUser/profile_page.dart';
import 'package:http/http.dart' as http;

class UlasanPage extends StatefulWidget {
  const UlasanPage({super.key, required this.idBuku});
  final int idBuku;

  @override
  _UlasanPageState createState() => _UlasanPageState();
}

class _UlasanPageState extends State<UlasanPage> {
  TextEditingController inputController = TextEditingController();
  String hasilUlasan = "";
  String ratingTerpilih = '1';
  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(date);
  }

  void kirimUlasanKeServer() async {
    // Ganti URL sesuai dengan endpoint API server Anda
    final url =
        "https://bookify-b08-tk.pbp.cs.ui.ac.id/ulasanBuku/add_ulasan_flutter/${widget.idBuku}/";
    // "http://127.0.0.1:8000/ulasanBuku/add_ulasan_flutter/${widget.idBuku}/";

    try {
      final request = context.read<CookieRequest>();
      final response = await request.postJson(
        url,
        jsonEncode(<String, dynamic>{
          'rating': ratingTerpilih,
          'isi_ulasan': hasilUlasan,
        }),
      );
      // print(hasilUlasan);
      // print(ratingTerpilih);
      if (response['status'] == 'success') {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Ulasan berhasil dikirim!")),
        // );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal mengirim ulasan, coba lagi.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    }
  }

  void tambahUlasan() async {
    hasilUlasan = inputController.text;
    kirimUlasanKeServer();
    setState(() {
      // Bersihkan input setelah submit
      inputController.clear();
      ratingTerpilih = '1';
    });
  }

  // Widget untuk menampilkan satu ulasan
  Widget buildReviewCard(Review ulasan) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          ulasan.fields.content,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Rating: ${ulasan.fields.rating}"),
            Text("Tanggal dibuat: ${formatDate(ulasan.fields.createdAt)}"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ulasan Buku"),
        backgroundColor: Color.fromARGB(255, 91, 84, 230),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.lightBlue[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kotak Ulasan",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
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
                      DropdownButtonFormField<String>(
                        value: ratingTerpilih,
                        onChanged: (String? newValue) {
                          setState(() {
                            ratingTerpilih = newValue!;
                          });
                        },
                        items: <String>['1', '2', '3', '4', '5']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Rating',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        child: Text("Submit Ulasan"),
                        onPressed: tambahUlasan,
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              // Tampilkan daftar ulasan
              Text(
                "Daftar Ulasan",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              FutureBuilder<List<Review>>(
                future: fetchUlasan(widget.idBuku),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("Tidak ada ulasan"));
                  } else {
                    return ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: snapshot.data!.map(buildReviewCard).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
