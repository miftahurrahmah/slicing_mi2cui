import 'package:flutter/material.dart';
import 'package:slicing_mi2cui/LatRumahSakit/page/list_provinsi.dart';
import 'package:slicing_mi2cui/LatihanSlicing/BottomNavigation.dart';
import 'package:slicing_mi2cui/LatihanSlicing/Home.dart';
import 'package:slicing_mi2cui/Vidio&audio/menu_utama_page.dart';
import 'package:slicing_mi2cui/kamera&maps/pageUtama.dart';
import 'package:slicing_mi2cui/Latihan/page_home.dart';
import 'package:slicing_mi2cui/kamera&maps/page_maps.dart';
import 'package:slicing_mi2cui/lat_audio/audio.dart';
import 'package:slicing_mi2cui/lat_bola/list_bola.dart';
import 'package:slicing_mi2cui/lat_vidio/vidio.dart';
import 'package:slicing_mi2cui/list_note/page/note.dart';
import 'package:slicing_mi2cui/screen_page/welcome_page.dart';
import 'package:slicing_mi2cui/list_user/list_user.dart';
import 'package:slicing_mi2cui/simulasi_uas/page/list_wisata.dart';

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

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PageListWisata(),
      debugShowCheckedModeBanner: false,
    );
  }
}



