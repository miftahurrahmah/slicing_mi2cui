// To parse this JSON data, do
//
//     final modelFilter = modelFilterFromJson(jsonString);

import 'dart:convert';

List<ModelFilter> modelFilterFromJson(String str) => List<ModelFilter>.from(json.decode(str).map((x) => ModelFilter.fromJson(x)));

String modelFilterToJson(List<ModelFilter> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelFilter {
  String id;
  String namaKabupaten;
  String provinsiId;

  ModelFilter({
    required this.id,
    required this.namaKabupaten,
    required this.provinsiId,
  });

  factory ModelFilter.fromJson(Map<String, dynamic> json) => ModelFilter(
    id: json["id"],
    namaKabupaten: json["nama_kabupaten"],
    provinsiId: json["provinsi_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_kabupaten": namaKabupaten,
    "provinsi_id": provinsiId,
  };
}
