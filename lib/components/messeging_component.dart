import 'package:fixed_bids/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';

class ImageComponent extends StatelessWidget {
  final String image;

  const ImageComponent({Key key, @required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress != null) {
          return CircularProgressIndicator();
        }
        return child;
      },
      errorBuilder: (context, error, stackTrace) =>
          image.contains('image_picker')
              ? Image.asset(image)
              : Icon(Icons.broken_image_outlined),
    );
  }
}

class AudioComponent extends StatefulWidget {
  final String recording;

  const AudioComponent({Key key, @required this.recording}) : super(key: key);

  @override
  State<AudioComponent> createState() => _AudioComponentState();
}

class _AudioComponentState extends State<AudioComponent> {
  FlutterSoundPlayer myPlayer = FlutterSoundPlayer();

  startPlayer() async {
    await myPlayer.openPlayer();
    await myPlayer.startPlayer(fromURI: widget.recording);
    setState(() {});
  }

  @override
  void dispose() {
    if (myPlayer != null) {
      myPlayer.closePlayer();
      myPlayer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (myPlayer.isStopped) {
          startPlayer();
        } else if (myPlayer.isPaused) {
          await myPlayer.resumePlayer();
        } else if (myPlayer.isPlaying) {
          await myPlayer.stopPlayer();
        }
        setState(() {});
      },
      child: Row(
        children: [
          Icon(
            myPlayer.isStopped ? Icons.play_arrow_rounded : Icons.stop,
            color: Colors.white,
          ),
          Text(
            '${widget.recording.split('/').last}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
