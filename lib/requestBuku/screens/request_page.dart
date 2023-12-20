import 'package:bookify_mobile/homepage/drawer.dart';
import 'package:flutter/material.dart';
import 'package:bookify_mobile/requestBuku/models/req_buku.dart';
import 'package:bookify_mobile/requestBuku/screens/request_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class RequestBookPage extends StatefulWidget {
  @override
  _RequestBookPageState createState() => _RequestBookPageState();
}

class BookSearchDelegate extends SearchDelegate<BukuReq?> {
  final List<BukuReq> books;
  final Function(BukuReq) onDelete;


  BookSearchDelegate(this.books, {required this.onDelete});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<BukuReq> results = books.where((book) => book.bookTitle.toLowerCase().contains(query.toLowerCase())).toList();
    
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final book = results[index];
        return _buildBookCard(book, index, context);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<BukuReq> suggestions = books.where((book) => book.bookTitle.toLowerCase().startsWith(query.toLowerCase())).toList();
    
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final book = suggestions[index];
        return _buildBookCard(book, index, context);
      },
    );
  }

  Widget _buildBookCard(BukuReq book, int index, BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: CircleAvatar(
          child: Icon(Icons.book, color: Colors.white),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          book.bookTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${book.bookTitle}'),
            Text('Author: ${book.author}'),
            Text('Pages: ${book.numPages.toString()}'),
            Text('Language: ${book.language}'),
            Text('Published: ${book.publicationDate}'),
            Text('Publisher: ${book.penerbit}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: () {
            onDelete(book);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${book.bookTitle} has been deleted"),
                backgroundColor: Colors.redAccent,
              ),
            );
            close(context, null);
          },
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Buku: ${book.bookTitle} oleh ${book.author} sudah direquest."),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}

class _RequestBookPageState extends State<RequestBookPage> {
  List<BukuReq> books = [];

  List<BukuReq> _searchBooks(String query) {
  if (query.isEmpty) return books;
  return books.where((book) => book.bookTitle.toLowerCase().contains(query.toLowerCase())).toList();
}

@override
void initState(){
  super.initState();
  _loadBooks();
}

void _saveBooks() async {
    final prefs = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(books.map((e) => e.toJson()).toList());
    await prefs.setString('saved_books', encodedData);
  }

  void _loadBooks() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedBooks = prefs.getString('saved_books');
    if (savedBooks != null) {
      Iterable decodedData = jsonDecode(savedBooks);
      books = decodedData.map((e) => BukuReq.fromJson(e)).toList();
    }
    setState(() {});
  }

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

  void _deleteBook(BukuReq bookToDelete) {
  setState(() {
    books.removeWhere((book) => book.id == bookToDelete.id);
  });
  _saveBooks();
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
              showSearch(
                context: context, 
                delegate: BookSearchDelegate(
                  books,
                  onDelete: (bookToDelete){
                    _deleteBook(bookToDelete);
                  }
                  ));
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
                      onPressed: (){
                        _deleteBook(book);
                      }
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
