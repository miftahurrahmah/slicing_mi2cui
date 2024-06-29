import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/model_note.dart';

class PageEditNote extends StatefulWidget {
  final Datum note;

  const PageEditNote({Key? key, required this.note}) : super(key: key);

  @override
  _PageEditNoteState createState() => _PageEditNoteState();
}

class _PageEditNoteState extends State<PageEditNote> {
  late TextEditingController txtJudulNote;
  late TextEditingController txtIsiNote;
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    txtJudulNote = TextEditingController(text: widget.note.judulNote);
    txtIsiNote = TextEditingController(text: widget.note.isiNote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Edit Note',
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (keyForm.currentState?.validate() == true) {
                      // Kirim data perubahan ke server
                      http.post(
                        Uri.parse('http://192.168.1.24/edukasi_server/updateNote.php'),
                        body: {
                          'id': widget.note.id,
                          'judul_note': txtJudulNote.text,
                          'isi_note': txtIsiNote.text,
                        },
                      ).then((response) {
                        if (response.statusCode == 200) {
                          var jsonResponse = json.decode(response.body);
                          if (jsonResponse['is_success'] == true) {
                            Navigator.pop(context, true); // Kembali ke halaman sebelumnya dengan sinyal berhasil
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Gagal"),
                                  content: Text("Terjadi kesalahan: ${jsonResponse['message']}"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Gagal"),
                                content: Text("Terjadi kesalahan saat mengirim data ke server"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }).catchError((error) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Gagal"),
                              content: Text("Terjadi kesalahan: $error"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    }
                  },
                  child: const Text("Simpan"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
