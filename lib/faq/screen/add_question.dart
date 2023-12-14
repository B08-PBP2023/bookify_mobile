import 'dart:convert';

import 'package:bookify_mobile/faq/screen/question_with_answer.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
// import 'package:shopping_list/screens/menu.dart';
// // TODO: Impor drawer yang sudah dibuat sebelumnya
// import 'package:shopping_list/widgets/left_drawer.dart';

class QuestionFormPage extends StatefulWidget {
    const QuestionFormPage({super.key, required this.idBuku});
    final int idBuku;
    @override
    State<QuestionFormPage> createState() => _QuestionFormPageState();
}

class _QuestionFormPageState extends State<QuestionFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _isi_pertanyaan = "";
    
    @override
    Widget build(BuildContext context) {
      int idBuku = widget.idBuku;
      final request = context.watch<CookieRequest>();
      return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Form Tambahkan Pertanyaan',
            ),
          ),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        // TODO: Tambahkan drawer yang sudah dibuat di sini
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Pertanyaan",
                      labelText: "Pertanyaan",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _isi_pertanyaan = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Pertanyaan tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),

            
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                              // Kirim ke Django dan tunggu respons
                              // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                              final response = await request.postJson(
                              "https://bookify-b08-tk.pbp.cs.ui.ac.id/FAQ/add_question_flutter/$idBuku/",
                              // "http://127.0.0.1:8000/FAQ/add_question_flutter/$idBuku/",

                              jsonEncode(<String, String>{
                                  'isi_pertanyaan': _isi_pertanyaan,
                                  // TODO: Sesuaikan field data sesuai dengan aplikasimu
                              }));
                              if (response['status'] == 'success') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                  content: Text("Produk baru berhasil disimpan!"),
                                  ));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => FAQBuku(idBuku: idBuku,)),
                                  );
                              } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content:
                                          Text("Terdapat kesalahan, silakan coba lagi."),
                                  ));
                              }
                          }

                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

              ],
            )
          ),
        ),
      );
    }
}