import 'package:exemplo_audio_player/models/audio_model.dart';
import 'package:flutter/material.dart';

class AudioScreen extends StatefulWidget {
  final AudioModel audio;
  const AudioScreen({super.key, required this.audio});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.audio.title),
      ),
    );
  }
}