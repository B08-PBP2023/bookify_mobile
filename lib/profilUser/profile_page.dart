import 'package:flutter/material.dart';
import 'edit_profile.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  // Data profil
  String nama = "John Doe";
  String role = "Software Engineer";
  String tanggalLahir = "01 Januari 1990";
  String description =
      "Seorang pengembang perangkat lunak dengan pengalaman di Flutter dan Dart.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: $nama', style: TextStyle(fontSize: 20)),
            Text('Role: $role', style: TextStyle(fontSize: 20)),
            Text('Tanggal Lahir: $tanggalLahir', style: TextStyle(fontSize: 20)),
            Text('Deskripsi: $description', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman edit profil
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilPage(
                      initialTanggalLahir: tanggalLahir,
                      initialDescription: description,
                      onUpdate: (newTanggalLahir, newDescription) {
                        // Update data profil setelah di-edit
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
          ],
        ),
      ),
    );
  }
}
