import 'dart:convert';

import 'package:bookify_mobile/faq/screen/question_with_answer.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
// import 'package:shopping_list/screens/menu.dart';
// // TODO: Impor drawer yang sudah dibuat sebelumnya
// import 'package:shopping_list/widgets/left_drawer.dart';

class AnswerFormPage extends StatefulWidget {
    const AnswerFormPage({super.key, required this.idBuku, required this.isi_pertanyaan, required this.idQuestion});
    final int idBuku;
    final int idQuestion;
    final String isi_pertanyaan;
    @override
    State<AnswerFormPage> createState() => _AnswerFormPageState();
}

class _AnswerFormPageState extends State<AnswerFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _isi_jawaban = "";
    
    
    @override
    Widget build(BuildContext context) {
      String _isi_pertanyaan = widget.isi_pertanyaan;
      int _idQuestion = widget.idQuestion;

      int idBuku = widget.idBuku;
      final request = context.watch<CookieRequest>();
      return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Form Jawab Pertanyaan',
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
                  // show question

                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Jawaban",
                      labelText: "Jawaban",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _isi_jawaban = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Jawaban tidak boleh kosong!";
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
                              "https://bookify-b08-tk.pbp.cs.ui.ac.id/FAQ/jawab_question_flutter/$idBuku/",
                              // "http://127.0.0.1:8000/FAQ/jawab_question_flutter/$idBuku/",

                              jsonEncode(<String, String>{
                                  'isi_pertanyaan': _isi_pertanyaan,
                                  'isi_jawaban': _isi_jawaban,
                                  'id_question': _idQuestion.toString(),
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