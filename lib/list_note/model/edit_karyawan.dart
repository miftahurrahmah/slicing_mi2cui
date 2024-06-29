// To parse this JSON data, do
//
//     final modelEditKaryawan = modelEditKaryawanFromJson(jsonString);

import 'dart:convert';

ModelEditKaryawan modelEditKaryawanFromJson(String str) => ModelEditKaryawan.fromJson(json.decode(str));

String modelEditKaryawanToJson(ModelEditKaryawan data) => json.encode(data.toJson());

class ModelEditKaryawan {
  bool isSuccess;
  int value;
  String message;

  ModelEditKaryawan({
    required this.isSuccess,
    required this.value,
    required this.message,
  });

  factory ModelEditKaryawan.fromJson(Map<String, dynamic> json) => ModelEditKaryawan(
    isSuccess: json["is_success"],
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess,
    "value": value,
    "message": message,
  };
}
