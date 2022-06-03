import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerView extends StatefulWidget {
  const AudioPlayerView({Key? key}) : super(key: key);

@override
_AudioPlayerViewState createState() => _AudioPlayerViewState();
}

class _AudioPlayerViewState extends State<AudioPlayerView> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() => _isPlaying = event == PlayerState.PLAYING);
    });

    audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    audioPlayer.onAudioPositionChanged.listen((position) {
      setState(() => _position = position);
    });
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        child: SizedBox(
            width: (size.width / 2) - 20,
            // height: (size.height / 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                displayTitle(),
                displayThumbnail(),
                Slider(
                  min: 0,
                  max: _duration.inSeconds.toDouble(),
                  value: _position.inSeconds.toDouble(),
                  onChanged: (value) async {
                    final position = Duration(seconds: value.toInt());
                    await audioPlayer.seek(position);
                    await audioPlayer.resume();
                  }
                ),
                displayDuration(),
                displayButton()
              ],
            )
          ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Padding displayTitle() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Text('Title'),
    );
  }

  Padding displayThumbnail() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'images/fmj.png',
          width: 100,
          height: 150,
          fit: BoxFit.cover
        ),
      ),
    );
  }

  Padding displayButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CircleAvatar(
        radius: 35,
        child: IconButton(
          icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () async => await handleAudioPlayer('')),
      ),
    );
  }

  String formatTime(int time) => time < 10 ? "0$time" : "$time";
  
  String formatDuration(Duration time) {
    return "${formatTime(time.inMinutes)} : ${formatTime(time.inSeconds)}";
  }

  Padding displayDuration() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(formatDuration(_position)),
          Text(formatDuration(_duration - _position))
        ],
      ),
      );
  }

  Future<void> handleAudioPlayer(filePath) async {
    filePath = 'demo/intro.mp3';

    final base = AudioCache(prefix: 'audio/');
    final url = await base.load(filePath);

    if (_isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(url.path, isLocal: true);
    }
  }
}