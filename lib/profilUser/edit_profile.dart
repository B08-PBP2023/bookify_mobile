import 'package:flutter/material.dart';

class EditProfilPage extends StatefulWidget {
  final String initialTanggalLahir;
  final String initialDescription;
  final Function(String, String) onUpdate;

  const EditProfilPage({
    Key? key,
    required this.initialTanggalLahir,
    required this.initialDescription,
    required this.onUpdate,
  });

  @override
  _EditProfilPageState createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  late TextEditingController tanggalLahirController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    tanggalLahirController =
        TextEditingController(text: widget.initialTanggalLahir);
    descriptionController =
        TextEditingController(text: widget.initialDescription);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue[200], // Ganti warna background dengan biru pastel
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: tanggalLahirController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Tanggal Lahir',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Panggil callback onUpdate untuk mengupdate data profil
                  widget.onUpdate(
                    tanggalLahirController.text,
                    descriptionController.text,
                  );

                  // Kembali ke halaman profil setelah update
                  Navigator.pop(context);
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
