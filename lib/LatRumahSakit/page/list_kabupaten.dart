import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slicing_mi2cui/LatRumahSakit/page/list_rumah_sakit.dart';
import '../model/model_kabupaten.dart';

class PageKabupaten extends StatefulWidget {
  final String idProv;

  const PageKabupaten({Key? key, required this.idProv}) : super(key: key);

  @override
  _PageKabupatenState createState() => _PageKabupatenState();
}

class _PageKabupatenState extends State<PageKabupaten> {
  bool isLoading = false;
  List<Datum> listKabupaten = [];
  List<Datum> filteredKabupaten = [];
  TextEditingController searchController = TextEditingController();

  void searchKabupaten(String query) {
    setState(() {
      filteredKabupaten = listKabupaten.where((kabupaten) {
        return kabupaten.namaKabupaten.toLowerCase().contains(
            query.toLowerCase()) ||
            kabupaten.id.toLowerCase() == query.toLowerCase();
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getKabupaten();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> getKabupaten() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
          Uri.parse("http://192.168.1.27/rumah_sakit/getKabupaten.php"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          ModelKabupaten modelKabupaten = ModelKabupaten.fromJson(data);
          listKabupaten =
              modelKabupaten.data.where((datum) => datum.provinsiId ==
                  widget.idProv).toList();
          filteredKabupaten = List.from(listKabupaten);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          'List Kabupaten',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: searchKabupaten,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Cari Kabupaten...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredKabupaten.isNotEmpty
                ? ListView.builder(
              itemCount: filteredKabupaten.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageRumahSakit(kabupatenId: filteredKabupaten[index].id),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 0,
                      child: ListTile(
                        leading: const Icon(
                            Icons.location_on, color: Colors.black),
                        title: Text(
                          filteredKabupaten[index].namaKabupaten,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
                : Center(
              child: Text(
                'Data tidak ditemukan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
