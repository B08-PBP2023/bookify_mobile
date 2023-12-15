import 'package:bookify_mobile/homepage/drawer.dart';
import 'package:flutter/material.dart';
import 'package:bookify_mobile/requestBuku/models/req_buku.dart';
import 'package:bookify_mobile/requestBuku/request_form.dart';

class RequestBookPage extends StatefulWidget {
  @override
  _RequestBookPageState createState() => _RequestBookPageState();
}

class _RequestBookPageState extends State<RequestBookPage> {
  List<BukuReq> books = [];

  void navigateToAddBookForm() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RequestForm(
          onSave: (BukuReq bookReq) {
            setState(() {
              books.add(bookReq);
            });
          },
        ),
      ),
    );
  }

   void _deleteBook(int index) {
    setState(() {
      books.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Buku'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      drawer: buildDrawer(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.blueAccent, Colors.blueGrey],
          ),
        ),
        child: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container( 
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.bookTitle,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Author: ${book.author}', style: TextStyle(fontSize: 16.0, color: Colors.grey[600])),
                  Text('Language: ${book.language}', style: TextStyle(fontSize: 16.0, color: Colors.grey[600])),
                  Text('Pages: ${book.numPages}', style: TextStyle(fontSize: 16.0, color: Colors.grey[600])),
                  Text('Published: ${book.publicationDate}', style: TextStyle(fontSize: 16.0, color: Colors.grey[600])),
                  Text('Publisher: ${book.penerbit}', style: TextStyle(fontSize: 16.0, color: Colors.grey[600])),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteBook(index),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddBookForm,
        child: const Icon(Icons.add),
        tooltip: 'Add buku untuk direquest',
      ),
    );
  }
}
