import 'package:bookify_mobile/faq/screen/list_buku_faq.dart';
import 'package:flutter/material.dart';
import 'package:bookify_mobile/book_page/screen/list_buku.dart';
import 'package:bookify_mobile/homepage/homepage.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bookify_mobile/profilUser/profile_page.dart';
import 'package:bookify_mobile/authentication/login.dart';

// merupakan sebuah Drawer yang digunakan untuk navigasi antar page
Drawer buildDrawer(BuildContext context) {
  final request = context.watch<CookieRequest>();
  return Drawer(
    child: Container(
      color: Colors.black,
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Text(
                  'BOOKIFY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Baca buku dari mana aja!",
                  // Menambahkan gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ), // <-- This is the closing parenthesis for const DrawerHeader

          Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 30.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Dashboard', style: TextStyle(color: Colors.yellow)),
                  leading: const Icon(Icons.house, color: Colors.yellow),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(),
                      ),
                    );
                  },
                ),
                Divider(color: Colors.white),
                ListTile(
                  title: const Text('List Buku', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.tour, color: Colors.white),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const DaftarBuku()),
                    );
                  },
                ),

                ListTile(
                  title: const Text('Profil', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.person, color: Colors.white),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilPage(username: LoginPage.uname)),
                    );
                  },
                ),

                ListTile(
                  title: const Text('FAQ', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.person, color: Colors.white),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => DaftarBukuFAQ(username: LoginPage.uname)),
                    );
                  },
                ),

              ],
            ),
          ), // <-- This is the closing parenthesis for Padding
        ],
      ),
    ),
  );
}
