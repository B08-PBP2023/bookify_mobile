import 'package:bookify_mobile/wishlist/screen/wishlist_saya_page.dart';
import 'package:flutter/material.dart';
import 'package:bookify_mobile/wishlist/utils/fetch_wishlist_buku.dart';
import 'package:bookify_mobile/homepage/drawer.dart';
import 'dart:convert';
import 'package:bookify_mobile/book_page/utils/fetch_buku.dart';
import 'package:bookify_mobile/book_page/models/buku.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class DaftarBukuWishlist extends StatefulWidget {
  const DaftarBukuWishlist({super.key,required this.username});
  final String username;

  @override
  State<DaftarBukuWishlist> createState() => _DaftarBukuWishlistState();
}

class _DaftarBukuWishlistState extends State<DaftarBukuWishlist> {
  bool value = false;
  String judul = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

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
            Center(child: Text("Klik wishlist saya untuk melihat wishlist", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
            /*SizedBox(height: 30,),
            Center(child: ElevatedButton(
              onPressed: () async {
                try {
                  //menambahkan buku favorite ke API
                  //https://bookify-b08-tk.pbp.cs.ui.ac.id


                  var url = Uri.parse('https://bookify-b08-tk.pbp.cs.ui.ac.id/wishlist/wishlist_saya/${snapshot.data![index].pk}/');
                  var response = await http.post(
                    url,
                    headers: {
                      "Content-Type": "application/json; charset=UTF-8",
                      "X-CSRFToken": request.cookies['csrftoken']!.name,
                      "Cookie":
                      "csrftoken=${request.cookies['csrftoken']!.value};sessionid=${request.cookies['sessionid']!.value}",
                    },
                  );
                  print("masuk");


                  if (response.statusCode == 200) {
                    var result = json.decode(response.body);
                    final snackBar = SnackBar(
                      content: Text(result['msg']),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context,
                      snapshot.data![index].fields.toJson());
                  }else if(response.statusCode == 400){
                    var result = json.decode(response.body);

                    final snackBar = SnackBar(
                      content: Text(result['msg']),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }else{
                    final snackBar = SnackBar(
                      content: Text("Error"),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                } catch (e) {
                  print("masuk eee");

                  print(e.toString());
                }
              },
              child: Text("wishlist saya"),
            )
            ),*/
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
                                  ElevatedButton(
                                    onPressed: () async {
                                      /*try {
                                        //menambahkan buku favorite ke API
                                        //https://bookify-b08-tk.pbp.cs.ui.ac.id


                                        var url = Uri.parse('https://bookify-b08-tk.pbp.cs.ui.ac.id/wishlist/wishlist_saya/${snapshot.data![index].pk}/');
                                        var response = await request.post(
                                          url.toString(),
                                          {}
                                        );

                                        if (response['status'] == 'success') {
                                          var result = response;
                                          final snackBar = SnackBar(
                                            content: Text(result['msg']),
                                            duration: Duration(seconds: 2),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);

                                          // Return selected book data to the previous page
                                          Navigator.pop(
                                            context,
                                            snapshot.data![index].fields.toJson(),
                                          );
                                        } else if (response['status'] == 'failed') {
                                          var result = response;

                                          final snackBar = SnackBar(
                                            content: Text(result['msg']),
                                            duration: Duration(seconds: 2),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else {
                                          final snackBar = SnackBar(
                                            content: Text("Error"),
                                            duration: Duration(seconds: 2),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      } catch (e) {
                                        print(e.toString());
                                      }*/
                                    },
                                    child: Text("Tambahkan ke Wishlist"),
                                  ),
                                ],
                              ),
                            ),
                            ));
                  }
                }
              }),)
          ],)
        ));
  }
}