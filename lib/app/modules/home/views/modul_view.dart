import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/modules/home/widgets/pdf_view.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/content_model.dart';

class ModuleView extends GetView<ModuleController> {
  const ModuleView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ModuleController());
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
            "Modul",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ThemeApp.lightColor,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder(
              stream: controller.getContents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No PDF links available."),
                  );
                } else {
                  // Extract the list of PDF URLs from the snapshot data
                  final pdfUrls = snapshot.data;

                  return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: pdfUrls!.length,
                    itemBuilder: (context, index) {
                      return RoundedContainer(
                        child: ListTile(
                          leading: Icon(
                            Icons.picture_as_pdf,
                            color: ThemeApp.backgroundColor,
                            size: 30,
                          ),
                          title: Text(
                            pdfUrls[index].title!,
                            style: TextStyle(
                              color: ThemeApp.darkColor,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.chevron_right_outlined,
                              color: ThemeApp.backgroundColor,
                            ),
                            onPressed: () async {
                              Get.to(
                                PDFScreen(
                                  path: pdfUrls[index].url,
                                  title: pdfUrls[index].title,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class ModuleController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  Stream<List<ContentModel>> getContents() {
    return firestore.collection('modules').snapshots().map((event) =>
        event.docs.map((e) => ContentModel.fromJson(e.data())).toList());
  }

  Future<File> createFileOfPdfUrl(String url) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      url = url;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
