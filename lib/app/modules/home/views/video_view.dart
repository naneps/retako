import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/x_video_player.dart';

class VideoView extends GetView {
  const VideoView({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      borderColor: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(10.0),
      width: Get.width,
      color: Colors.transparent,
      hasBorder: true,
      height: Get.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Video Edukasi",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          RoundedContainer(
            width: Get.width,
            height: 200,
            child: const ReusableVideoPlayer(
                videoUrl:
                    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
          ),
          Expanded(
            child: ListView.builder(
              itemExtent: 200,
              itemBuilder: (context, index) {
                return RoundedContainer(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10.0),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white,
                      Theme.of(context).primaryColor.withOpacity(0.5),
                      Theme.of(context).primaryColor.withOpacity(0.5),
                      Colors.white,
                      Colors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  hasBorder: true,
                  borderColor: Theme.of(context).primaryColor,
                  child: const Text("Video"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
