import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/buttons/x_button.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/modules/home/views/home_view.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';

class ResultEfficiencyView extends StatelessWidget {
  const ResultEfficiencyView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    final int score = args["selfEfficacyScore"];
    final String level = args["selfEfficacyAnalysis"];
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
                      hasBorder: true,
                      radius: 0,
                      child: const Center(
                        child: Text(
                          "Hasil",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                            "Terima kasih telah mengisi kuesioner Self-Efficacy kami. Berdasarkan jawaban Anda, tingkat Self-Efficacy Anda adalah",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            level,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
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
}