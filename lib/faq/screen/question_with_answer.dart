import 'package:bookify_mobile/faq/utils/fetch_question_answer.dart';
import 'package:flutter/material.dart';
import 'package:bookify_mobile/book_page/utils/fetch_buku.dart';
import 'package:bookify_mobile/homepage/drawer.dart';

class FAQBuku extends StatefulWidget {
  const FAQBuku({super.key,required this.idBuku});
  final int idBuku;

  @override
  State<FAQBuku> createState() => _FAQBukuState();
}

class _FAQBukuState extends State<FAQBuku > {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    int idBuku = widget.idBuku;
    return Scaffold(
        // backgroundColor: Colors.green[100],
        appBar: AppBar(
          title: Text("Daftar Buku",),
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
              future: fetchQuestionAnswer(idBuku),
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
                                  const SizedBox(height: 5),
                                  Text(
                                    "${snapshot.data![index].fields.isiJawaban}",
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(height: 5),
                                  
                                ],
                              ),
                            ),
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => SingleDestination(
                              //             data: snapshot.data![index],
                              //           )),
                              // );
                            }));
                  }
                }
              }),
        ));
  }
}