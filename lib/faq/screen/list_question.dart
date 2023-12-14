import 'dart:convert';

import 'package:bookify_mobile/authentication/login.dart';
import 'package:bookify_mobile/faq/screen/add_answer.dart';
import 'package:bookify_mobile/faq/screen/add_question.dart';
import 'package:bookify_mobile/faq/utils/fetch_question.dart';
import 'package:bookify_mobile/faq/utils/fetch_question_answer.dart';
import 'package:flutter/material.dart';
import 'package:bookify_mobile/book_page/utils/fetch_buku.dart';
import 'package:bookify_mobile/homepage/drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class QuestionBuku extends StatefulWidget {
  const QuestionBuku({super.key,required this.idBuku});
  final int idBuku;

  @override
  State<QuestionBuku> createState() => _QuestionBukuState();
}

class _QuestionBukuState extends State<QuestionBuku > {
  bool value = false;
  String userLogin = LoginPage.uname;
  

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    int idBuku = widget.idBuku;

    return Scaffold(
        // backgroundColor: Colors.green[100],
        appBar: AppBar(
          title: Text("Daftar Pertanyaan",),

        //   actions: [
        //   IconButton(
        //     icon: Icon(Icons.exit_to_app, color: Colors.black),
        //     onPressed: () {
        //       Navigator.of(context).push(
        //           MaterialPageRoute(builder: (context) => QuestionFormPage(idBuku: idBuku,)),
        //           // (Route<dynamic> route) => false);
        //       );
        //     },
        //   ),
        // ],

        ),
        // menambahkan Drawer untuk navigasi antarhalaman
        drawer: buildDrawer(context),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.blueAccent, Colors.blueGrey])),
          child: FutureBuilder(
              future: fetchQuestion(idBuku),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return Column(
                      children: const [
                        Text(
                          "Tidak ada buku :(",
                          style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(


                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => InkWell(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 12),
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black, blurRadius: 2.0)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${snapshot.data![index].fields.isiPertanyaan}",
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // const SizedBox(height: 5),

                                  // center this
                                  
                                  Center(
                                    child : Row(
                                      mainAxisAlignment: MainAxisAlignment.center, 
                                      children: [
                                      ElevatedButton(
                                        onPressed: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => AnswerFormPage(
                                                      idBuku: idBuku,
                                                      isi_pertanyaan: snapshot
                                                          .data![index].fields.isiPertanyaan,
                                                      idQuestion : snapshot.data![index].pk,
                                                    )),
                                          );
                                        }, 
                                        child: Container(
                                          child: Text("Jawab",
                                                style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)))),
                                        ElevatedButton(
                                          onPressed: () async{
                                            int idQuestion = snapshot.data![index].pk;
                                            final response = await request.postJson(
                                "https://bookify-b08-tk.pbp.cs.ui.ac.id/FAQ/delete_question_flutter/$idQuestion/",
                                // "http://127.0.0.1:8000/FAQ/delete_question_flutter/$idQuestion/",

                                jsonEncode(<String, String>{
                                    // TODO: Sesuaikan field data sesuai dengan aplikasimu
                                }));
                                if (response['status'] == 'success') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                    content: Text("Produk baru berhasil disimpan!"),
                                    ));
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => QuestionBuku(idBuku: idBuku,)),
                                    );
                                } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        content:
                                            Text("Terdapat kesalahan, silakan coba lagi."),
                                    ));
                                }
                                          },child: Container(
                                          child: Text("Hapus",
                                                style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold))) )]))
                                  
                                ],
                              ),
                            ),
                            // onTap: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => AnswerFormPage(
                            //               idBuku: idBuku,
                            //               isi_pertanyaan: snapshot
                            //                   .data![index].fields.isiPertanyaan,
                            //               idQuestion : snapshot.data![index].pk,
                            //             )),
                            //   );
                            // }
                            ));
                  }
                }
              }),
        ));
  }
}