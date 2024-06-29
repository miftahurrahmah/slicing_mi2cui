import 'dart:convert';

ModelEditWisata modelEditWisataFromJson(String str) => ModelEditWisata.fromJson(json.decode(str));

String modelEditWisataToJson(ModelEditWisata data) => json.encode(data.toJson());

class ModelEditWisata {
  int value;
  String message;

  ModelEditWisata({
    required this.value,
    required this.message,
  });

  factory ModelEditWisata.fromJson(Map<String, dynamic> json) => ModelEditWisata(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
