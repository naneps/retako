import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/buttons/x_button.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/modules/home/views/home_view.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ResultProactiveCSC extends StatelessWidget {
  const ResultProactiveCSC({super.key});
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    final int score = args["score"];
    print(score);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset("assets/images/tema_33..png").image,
              fit: BoxFit.cover,
            ),
          ),
          width: Get.width,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedContainer(
                width: Get.width,
                // padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    RoundedContainer(
                      color: ThemeApp.accentTextColor,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      radius: 0,
                      child: Row(
                        children: [
                          const Text(
                            "Hasil",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          //
                          IconButton(
                            icon: const Icon(MdiIcons.information),
                            onPressed: () {
                              Get.defaultDialog(
                                title: "Keterangan Skor",
                                content: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          color: Colors.green,
                                        ),
                                        const SizedBox(width: 10),
                                        const Text("Skor 0 - 71 = Rendah"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          color: Colors.yellow,
                                        ),
                                        const SizedBox(width: 10),
                                        const Text("Skor 72 - 107 = Cukup"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(width: 10),
                                        const Text("Skor 108 -  144 = Tinggi"),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    RoundedContainer(
                      width: Get.width,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      color: Colors.white,
                      hasBorder: true,
                      radius: 0,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            "Terima kasih telah mengisi kuesioner ini. Berikut adalah hasilnya:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            getScoreCondition(score),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Icon(
                            getScoreIcon(score),
                            size: 100,
                            color: ThemeApp.accentTextColor,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Skor Anda adalah $score",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              RoundedContainer(
                  child: XButton(
                onPressed: () {
                  Get.offAll(() => HomeView());
                },
                text: "Kembali ke beranda",
              ))
            ],
          ),
        ),
      ),
    );
  }

  String getScoreCondition(int score) {
    if (score <= 36 && score <= 71) {
      return "Rendah";
    } else if (score >= 72 && score <= 107) {
      return "Cukup";
    } else if (score >= 108 && score <= 144) {
      return "Tinggi";
    } else {
      return "";
    }
  }

  IconData getScoreIcon(int score) {
    if (score <= 36 && score <= 71) {
      return Icons.sentiment_dissatisfied;
    } else if (score >= 72 && score <= 107) {
      return Icons.sentiment_neutral;
    } else {
      return Icons.sentiment_satisfied;
    }
  }

  String getScoreDescription(int score) {
    if (score >= 36 && score <= 71) {
      return "Skor Anda dalam kategori rendah, yang berarti Anda mungkin perlu lebih banyak dukungan dan perencanaan sebelum mencoba berhenti merokok.";
    } else if (score >= 72 && score <= 107) {
      return "Skor Anda dalam kategori sedang, yang menunjukkan bahwa Anda memiliki pemahaman tentang apa yang dibutuhkan untuk berhenti merokok, tetapi masih perlu melakukan lebih banyak usaha dalam beberapa aspek.";
    } else {
      return "Skor Anda dalam kategori tinggi, yang mengindikasikan bahwa Anda memiliki tingkat kesiapan yang tinggi untuk berhenti merokok dan mungkin sudah memiliki beberapa rencana yang baik.";
    }
  }
}
