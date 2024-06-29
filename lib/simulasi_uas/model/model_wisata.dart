// To parse this JSON data, do
//
//     final modelWisata = modelWisataFromJson(jsonString);

import 'dart:convert';

ModelWisata modelWisataFromJson(String str) => ModelWisata.fromJson(json.decode(str));

String modelWisataToJson(ModelWisata data) => json.encode(data.toJson());

class ModelWisata {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelWisata({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelWisata.fromJson(Map<String, dynamic> json) => ModelWisata(
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
  final String id;
  final String nama;
  final String lokasi;
  final String deskripsi;
  final String lat;
  final String long;
  final String profil;
  final String gambar;

  Datum({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.deskripsi,
    required this.lat,
    required this.long,
    required this.profil,
    required this.gambar,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'],
      nama: json['nama'],
      lokasi: json['lokasi'],
      deskripsi: json['deskripsi'],
      lat: json['lat'],
      long: json['long'],
      profil: json['profil'],
      gambar: json['gambar'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama': nama,
    'lokasi': lokasi,
    'deskripsi': deskripsi,
    'lat': lat,
    'long': long,
    'profil': profil,
    'gambar': gambar,
  };
}

