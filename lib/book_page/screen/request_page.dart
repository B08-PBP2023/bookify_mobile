import 'package:flutter/material.dart';
import 'package:bookify_mobile/book_page/screen/request_form.dart';

void main() {
  runApp(MaterialApp(
    home: RequestBookPage()
    ));
  
}

class RequestBookPage extends StatefulWidget {
  @override
  _RequestBookPageState createState() => _RequestBookPageState();
}

class _RequestBookPageState extends State<RequestBookPage> {
  List<Map<String, String>> books = [
    // This would be your data for books
    // {'title': 'Harry Potter', 'author': 'JK Rowling', 'language': 'Indonesia', 'publishDate': '11/1/2003', 'publisher': 'Scholastic'},
    // Add more book maps here
  ];

  void navigateToAddBookForm() {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => RequestForm()),
  ).then((_) {
    // TODO: Refresh the book list if necessary
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Buku'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionalityR
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Card(
            child: Column(
              children: <Widget>[
                Text('Buku ${index + 1} :', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Judul: ${book['title']}'),
                Text('Penulis: ${book['author']}'),
                Text('Bahasa: ${book['language']}'),
                Text('Tanggal Publikasi: ${book['publishDate']}'),
                Text('Penerbit: ${book['publisher']}'),
                // You can add more text widgets for additional book info
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddBookForm,
        child: Icon(Icons.add),
        tooltip: '+ Add Buku',
      ),
    );
  }
}
