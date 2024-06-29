import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

import 'detail.dart';

enum PlayerState { stopped, playing, paused }

class PageLatVideo extends StatefulWidget {
  const PageLatVideo({super.key});

  @override
  State<PageLatVideo> createState() => _PageLatVideoState();
}

class _PageLatVideoState extends State<PageLatVideo> {
  List<Datum> _videoList = [];
  bool _isLoading = true;
  final List<VideoPlayerController> _videoPlayers = [];
  final List<PlayerState> _playerStates = [];

  @override
  void initState() {
    super.initState();
    _fetchVideoData();
  }

  Future<void> _fetchVideoData() async {
    try {
      final response = await http.get(Uri.parse('http://10.127.235.82/lat_vidio/vidio.php'));

      if (response.statusCode == 200) {
        final modelVideo = modelVideoFromJson(response.body);
        if (modelVideo.isSuccess && modelVideo.data.isNotEmpty) {
          setState(() {
            _videoList = modelVideo.data;
            for (int i = 0; i < _videoList.length; i++) {
              _videoPlayers.add(VideoPlayerController.network('http://10.127.235.82/lat_vidio/vidio/${_videoList[i].vidio}')
                ..initialize().then((_) {
                  setState(() {});
                }));
              _playerStates.add(PlayerState.stopped);
            }
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load video data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching video data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _play(int index) {
    final player = _videoPlayers[index];
    player.play();
    setState(() => _playerStates[index] = PlayerState.playing);
  }

  void _pause(int index) {
    final player = _videoPlayers[index];
    player.pause();
    setState(() => _playerStates[index] = PlayerState.paused);
  }

  void _stop(int index) {
    final player = _videoPlayers[index];
    player.pause();
    player.seekTo(Duration.zero);
    setState(() => _playerStates[index] = PlayerState.stopped);
  }

  @override
  void dispose() {
    for (var player in _videoPlayers) {
      player.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _videoList.length,
        itemBuilder: (context, index) {
          final player = _videoPlayers[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(
                    videoUrl: 'http://10.127.235.82/lat_vidio/vidio/${_videoList[index].vidio}',
                    title: _videoList[index].judul,
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person, size: 50),
                    title: Text(_videoList[index].judul),
                  ),
                  if (player.value.isInitialized)
                    AspectRatio(
                      aspectRatio: player.value.aspectRatio,
                      child: VideoPlayer(player),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_videoList[index].deskripsi),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.play_arrow),
                        onPressed: _playerStates[index] == PlayerState.playing ? null : () => _play(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.pause),
                        onPressed: _playerStates[index] == PlayerState.playing ? () => _pause(index) : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.stop),
                        onPressed: _playerStates[index] == PlayerState.playing || _playerStates[index] == PlayerState.paused ? () => _stop(index) : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// To parse this JSON data, do
//
//     final modelVideo = modelVideoFromJson(jsonString);

ModelVidio modelVideoFromJson(String str) => ModelVidio.fromJson(json.decode(str));

String modelVideoToJson(ModelVidio data) => json.encode(data.toJson());

class ModelVidio {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelVidio({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelVidio.fromJson(Map<String, dynamic> json) => ModelVidio(
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
  String judul;
  String deskripsi;
  String vidio;

  Datum({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.vidio,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    judul: json["judul"],
    deskripsi: json["deskripsi"],
    vidio: json["vidio"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul": judul,
    "deskripsi": deskripsi,
    "vidio": vidio,
  };
}
