// To parse this JSON data, do
//
//     final modelTambahWisata = modelTambahWisataFromJson(jsonString);

import 'dart:convert';

ModelTambahWisata modelTambahWisataFromJson(String str) => ModelTambahWisata.fromJson(json.decode(str));

String modelTambahWisataToJson(ModelTambahWisata data) => json.encode(data.toJson());

class ModelTambahWisata {
  int value;
  String message;

  ModelTambahWisata({
    required this.value,
    required this.message,
  });

  factory ModelTambahWisata.fromJson(Map<String, dynamic> json) => ModelTambahWisata(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
