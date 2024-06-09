import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VidioPlayerPage extends StatefulWidget {
  const VidioPlayerPage({super.key});

  @override
  State<VidioPlayerPage> createState() => _VidioPlayerPageState();
}

class _VidioPlayerPageState extends State<VidioPlayerPage> {

  late VideoPlayerController _controller;
  @override
  void initState(){
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
    ..initialize().then((_) {
      setState(() {}
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vidio Player'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Sample Video', style: TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),),
          SizedBox(height: 20,),
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ) : Container(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            _controller.value.isPlaying ?
            _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ?
              Icons.pause  : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
}
