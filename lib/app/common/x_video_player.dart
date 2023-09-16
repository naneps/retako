// ignore_for_file: library_private_types_in_public_api

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReusableVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ReusableVideoPlayer({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  _ReusableVideoPlayerState createState() {
    return _ReusableVideoPlayerState();
  }
}

class _ReusableVideoPlayerState extends State<ReusableVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9, // Atur rasio aspek video sesuai kebutuhan Anda
      autoPlay: true, // Otomatis memutar video saat widget pertama kali dibuat
      looping: false, // Apakah video akan diputar berulang
      // Placeholder untuk ditampilkan selama video dimuat
      placeholder: const Center(
        child: CircularProgressIndicator(),
      ),
      // Tampilkan ikon play/pause pada overlay
      overlay: GestureDetector(
        onTap: () {
          setState(() {
            if (_videoPlayerController.value.isPlaying) {
              _videoPlayerController.pause();
            } else {
              _videoPlayerController.play();
            }
          });
        },
        child: Icon(
          _videoPlayerController.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
          size: 50.0,
          color: Colors.white,
        ),
      ),
      // Opsi lainnya seperti mengatur volume, fitur-fitur tampilan, dan lain-lain.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
