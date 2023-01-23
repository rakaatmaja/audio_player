import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayer/audio_model.dart';
import 'package:flutter/services.dart' as rootBundle;

class PlayAudio extends StatefulWidget {
  final AudioNiat audioNiat;
  const PlayAudio({Key? key, required this.audioNiat}) : super(key: key);
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<PlayAudio> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration();
  Duration position = Duration();

  bool playing = false;

  Future<List<AudioNiat>> readJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/audio.dart');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => AudioNiat.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          slider(),
          InkWell(
            onTap: () {
              getAudio();
            },
            child: Icon(
              playing == false
                  ? Icons.play_circle_outline
                  : Icons.pause_circle_outline,
              size: 100,
              color: Colors.blue,
            ),
          ),
          Center(
            child: Text(''),
          )
        ],
      ),
    );
  }

  Widget slider() {
    return Slider.adaptive(
      min: 0.0,
      value: position.inSeconds.toDouble(),
      max: duration.inSeconds.toDouble(),
      onChanged: (double val) {
        setState(() {
          audioPlayer.seek(Duration(seconds: val.toInt()));
        });
      },
    );
  }

  void getAudio() async {
    String url =
        'https://firebasestorage.googleapis.com/v0/b/projek3-3d5fb.appspot.com/o/niatsolat%2Fisya.mp3?alt=media&token=4aad66ec-eaec-44f3-bbdc-b58ca942b06a';

    if (playing) {
      var res = await audioPlayer.pause();
      if (res == 1) {
        setState(() {
          playing = false;
        });
      }
    } else {
      var res = await audioPlayer.play(url, isLocal: true);
      if (res == 1) {
        setState(() {
          playing = true;
        });
      }
    }

    audioPlayer.onDurationChanged.listen((Duration dd) {
      setState(() {
        duration = dd;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration dd) {
      setState(() {
        position = dd;
      });
    });
  }
}
