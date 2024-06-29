import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/add_notes.dart';

class PageTambahNote extends StatefulWidget {
  const PageTambahNote({Key? key}) : super(key: key);

  @override
  State<PageTambahNote> createState() => _PageTambahNoteState();
}

class _PageTambahNoteState extends State<PageTambahNote> {
  TextEditingController txtJudulNote = TextEditingController();
  TextEditingController txtIsiNote = TextEditingController();

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> tambahNote() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response response = await http.post(
        Uri.parse('http://192.168.146.195/lat_note/add_notes.php'),
        body: {
          "judul_note": txtJudulNote.text,
          "isi_note": txtIsiNote.text,
        },
      );

      ModelAddNote data = modelAddNoteFromJson(response.body);

      setState(() {
        isLoading = false;
      });

      if (data.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data.message}')),
        );
        Navigator.pop(context, true); // Kembali ke halaman sebelumnya dengan hasil true
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data.message}')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: ${e.toString()}')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Tambah Note',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                  controller: txtJudulNote,
                  decoration: InputDecoration(
                    hintText: 'Judul Note',
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                  controller: txtIsiNote,
                  maxLines: null, // Mengizinkan multiple lines
                  decoration: InputDecoration(
                    hintText: 'Isi Note',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (keyForm.currentState?.validate() == true) {
                      await tambahNote();
                    }
                  },
                  child: Text('SIMPAN'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
