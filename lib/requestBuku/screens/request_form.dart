import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bookify_mobile/book_page/models/buku.dart';
import 'package:bookify_mobile/requestBuku/models/req_buku.dart';
import 'package:bookify_mobile/book_page/utils/fetch_buku.dart';

typedef OnSaveCallback = Function(BukuReq bookReq);

class RequestForm extends StatefulWidget {
  final OnSaveCallback onSave;
  const RequestForm({super.key, required this.onSave});

  @override
  State<RequestForm> createState() => _RequestForm();
}

class _RequestForm extends State<RequestForm> {
  final _formKey = GlobalKey<FormState>();
  String _bookTitle = '';
  String _author = '';
  String _language = '';
  int _numPages = 0;
  TextEditingController _publicationDateController = TextEditingController();
  TextEditingController _bookTitleController = TextEditingController();
  String _penerbit = '';
  List<Buku> _fetchedBooks = [];

  Future<bool> _isBookTitleExists(String title) async {
    _fetchedBooks = await fetchBook(title);
    for (var book in _fetchedBooks) {
      if (book.title.toLowerCase() == title.toLowerCase()) {
        return true;
      }
    }
    return false;
  }


 @override
  void dispose() {
    _publicationDateController.dispose();
    _bookTitleController.dispose();
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request a Book'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    controller: _bookTitleController,
                    decoration: InputDecoration(
                      labelText: 'Book Title',
                      border: InputBorder.none,
                      labelStyle: TextStyle(color: Colors.blueAccent),
                    ),
                    onSaved: (value) => _bookTitle = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the book title';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Author',
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.blueAccent),
                  ),
                  onSaved: (value) => _author = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the author\'s name';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Language',
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.blueAccent),
                  ),
                  onSaved: (value) => _language = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the books language';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Number of Pages',
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.blueAccent),
                  ),
                  onSaved: (value) => _numPages = int.tryParse(value!) ?? 0,
                  validator: (value) {
                    if (value == null || value.isEmpty || int.tryParse(value) == null) {
                      return 'Please enter the number of pages';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  controller: _publicationDateController,
                  decoration: InputDecoration(
                    labelText: 'Publication Date',
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.blueAccent),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _publicationDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the publication date';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Publisher',
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.blueAccent),
                  ),
                  onSaved: (value) => _penerbit = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the publisher\'s name';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
             Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fixedSize: Size(200, 40),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool exists = await _isBookTitleExists(_bookTitleController.text);
                      if (exists) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Buku ini sudah tersedia di Bookify')),
                        );
                        return;
                      }

                      _formKey.currentState!.save();

                      BukuReq newBookReq = BukuReq(
                        bookTitle: _bookTitle,
                        author: _author,
                        language: _language,
                        numPages: _numPages,
                        publicationDate: _publicationDateController.text,
                        penerbit: _penerbit,
                      );

                      widget.onSave(newBookReq);
                      _formKey.currentState!.reset();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('+ Request Buku'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}