import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/models/content_model.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';
import 'package:photo_view/photo_view.dart';

class EducationPosterView extends GetView<EducationPosterController> {
  const EducationPosterView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EducationPosterController());

    return RoundedContainer(
      padding: const EdgeInsets.all(10.0),
      width: Get.width,
      color: Colors.transparent,
      hasBorder: true,
      borderColor: ThemeApp.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Poster",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ThemeApp.lightColor,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder(
              initialData: const [],
              stream: controller.getPoster(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Utils.loadingWidget(),
                      );
                    } else if (snapshot.hasData) {
                      return InkWell(
                        onLongPress: () {
                          Get.dialog(PhotoView(
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            imageProvider:
                                NetworkImage(snapshot.data![index].url!),
                            wantKeepAlive: true,
                            enablePanAlways: true,
                          ));
                        },
                        child: RoundedContainer(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.all(10.0),
                          width: Get.width,
                          height: Get.height * 0.5,
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
                          child: PhotoView(
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            imageProvider:
                                NetworkImage(snapshot.data![index].url!),
                            wantKeepAlive: true,
                            enablePanAlways: true,
                          ),
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

class EducationPosterController extends GetxController {
  final fireStore = FirebaseFirestore.instance;
  Stream<List<ContentModel>> getPoster() {
    return fireStore.collection("posters").snapshots().map((event) {
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
}
