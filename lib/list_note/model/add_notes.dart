// To parse this JSON data, do
//
//     final modelAddNote = modelAddNoteFromJson(jsonString);

import 'dart:convert';

ModelAddNote modelAddNoteFromJson(String str) => ModelAddNote.fromJson(json.decode(str));

String modelAddNoteToJson(ModelAddNote data) => json.encode(data.toJson());

class ModelAddNote {
  bool isSuccess;
  int value;
  String message;

  ModelAddNote({
    required this.isSuccess,
    required this.value,
    required this.message,
  });

  factory ModelAddNote.fromJson(Map<String, dynamic> json) => ModelAddNote(
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
