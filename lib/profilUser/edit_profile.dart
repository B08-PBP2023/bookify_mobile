import 'dart:convert';

import 'package:bookify_mobile/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//import '../onstants/constant.dart';

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
    tanggalLahirController =
        TextEditingController(text: widget.initialTanggalLahir);
    descriptionController =
        TextEditingController(text: widget.initialDescription);
  }

  // Fungsi untuk menyimpan data menggunakan shared_preferences
//   Future<void> _simpanData() async {
//     print('Tanggal Lahir: ${tanggalLahirController.text}');
// print('Deskripsi: ${descriptionController.text}');
//
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('tanggal_lahir', tanggalLahirController.text);
//   await prefs.setString('deskripsi', descriptionController.text);
// }

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
                    // await _simpanData();  // Pastikan fungsi ini dipanggil
                    try {
                      // var url = Uri.parse('$baseUrl/profilUser/edit_profile_flutter/${LoginPage.uname}/');
                      print(tanggalLahirController.text);
                      print(descriptionController.text);
                      var url = Uri.parse(
                          "https://bookify-b08-tk.pbp.cs.ui.ac.id/profilUser/edit_profile_flutter/");
                          //https://bookify-b08-tk.pbp.cs.ui.ac.id/FAQ/delete_question_flutter/$idQuestion/"
                      final response = await http.post(url,
                          headers: {
                            "Content-Type": "application/json; charset=UTF-8",
                            "X-CSRFToken": request.cookies['csrftoken']!.name,
                            "Cookie":
                                "csrftoken=${request.cookies['csrftoken']!.value};sessionid=${request.cookies['sessionid']!.value}",
                          },
                          body: jsonEncode(<String, dynamic>{
                            "tanggal_lahir": tanggalLahirController.text,
                            "description": descriptionController.text
                          }));
                      print("masuk");

                      print(response.body);

                      if (response.statusCode == 200) {
                        var result = json.decode(response.body);

                        final snackBar = SnackBar(
                          content: Text(result['msg']),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        widget.onUpdate(
                          tanggalLahirController.text,
                          descriptionController.text,
                        );
                        Navigator.pop(context);
                      } else {
                        final snackBar = SnackBar(
                          content: Text("gagal"),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } catch (e) {
                      print("masuk eee");

                      print(e.toString());
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
