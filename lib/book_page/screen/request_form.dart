import 'package:flutter/material.dart';
import 'package:bookify_mobile/book_page/utils/fetch_buku.dart';
import 'package:bookify_mobile/homepage/drawer.dart';


class RequestForm extends StatefulWidget {
  @override
  _RequestForm createState() => _RequestForm();
}

class _RequestForm extends State<RequestForm> {
  final _formKey = GlobalKey<FormState>();
  String _bookTitle = '';
  String _author = '';
  String _language = '';
  int _numPages = 0;
  // TextEditingController _tahunTerbit = TextEditingController();
  String _penerbit = '';
  
  
  // Add more fields if necessary

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request a Book'),
      ),
      // drawer:  buildDrawer(context),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Book Title'),
                onSaved: (value) => _bookTitle = value!,
                // Add validation if necessary
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Author'),
                onSaved: (value) => _author = value!,
                // Add validation if necessary
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Jumlah Halaman"),
                onSaved: (value) {
                 _numPages = int.tryParse(value!) ?? 0;
                },
                // Tambahkan validator untuk memastikan input adalah angka
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a number';
                  }
                  return null;
                },
              ),
            //   TextFormField(
            //   controller: _dateController,
            //   decoration: InputDecoration(labelText: "Publication Date"),
            //   readOnly: true,  // Membuat field hanya dapat dibaca, tidak dapat ditulis langsung
            //   onTap: () async {
            //     DateTime? pickedDate = await showDatePicker(
            //       context: context,
            //       initialDate: DateTime.now(),
            //       firstDate: DateTime(1900),
            //       lastDate: DateTime(2100),
            //     );
            //     if (pickedDate != null) {
            //       String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            //       setState(() {
            //         _dateController.text = formattedDate; // Menampilkan tanggal yang dipilih
            //       });
            //     }
            //   },
            // ),
              TextFormField(
                decoration: InputDecoration(labelText: "Penerbit"),
                onSaved: (value) => _penerbit = value!,
              ),
              // Add more input fields if necessary
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Handle the form submission logic, including API calls
                  }
                },
                child: Text('Request Buku'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
