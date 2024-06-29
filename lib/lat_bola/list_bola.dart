// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:slicing_mi2cui/lat_bola/model_listbola.dart';
// import 'package:slicing_mi2cui/lat_bola/detail_page.dart';
//
// // Fungsi untuk parsing JSON dari string
// ModelBola modelBolaFromJson(String str) => ModelBola.fromJson(json.decode(str));
//
// String modelBolaToJson(ModelBola data) => json.encode(data.toJson());
//
// // Model data
// class ModelBola {
//   bool isSuccess;
//   String message;
//   List<Datum> data;
//
//   ModelBola({
//     required this.isSuccess,
//     required this.message,
//     required this.data,
//   });
//
//   factory ModelBola.fromJson(Map<String, dynamic> json) => ModelBola(
//     isSuccess: json["isSuccess"],
//     message: json["message"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "isSuccess": isSuccess,
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   String id;
//   StrEvent strEvent;
//   String strFilename;
//   StrLeague strLeague;
//   String strSeason;
//   DateTime dateEvent;
//   String? strTime;
//   String? strPoster;
//
//   Datum({
//     required this.id,
//     required this.strEvent,
//     required this.strFilename,
//     required this.strLeague,
//     required this.strSeason,
//     required this.dateEvent,
//     required this.strTime,
//     required this.strPoster,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     strEvent: strEventValues.map[json["strEvent"]]!,
//     strFilename: json["strFilename"],
//     strLeague: strLeagueValues.map[json["strLeague"]]!,
//     strSeason: json["strSeason"],
//     dateEvent: DateTime.parse(json["dateEvent"]),
//     strTime: json["strTime"],
//     strPoster: json["strPoster"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "strEvent": strEventValues.reverse[strEvent],
//     "strFilename": strFilename,
//     "strLeague": strLeagueValues.reverse[strLeague],
//     "strSeason": strSeason,
//     "dateEvent":
//     "${dateEvent.year.toString().padLeft(4, '0')}-${dateEvent.month.toString().padLeft(2, '0')}-${dateEvent.day.toString().padLeft(2, '0')}",
//     "strTime": strTime,
//     "strPoster": strPoster,
//   };
// }
//
// enum StrEvent {
//   ARSENAL_VS_CHELSEA,
// }
//
// final strEventValues = EnumValues({
//   "Arsenal vs Chelsea": StrEvent.ARSENAL_VS_CHELSEA
// });
//
// enum StrLeague {
//   CLUB_FRIENDLIES,
//   ENGLISH_PREMIER_LEAGUE,
//   FA_CUP,
// }
//
// final strLeagueValues = EnumValues({
//   "Club Friendlies": StrLeague.CLUB_FRIENDLIES,
//   "English Premier League": StrLeague.ENGLISH_PREMIER_LEAGUE,
//   "FA Cup": StrLeague.FA_CUP,
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
//
// // Fungsi untuk mendapatkan data dari API atau JSON
// Future<ModelBola> fetchData() async {
//   final response = await http
//       .get(Uri.parse('http://192.168.146.195/lat_listbola/list_bola.php'));
//
//   if (response.statusCode == 200) {
//     return modelBolaFromJson(response.body);
//   } else {
//     throw Exception('Failed to load data');
//   }
// }
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late Future<ModelBola> futureData;
//
//   @override
//   void initState() {
//     super.initState();
//     futureData = fetchData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('List Bola'),
//       ),
//       body: Center(
//         child: FutureBuilder<ModelBola>(
//           future: futureData,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text("${snapshot.error}");
//             } else if (snapshot.hasData) {
//               return Column(
//                 children: [
//                   Display the image
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(width: 16),
//                       snapshot.data!.strPoster != null
//                           ? Image.network(
//                         snapshot.data!.strPoster!,
//                         width: 400,
//                         height: 200,
//                       )
//                           : Container(
//                         width: 400,
//                         height: 200,
//                         color: Colors.grey,
//                         child: Icon(Icons.image_not_supported),
//                       ),
//                     ],
//                   ),
//                   // Display the list of items
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: snapshot.data!.data.length,
//                       itemBuilder: (context, index) {
//                         final item = snapshot.data!.data[index];
//                         return ListTile(
//                           title: Text(item.strEvent.toString().split('.').last),
//                           subtitle:
//                           Text(item.strLeague.toString().split('.').last),
//                           trailing:
//                           Text(item.dateEvent.toString().split(' ').first),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => DetailPage(data: item),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               );
//             } else {
//               return Text("No data available");
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class DetailPage extends StatelessWidget {
//   final Datum data;
//
//   DetailPage({required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail Event'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(width: 16),
//                 data.strPoster != null
//                     ? Image.network(
//                   data.strPoster!,
//                   width: 400,
//                   height: 200,
//                 )
//                     : Container(
//                   width: 400,
//                   height: 200,
//                   color: Colors.grey,
//                   child: Icon(Icons.image_not_supported),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Event: ${data.strEvent}',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'League: ${data.strLeague}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Season: ${data.strSeason}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Date: ${data.dateEvent.toString().split(' ').first}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Time: ${data.strTime ?? 'Not specified'}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Poster: ${data.strPoster ?? 'Not specified'}',
//               style: TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
