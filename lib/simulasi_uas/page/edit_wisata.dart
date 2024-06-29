import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/model_wisata.dart';

class UpdatePage extends StatefulWidget {
  final Datum wisata;
  final Function refreshData;

  UpdatePage({required this.wisata, required this.refreshData});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _idController;
  late TextEditingController _namaController;
  late TextEditingController _lokasiController;
  late TextEditingController _deskripsiController;
  late TextEditingController _latController;
  late TextEditingController _longController;
  late TextEditingController _profilController;
  late TextEditingController _gambarController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.wisata.id);
    _namaController = TextEditingController(text: widget.wisata.nama);
    _lokasiController = TextEditingController(text: widget.wisata.lokasi);
    _deskripsiController = TextEditingController(text: widget.wisata.deskripsi);
    _latController = TextEditingController(text: widget.wisata.lat);
    _longController = TextEditingController(text: widget.wisata.long);
    _profilController = TextEditingController(text: widget.wisata.profil);
    _gambarController = TextEditingController(text: widget.wisata.gambar);
  }

  Future<void> updateWisata() async {
    final url = Uri.parse('http://192.168.1.17/lat_wisata/updateWisata.php');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'id': _idController.text,
        'nama': _namaController.text,
        'lokasi': _lokasiController.text,
        'deskripsi': _deskripsiController.text,
        'lat': _latController.text,
        'long': _longController.text,
        'profil': _profilController.text,
        'gambar': _gambarController.text,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['value'] == 1) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Update successful: ${responseData['message']}'),
          backgroundColor: Colors.green,
        ));
        widget.refreshData();
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Update failed: ${responseData['message']}'),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to connect to the server. Status code: ${response.statusCode}'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Wisata')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'ID'),
                readOnly: true,
              ),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lokasiController,
                decoration: InputDecoration(labelText: 'Lokasi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _deskripsiController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _latController,
                decoration: InputDecoration(labelText: 'Latitude'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the latitude';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _longController,
                decoration: InputDecoration(labelText: 'Longitude'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the longitude';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _profilController,
                decoration: InputDecoration(labelText: 'Profil'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the profile';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _gambarController,
                decoration: InputDecoration(labelText: 'Gambar'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the image';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    updateWisata();
                  }
                },
                child: Text('Update Wisata'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
