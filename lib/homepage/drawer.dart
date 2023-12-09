import 'package:flutter/material.dart';
import 'package:bookify_mobile/book_page/screen/list_buku.dart';
import 'package:bookify_mobile/homepage/homepage.dart';
import 'package:bookify_mobile/profilUser/profile_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

// merupakan sebuah Drawer yang digunakan untuk navigasi antar page
Drawer buildDrawer(BuildContext context) {
  final request = context.watch<CookieRequest>();
  return Drawer(
    child: Container(
      color: Colors.black,
      child: ListView(
        padding: const EdgeInsets.only(top: 60.0, left: 30.0),
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
          Divider(color: Colors.white),
          ListTile(
            title: const Text('Profil', style: TextStyle(color: Colors.white)),
            leading: const Icon(Icons.person, color: Colors.white),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfilPage()),
              );
            },
          ),
        ],
      ),
    ),
  );
}
