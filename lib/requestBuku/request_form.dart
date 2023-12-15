import 'package:bookify_mobile/requestBuku/models/req_buku.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  String _penerbit = '';

   @override
  void dispose() {
    _publicationDateController.dispose();
    super.dispose();
  }


  @override
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request a Book'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children:  <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Book Title'),
                onSaved: (value) => _bookTitle = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the book title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Author'),
                onSaved: (value) => _author = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the author\'s name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Jumlah Halaman"),
                onSaved: (value) {
                 _numPages = int.tryParse(value!) ?? 0;
                },
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _publicationDateController,
                decoration:const InputDecoration(labelText: 'Publication Date'),
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
              TextFormField(
                decoration:const InputDecoration(labelText: "Penerbit"),
                onSaved: (value) => _penerbit = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the publisher\'s name';
                  }
                  return null;
                },
              ),
             ElevatedButton(
                onPressed: () {
                if (_formKey.currentState!.validate()) {
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
            ],
          ),
        ),
      ),
    );
  }
}
