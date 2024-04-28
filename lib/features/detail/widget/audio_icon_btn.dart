import 'package:audioplayers/audioplayers.dart';
import 'package:flowery_tts/flowery_tts.dart';
import 'package:flutter/material.dart';

class AudioIconButton extends StatelessWidget {
  final Flowery flowery;
  final AudioPlayer player;
  final String description;

  const AudioIconButton({
    super.key,
    required this.flowery,
    required this.player,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final soundBytes = await flowery.tts(text: description, voice: 'Guy', speed: 1.2);
        await player.play(BytesSource(soundBytes));
      },
      icon: const Icon(
        Icons.hearing,
        color: Colors.white,
      ),
    );
  }
}