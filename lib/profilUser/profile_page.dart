import 'package:bookify_mobile/profilUser/models/favorit_model.dart';
import 'package:bookify_mobile/profilUser/models/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'edit_profile.dart';
import 'package:bookify_mobile/homepage/drawer.dart';
import 'listbuku_favorit.dart';
import 'package:bookify_mobile/book_page/models/buku.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookify_mobile/authentication/login.dart';


class ProfilPage extends StatefulWidget {
  final String username;

  const ProfilPage({Key? key, required this.username}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState(username: username);
}

class _ProfilPageState extends State<ProfilPage> {
  late String nama;
  late String role = "Reguler";
  late String tanggalLahir = "";
  late String description = "";

  _ProfilPageState({required String username}) {
    nama = username;
  }

  Future<UserProfile?> _loadProfileData(BuildContext context) async {
    final request = context.watch<CookieRequest>();
    var url = Uri.parse("https://bookify-b08-tk.pbp.cs.ui.ac.id/profilUser/get_profile_flutter/");
    
    var response = await request.get(
      url.toString(),      
    );

    print (response);

    if (response['status'] == 'success') {
      print ("wooooooi");
      var result = response;
      nama = result["data"]["username"];
      role = result["data"]["role"];
      tanggalLahir = result["data"]["tanggalLahir"];
      description = result["data"]["description"];
    }


    return null;
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  List<Fields> favoriteBooks = [];

  Future<List<FavoriteModel>> fetchFavoriteBooks() async {
    final request = context.watch<CookieRequest>();
    var url = Uri.parse("https://bookify-b08-tk.pbp.cs.ui.ac.id/profilUser/get_favorite_by_user_flutter/");
    var response = await request.get(
      url.toString(),
    );

    List<FavoriteModel> list_favs = [];
    if (response['status'] == 'success') {
      var result = response;
      for (var d in result["data"]) {
        if (d != null) {
          list_favs.add(FavoriteModel.fromJson(d));
        }
      }
    }
    return list_favs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil User"),
      ),
      drawer: buildDrawer(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureBuilder<UserProfile?>(
                    future: _loadProfileData(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        UserProfile? userProfile = UserProfile(
                          username: nama,
                          role: role,
                          tanggalLahir: tanggalLahir,
                          description: description,
                        );

                        if (snapshot.hasData) {
                          userProfile = snapshot.data;
                        }

                        return DataTable(
                          dataRowHeight: 50.0,
                          columns: [
                            DataColumn(
                              label: Text(
                                'Data User',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Keterangan',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text("Username")),
                              DataCell(Text(userProfile!.username)),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("Role")),
                              DataCell(Text(userProfile.role)),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("Tanggal Lahir")),
                              DataCell(Text(userProfile.tanggalLahir)),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("Deskripsi")),
                              DataCell(Text(userProfile.description)),
                            ]),
                          ],
                        );
                      }

                      return SizedBox();
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilPage(
                            initialTanggalLahir: tanggalLahir,
                            initialDescription: description,
                            onUpdate: (newTanggalLahir, newDescription) {
                              setState(() {
                                tanggalLahir = newTanggalLahir;
                                description = newDescription;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: Text("Edit Profil"),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DaftarBukuFavorit(),
                        ),
                      );

                      if (result != null) {
                        setState(() {
                         
                        });
                        
                      }
                    },
                    child: Text('Buku Favorit'),
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LIST BUKU FAVORIT',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      FutureBuilder<List<FavoriteModel>>(
                        future: fetchFavoriteBooks(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    isThreeLine: true,
                                    title: Text(snapshot.data![index].title),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Penulis: ${snapshot.data![index].authors}",
                                        ),
                                        Text(
                                          "Kode Bahasa: ${snapshot.data![index].languageCode}",
                                        ),
                                        Text(
                                          "Jumlah Halaman: ${snapshot.data![index].numPages.toString()}",
                                        ),
                                        Text(
                                          "Tanggal Publikasi: ${snapshot.data![index].publicationDate}",
                                        ),
                                        Text(
                                          "Penerbit: ${snapshot.data![index].publisher}",
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            final request =
                                                context.read<CookieRequest>();

                                            var url = Uri.parse(
                                              "https://bookify-b08-tk.pbp.cs.ui.ac.id/profilUser/delete_favorite_flutter/${snapshot.data![index].idBook}/",
                                            );

                                            var response = await request.post(
                                              url.toString(),{}
                                              
                                            );

                                            var result = response;

                                            final snackBar = SnackBar(
                                              content: Text(result['msg']),
                                              duration: Duration(seconds: 2),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                            setState(() {});
                                          },
                                          child: Text("Hapus Favorit"),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
