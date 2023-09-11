import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReusableVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ReusableVideoPlayer({super.key, required this.videoUrl});

  @override
  _ReusableVideoPlayerState createState() {
    return _ReusableVideoPlayerState();
  }
}

class _ReusableVideoPlayerState extends State<ReusableVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          // Ensure the first frame is shown before playing the video.
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          VideoPlayer(_controller),
          Center(
            child: _controller.value.isInitialized
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
