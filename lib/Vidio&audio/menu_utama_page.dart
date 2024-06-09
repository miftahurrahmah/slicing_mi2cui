import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slicing_mi2cui/Vidio&audio/audio_player_page.dart';
import 'package:slicing_mi2cui/Vidio&audio/vidio_player_page.dart';

import '../lat_audio/audio.dart';

class MenuUtamaPage extends StatelessWidget {
  const MenuUtamaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Media Player App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              SizedBox(height: 40,),
              MaterialButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                => VidioPlayerPage()
                ));
              },
                child: Text('Vidio Player'),
                textColor: Colors.white,
                color: Colors.blueAccent,
              ),
              SizedBox(height: 20,),
              MaterialButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                => AudioPlayerPage()
                ));
              },
                child: Text('Audio Player'),
                textColor: Colors.white,
                color: Colors.blueAccent,
              )
            ],
          ),
        )

      ),
    );
  }
}
