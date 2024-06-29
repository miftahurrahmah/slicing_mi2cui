// To parse this JSON data, do
//
//     final modelBola = modelBolaFromJson(jsonString);

import 'dart:convert';

ModelBola modelBolaFromJson(String str) => ModelBola.fromJson(json.decode(str));

String modelBolaToJson(ModelBola data) => json.encode(data.toJson());

class ModelBola {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelBola({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelBola.fromJson(Map<String, dynamic> json) => ModelBola(
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
  String id;
  StrEvent strEvent;
  String strFilename;
  StrLeague strLeague;
  String strSeason;
  DateTime dateEvent;
  String? strTime;
  String? strPoster;

  Datum({
    required this.id,
    required this.strEvent,
    required this.strFilename,
    required this.strLeague,
    required this.strSeason,
    required this.dateEvent,
    required this.strTime,
    required this.strPoster,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    strEvent: strEventValues.map[json["strEvent"]]!,
    strFilename: json["strFilename"],
    strLeague: strLeagueValues.map[json["strLeague"]]!,
    strSeason: json["strSeason"],
    dateEvent: DateTime.parse(json["dateEvent"]),
    strTime: json["strTime"],
    strPoster: json["strPoster"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "strEvent": strEventValues.reverse[strEvent],
    "strFilename": strFilename,
    "strLeague": strLeagueValues.reverse[strLeague],
    "strSeason": strSeason,
    "dateEvent": "${dateEvent.year.toString().padLeft(4, '0')}-${dateEvent.month.toString().padLeft(2, '0')}-${dateEvent.day.toString().padLeft(2, '0')}",
    "strTime": strTime,
    "strPoster": strPoster,
  };
}

enum StrEvent {
  ARSENAL_VS_CHELSEA
}

final strEventValues = EnumValues({
  "Arsenal vs Chelsea": StrEvent.ARSENAL_VS_CHELSEA
});

enum StrLeague {
  CLUB_FRIENDLIES,
  ENGLISH_PREMIER_LEAGUE,
  FA_CUP
}

final strLeagueValues = EnumValues({
  "Club Friendlies": StrLeague.CLUB_FRIENDLIES,
  "English Premier League": StrLeague.ENGLISH_PREMIER_LEAGUE,
  "FA Cup": StrLeague.FA_CUP
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
