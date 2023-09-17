import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/common/x_video_player.dart';
import 'package:getx_pattern_starter/app/models/content_model.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';

class VideoView extends GetView<VideoEducationController> {
  const VideoView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VideoEducationController());
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
          Expanded(
            child: StreamBuilder(
              stream: controller.getVideos(),
              initialData: const [],
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Utils.loadingWidget(),
                      );
                    } else if (snapshot.hasData) {
                      return RoundedContainer(
                        height: 200,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(10.0),
                        gradient: LinearGradient(
                          colors: [
                            ThemeApp.backgroundColor,
                            ThemeApp.backgroundColor,
                            ThemeApp.primaryColor.withOpacity(0.5),
                            ThemeApp.primaryColor.withOpacity(0.5),
                            ThemeApp.backgroundColor,
                            ThemeApp.backgroundColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        hasBorder: true,
                        borderColor: ThemeApp.primaryColor,
                        child: ReusableVideoPlayer(
                          videoUrl: snapshot.data![index].url!,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class VideoEducationController extends GetxController {
  final fireStore = FirebaseFirestore.instance;

  Stream<List<ContentModel>> getVideos() {
    return fireStore.collection("videos").snapshots().map((event) {
      return event.docs.map((e) {
        return ContentModel.fromJson(e.data());
      }).toList();
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
