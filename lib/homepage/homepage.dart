// All
import 'package:flutter/material.dart';
import 'package:bookify_mobile/authentication/login.dart';
import 'package:bookify_mobile/book_page/screen/list_buku.dart';
import 'package:bookify_mobile/homepage/drawer.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  // final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BOOKIFY", style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white), 
      ),
      drawer: buildDrawer(context),
      body: Center(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.blueAccent, Colors.blueGrey]),
                borderRadius: BorderRadius.circular(0),
                boxShadow: const [
                  BoxShadow(color: Colors.black, blurRadius: 2.0)
                ]),
            child: Column(
              children: [
                // SizedBox(height: 30),
                // Container(
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(35)),
                //   child: Container(
                //       padding: EdgeInsets.all(5),
                //       // decoration: BoxDecoration(
                //       // padding: const EdgeInsets.all(10),
                //       child: ClipRRect(
                //         borderRadius: BorderRadius.circular(30.0),
                //         child: Image.network(
                //           "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1489732961i/1362193.jpg",
                //           height: 240,
                //         ),
                //       )),
                // ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 6),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Bookify adalah sebuah aplikasi perpustakaan online yang dirancang untuk membantu pengguna dalam mengeksplorasi, meminjam, dan membaca buku secara digital. Dengan menyediakan akses yang lebih mudah dan cepat ke berbagai sumber literatur, Bookify membantu memfasilitasi dan mendorong kegiatan membaca di seluruh dunia. Melalui inovasi ini, Bookify hadir berperan dalam meningkatkan aksesbilitas literatur dan memajukan budaya literasi di era digital.",
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 6),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(children: [
                        Text(
                          "Lihat Semua Buku",
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DaftarBuku()),
                            );
                          },
                          child: Text('See all Books'),
                        )
                      ]),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}