import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:slicing_mi2cui/list_note/page/tambah_notes.dart';


class PageListNote extends StatefulWidget {
  const PageListNote({Key? key}) : super(key: key);

  @override
  State<PageListNote> createState() => _PageListNoteState();
}

class _PageListNoteState extends State<PageListNote> {
  late Future<List<Datum>> futureNotes;

  @override
  void initState() {
    super.initState();
    futureNotes = fetchNotes();
  }

  Future<List<Datum>> fetchNotes() async {
    final response = await http.get(Uri.parse('http://192.168.146.195/lat_note/notes.php'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final modelNote = ModelNote.fromJson(jsonResponse);
      return modelNote.data;
    } else {
      throw Exception('Failed to load notes');
    }
  }

  void fetchData() {
    setState(() {
      futureNotes = fetchNotes(); // Memuat ulang data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Note'),
      ),
      body: FutureBuilder<List<Datum>>(
        future: futureNotes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notes found'));
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                fetchData(); // Memuat ulang data
              },
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return NoteCard(note: snapshot.data![index], fetchData: fetchData);
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageTambahNote(),
            ),
          ).then((value) {
            if (value == true) {
              fetchData(); // Memuat ulang data setelah kembali dari PageTambahNote
            }
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final Datum note;
  final VoidCallback fetchData; // Callback untuk memuat ulang data

  const NoteCard({required this.note, required this.fetchData});

  void deleteNote(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.146.195/lat_note/delete_notes.php'),
        body: {
          'id': note.id,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['is_success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Catatan berhasil dihapus'),
            ),
          );
          fetchData(); // Memuat ulang data setelah penghapusan
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal menghapus catatan: ${jsonResponse['message']}'),
            ),
          );
        }
      } else {
        throw Exception('Failed to delete note');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghubungi server untuk menghapus catatan'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.judulNote,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(note.isiNote),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageDetailNote(data: note),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _editNote(context, note); // Panggil fungsi edit
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Hapus Catatan'),
                        content: Text('Anda yakin ingin menghapus catatan ini?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Tutup dialog
                            },
                            child: Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Tutup dialog
                              deleteNote(context); // Panggil fungsi delete
                            },
                            child: Text('Hapus', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PageDetailNote extends StatelessWidget {
  final Datum data;

  const PageDetailNote({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Note"),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              data.judulNote,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: Text(
              data.isiNote,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}

TextEditingController _titleController = TextEditingController();
TextEditingController _contentController = TextEditingController();

Future<void> _editNote(BuildContext context, Datum note) async {
  _titleController.text = note.judulNote;
  _contentController.text = note.isiNote;

  bool editConfirmed = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Edit Note'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Judul'),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _contentController,
            decoration: InputDecoration(labelText: 'Isi'),
            maxLines: null, // Mengizinkan input multi baris
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, true); // Tutup dialog dengan konfirmasi edit
          },
          child: Text('Simpan'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, false); // Tutup dialog tanpa menyimpan
          },
          child: Text('Batal'),
        ),
      ],
    ),
  );

  if (editConfirmed != null && editConfirmed) {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.146.195/lat_note/edit_notes.php'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'id': note.id,
          'judul_note': _titleController.text,
          'isi_note': _contentController.text,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['is_success'] == true) {
          // Update data catatan di dalam list
          note.judulNote = _titleController.text;
          note.isiNote = _contentController.text;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Catatan berhasil diperbarui.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal memperbarui catatan: ${jsonResponse['message']}')),
          );
        }
      } else {
        throw Exception('Gagal memperbarui catatan');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui catatan: $e')),
      );
    }
  }
}



ModelNote modelNoteFromJson(String str) => ModelNote.fromJson(json.decode(str));

String modelNoteToJson(ModelNote data) => json.encode(data.toJson());

class ModelNote {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelNote({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelNote.fromJson(Map<String, dynamic> json) => ModelNote(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String judulNote;
  String isiNote;

  Datum({
    required this.id,
    required this.judulNote,
    required this.isiNote,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    judulNote: json["judul_note"],
    isiNote: json["isi_note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul_note": judulNote,
    "isi_note": isiNote,
  };
}