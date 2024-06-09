import 'package:flutter/material.dart';
import 'package:slicing_mi2cui/LatRumahSakit/page/list_provinsi.dart';
import 'package:slicing_mi2cui/LatihanSlicing/BottomNavigation.dart';
import 'package:slicing_mi2cui/LatihanSlicing/Home.dart';
import 'package:slicing_mi2cui/Vidio&audio/menu_utama_page.dart';
import 'package:slicing_mi2cui/kamera&maps/pageUtama.dart';
import 'package:slicing_mi2cui/Latihan/page_home.dart';
import 'package:slicing_mi2cui/kamera&maps/page_maps.dart';
import 'package:slicing_mi2cui/lat_audio/audio.dart';
import 'package:slicing_mi2cui/screen_page/welcome_page.dart';
import 'package:slicing_mi2cui/list_user/list_user.dart';

import 'Vidio&audio/audio_player_page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PageProvinsi(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, this.title}) : super(key: key);
//
//   final String? title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   // Set URL and filename
//   final String urlExample =
//       "http://ia802609.us.archive.org/13/items/quraninindonesia/001AlFaatihah.mp3";
//   final String nameExample = "Al-Fatihah";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title ?? 'Default Title'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text("Al Fatihah"),
//           Container(
//             margin: EdgeInsets.all(8.0),
//             child: PlayerWidget(url: urlExample, fileName: nameExample),
//           )
//         ],
//       ),
//     );
//   }
// }


