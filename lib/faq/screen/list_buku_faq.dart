import 'package:bookify_mobile/faq/screen/question_with_answer.dart';
import 'package:flutter/material.dart';
import 'package:bookify_mobile/book_page/utils/fetch_buku.dart';
import 'package:bookify_mobile/homepage/drawer.dart';

class DaftarBukuFAQ extends StatefulWidget {
  const DaftarBukuFAQ({super.key,required this.username});
  final String username;

  @override
  State<DaftarBukuFAQ> createState() => _DaftarBukuFAQState();
}

class _DaftarBukuFAQState extends State<DaftarBukuFAQ> {
  bool value = false;
  String judul = "";

  @override
  Widget build(BuildContext context) {
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
          child: Column(children: [
            SizedBox(height: 20,),
            Center(child: Text("Klik buku yang ingin ditanyakan", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
            SizedBox(height: 20,),
            Center(child: TextField(
                        onChanged: (value) {
                          setState(() {
                            judul = value;
                          });
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none),
                            hintText:
                                "Masukkan judul buku yang ingin dicari!",
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: Colors.blueAccent),
              )),
            SizedBox(height: 20,),
            Expanded(child: FutureBuilder(
              future: fetchBook(judul),
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
                                    "${snapshot.data![index].fields.title}",
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${snapshot.data![index].fields.authors}",
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${snapshot.data![index].fields.languageCode}",
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${snapshot.data![index].fields.numPages}",
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${snapshot.data![index].fields.publicationDate}",
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${snapshot.data![index].fields.publisher}",
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FAQBuku(idBuku: snapshot.data![index].pk,)),
                              );
                            }));
                  }
                }
              }),)
          ],)
        ));
  }
}
