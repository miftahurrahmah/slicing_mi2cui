import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

enum PlayerState { stopped, playing, paused }

class PageLatAudio extends StatefulWidget {
  const PageLatAudio({super.key});

  @override
  State<PageLatAudio> createState() => _PageLatAudioState();
}

class _PageLatAudioState extends State<PageLatAudio> {
  List<Datum> _audioList = [];
  bool _isLoading = true;
  final List<AudioPlayer> _audioPlayers = [];
  final List<PlayerState> _playerStates = [];

  @override
  void initState() {
    super.initState();
    _fetchAudioData();
  }

  Future<void> _fetchAudioData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.15/lat_audio/audio.php'));

      if (response.statusCode == 200) {
        final modelAudio = modelAudioFromJson(response.body);
        if (modelAudio.isSuccess && modelAudio.data.isNotEmpty) {
          setState(() {
            _audioList = modelAudio.data;
            for (int i = 0; i < _audioList.length; i++) {
              _audioPlayers.add(AudioPlayer());
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
        throw Exception('Failed to load audio data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching audio data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _play(int index) async {
    final audioUrl = 'http://192.168.1.15/lat_audio/audio/${_audioList[index].audio}';
    try {
      final result = await _audioPlayers[index].play(audioUrl);
      if (result == 1) {
        setState(() => _playerStates[index] = PlayerState.playing);
      } else {
        print('Error while playing audio: $result');
      }
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void _pause(int index) async {
    try {
      final result = await _audioPlayers[index].pause();
      if (result == 1) {
        setState(() => _playerStates[index] = PlayerState.paused);
      } else {
        print('Error while pausing audio: $result');
      }
    } catch (e) {
      print('Error pausing audio: $e');
    }
  }

  void _stop(int index) async {
    try {
      final result = await _audioPlayers[index].stop();
      if (result == 1) {
        setState(() => _playerStates[index] = PlayerState.stopped);
      } else {
        print('Error while stopping audio: $result');
      }
    } catch (e) {
      print('Error stopping audio: $e');
    }
  }

  @override
  void dispose() {
    for (var player in _audioPlayers) {
      player.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _audioList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(16.0),
            child: ListTile(
              leading: const Icon(Icons.person, size: 50),
              title: Text(_audioList[index].judulAudio),
              trailing: Row(
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
            ),
          );
        },
      ),
    );
  }
}

// Model Classes
ModelAudio modelAudioFromJson(String str) => ModelAudio.fromJson(json.decode(str));

String modelAudioToJson(ModelAudio data) => json.encode(data.toJson());

class ModelAudio {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelAudio({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelAudio.fromJson(Map<String, dynamic> json) => ModelAudio(
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
  String judulAudio;
  String audio;

  Datum({
    required this.id,
    required this.judulAudio,
    required this.audio,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    judulAudio: json["judul_audio"],
    audio: json["audio"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul_audio": judulAudio,
    "audio": audio,
  };
}