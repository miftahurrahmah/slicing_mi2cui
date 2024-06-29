import 'package:flutter/material.dart';
import 'package:slicing_mi2cui/list_note/model/model_note.dart';

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
