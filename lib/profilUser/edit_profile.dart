
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';




class EditProfilPage extends StatefulWidget {
  final String initialTanggalLahir;
  final String initialDescription;
  final Function(String, String) onUpdate;

  const EditProfilPage({
    Key? key,
    required this.initialTanggalLahir,
    required this.initialDescription,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _EditProfilPageState createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  late TextEditingController tanggalLahirController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    tanggalLahirController = TextEditingController(text: widget.initialTanggalLahir);
    descriptionController = TextEditingController(text: widget.initialDescription);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
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
                  onPressed: () async {
           
                    try {
                      var url = Uri.parse("https://bookify-b08-tk.pbp.cs.ui.ac.id/profilUser/edit_profile_flutter/");
       
                      final response = await request.post(
                        url.toString(),
                        {
                          "tanggal_lahir": tanggalLahirController.text,
                          "description": descriptionController.text,
                        }
                      );
                      

                      if (response['status'] == 'success') {
                        var result = response;

                        final snackBar = const SnackBar(
                          content: Text("Data berhasil di update"),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        // Call the onUpdate callback to update the parent widget's data
                        widget.onUpdate(
                          tanggalLahirController.text,
                          descriptionController.text,
                        );

                        // Close the EditProfilPage
                        Navigator.pop(context);
                      } else {
                        final snackBar = const SnackBar(
                          content: Text("Failed to update data"),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } catch (e) {
                      print("Error: $e");
                    }
                  },
                  child: Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}