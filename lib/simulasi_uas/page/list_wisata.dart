import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/model_wisata.dart';
import 'detail_wisata.dart';
import 'edit_wisata.dart';
import 'tambah_wisata.dart';
import 'maps.dart';

class PageListWisata extends StatefulWidget {
  const PageListWisata({Key? key}) : super(key: key);

  @override
  State<PageListWisata> createState() => _PageListWisataState();
}

class _PageListWisataState extends State<PageListWisata> {
  late Future<List<Datum>> futureWisata;

  @override
  void initState() {
    super.initState();
    futureWisata = fetchWisata();
  }

  Future<List<Datum>> fetchWisata() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.17/lat_wisata/listWisata.php'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final modelWisata = ModelWisata.fromJson(jsonResponse);
      return modelWisata.data;
    } else {
      throw Exception('Failed to load wisata');
    }
  }

  void fetchData() {
    setState(() {
      futureWisata = fetchWisata(); // Reload data
    });
  }

  void deleteWisata(BuildContext context, Datum wisata) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.17/lat_wisata/delete_wisata.php'),
        body: {
          'id': wisata.id.toString(), // Mengirim ID wisata untuk dihapus
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['value'] == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Wisata berhasil dihapus'),
            ),
          );
          fetchData(); // Memuat ulang data setelah penghapusan
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal menghapus wisata: ${jsonResponse['message']}'),
            ),
          );
        }
      } else {
        throw Exception('Failed to delete wisata');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghubungi server untuk menghapus wisata'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Wisata'),
      ),
      body: FutureBuilder<List<Datum>>(
        future: futureWisata,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No wisata found'));
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                fetchData(); // Reload data
              },
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return WisataCard(
                    wisata: snapshot.data![index],
                    refreshData: fetchData, // Memperbaiki parameter refreshData
                    deleteWisata: () {
                      deleteWisata(context, snapshot.data![index]); // Memperbaiki akses ke deleteWisata
                    },
                    editWisata: () {
                      _editData(snapshot.data![index]); // Memanggil fungsi editWisata
                    },
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapsAllPage(refreshData: fetchData),
                ),
              ).then((value) {
                if (value == true) {
                  fetchData();
                }
              });
            },
            child: const Icon(Icons.location_on),
            backgroundColor: Colors.blue,
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageTambahWisata(refreshData: fetchData),
                ),
              ).then((value) {
                if (value == true) {
                  fetchData();
                }
              });
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  void _editData(Datum data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdatePage(
          wisata: data,
          refreshData: fetchData,
        ),
      ),
    ).then((value) {
      if (value == true) {
        // Jika berhasil mengedit data, perbarui tampilan
        fetchData();
      }
    });
  }
}

class WisataCard extends StatelessWidget {
  final Datum wisata;
  final VoidCallback refreshData;
  final VoidCallback deleteWisata;
  final VoidCallback editWisata; // Menambahkan fungsi edit

  const WisataCard({
    required this.wisata,
    required this.refreshData,
    required this.deleteWisata,
    required this.editWisata,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tampilan gambar
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(
                    'http://192.168.1.17/lat_wisata/gambar/${wisata.gambar ?? ''}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: wisata.gambar != null && wisata.gambar!.isNotEmpty
                  ? null
                  : const Icon(
                Icons.broken_image,
                size: 100,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wisata.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Lokasi: ${wisata.lokasi}'),
                  const SizedBox(height: 8),
                  Text(
                    wisata.deskripsi,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text('Profil: ${wisata.profil}'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageDetailWisata(data: wisata),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: editWisata, // Memanggil fungsi editWisata
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Hapus Wisata'),
                              content: Text('Anda yakin ingin menghapus wisata ini?'),
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
                                    deleteWisata(); // Panggil fungsi delete
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
          ],
        ),
      ),
    );
  }
}
