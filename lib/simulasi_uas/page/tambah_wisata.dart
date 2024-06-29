import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/model_add.dart';

class PageTambahWisata extends StatefulWidget {
  final void Function() refreshData;

  const PageTambahWisata({Key? key, required this.refreshData}) : super(key: key);

  @override
  State<PageTambahWisata> createState() => _PageTambahWisataState();
}

class _PageTambahWisataState extends State<PageTambahWisata> {
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtLokasi = TextEditingController();
  TextEditingController txtDeskripsi = TextEditingController();
  TextEditingController txtLat = TextEditingController();
  TextEditingController txtLong = TextEditingController();
  TextEditingController txtProfil = TextEditingController();
  TextEditingController txtGambar = TextEditingController();

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> addWisata() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.post(
        Uri.parse('http://192.168.1.17/lat_wisata/add_wisata.php'),
        body: {
          "nama": txtNama.text,
          "lokasi": txtLokasi.text,
          "deskripsi": txtDeskripsi.text,
          "lat": txtLat.text,
          "long": txtLong.text,
          "profil": txtProfil.text,
          "gambar": txtGambar.text,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        ModelTambahWisata data = ModelTambahWisata.fromJson(jsonResponse);
        if (data.value == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data.message)),
          );
          widget.refreshData(); // Memuat ulang data setelah penambahan
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data.message)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add wisata: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Wisata'),
        backgroundColor: Colors.cyan,
      ),
      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextField('Nama', txtNama),
                buildTextField('Lokasi', txtLokasi),
                buildTextField('Deskripsi', txtDeskripsi),
                Row(
                  children: [
                    Expanded(child: buildTextField('Lat', txtLat)),
                    SizedBox(width: 10),
                    Expanded(child: buildTextField('Long', txtLong)),
                  ],
                ),
                buildTextField('Profil', txtProfil),
                buildTextField('Gambar', txtGambar),
                SizedBox(height: 20),
                Center(
                  child: isLoading
                      ? CircularProgressIndicator()
                      : MaterialButton(
                    minWidth: 200,
                    height: 50,
                    onPressed: () {
                      if (keyForm.currentState?.validate() == true) {
                        addWisata();
                      }
                    },
                    child: Text('Tambah Wisata', style: TextStyle(fontSize: 18)),
                    color: Colors.green,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 1, color: Colors.blueGrey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: (val) => val!.isEmpty ? "Tidak boleh kosong" : null,
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
