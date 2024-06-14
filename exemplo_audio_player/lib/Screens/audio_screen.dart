import 'package:audioplayers/audioplayers.dart';
import 'package:exemplo_audio_player/models/audio_model.dart';
import 'package:flutter/material.dart';

class AudioScreen extends StatefulWidget {
  final AudioModel audio;
  const AudioScreen({super.key, required this.audio});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  bool _isPlaying = true;
  late AudioPlayer _player;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _player.dispose();
    super.dispose();
  }

  void _playPause(){
    if(_isPlaying){
      _player.pause();
      setState(() {
        _isPlaying = false;
      });
    }else{
      _player.play(UrlSource(widget.audio.url));
      setState(() {
        _isPlaying = true;
      });
    }
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.audio.title),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              iconSize: 60,
              onPressed: (){
                _playPause();
              },
            ),
            Text(
              _isPlaying? 'Reproduzindo' : 'Pausado',
              style: const TextStyle(
                fontSize: 20,
              ))
          ],
        ),)
    );
  }
}