import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../model/model_kamar.dart' as kamarModel;
import '../model/model_rumahsakit.dart' as modelrs;

class PageDetailRS extends StatefulWidget {
  final modelrs.Datum rumahSakit;

  const PageDetailRS({Key? key, required this.rumahSakit}) : super(key: key);

  @override
  State<PageDetailRS> createState() => _PageDetailRSState();
}

class _PageDetailRSState extends State<PageDetailRS> {
  bool isLoading = false;
  List<kamarModel.Datum> listKamar = [];
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    fetchKamarData(widget.rumahSakit.id);
  }

  Future<void> fetchKamarData(String rumahSakitId) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('http://192.168.1.27/rumah_sakit/getKamar.php?id_rs=$rumahSakitId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Data kamar diterima: $data'); // Debug print

        setState(() {
          kamarModel.ModelKamar modelKamar = kamarModel.ModelKamar.fromJson(data);
          listKamar = modelKamar.data.where((kamar) => kamar.rumahsakitId == rumahSakitId).toList();
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
    final lat = double.tryParse(widget.rumahSakit.lat) ?? 0.0;
    final long = double.tryParse(widget.rumahSakit.long) ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.rumahSakit.namaRs,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, long),
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId(widget.rumahSakit.id),
                    position: LatLng(lat, long),
                    infoWindow: InfoWindow(
                      title: widget.rumahSakit.namaRs,
                      snippet: widget.rumahSakit.alamat,
                    ),
                  ),
                },
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listKamar.length,
                    itemBuilder: (context, index) {
                      final kamar = listKamar[index];
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: ListTile(
                          leading: Icon(Icons.hotel, size: 40, color: Colors.black),
                          title: Text(
                            kamar.namaKamar,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kamar Tersedia: ${int.tryParse(kamar.kamarTersedia) ?? 0}',
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Kamar Kosong: ${int.tryParse(kamar.kamarKosong) ?? 0}',
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Jumlah Antrian: ${int.tryParse(kamar.jumlahAntrian) ?? 0}',
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
