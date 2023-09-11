import 'package:flutter/material.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/modules/home/views/poster_view.dart';
import 'package:getx_pattern_starter/app/modules/home/views/video_view.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';

class EducationView extends StatefulWidget {
  const EducationView({super.key});

  @override
  State<EducationView> createState() => _EducationViewState();
}

class _EducationViewState extends State<EducationView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: RoundedContainer(
        gradient: LinearGradient(
          colors: [
            ThemeApp.primaryColor,
            ThemeApp.secondaryColor,
            ThemeApp.primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        margin: const EdgeInsets.all(10.0),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.brown,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: "Modul",
              icon: Icon(Icons.book),
            ),
            BottomNavigationBarItem(
              label: "Poster",
              icon: Icon(Icons.image),
            ),
            BottomNavigationBarItem(
              label: "Video",
              icon: Icon(Icons.video_library),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                RoundedContainer(
                  margin: const EdgeInsets.all(10.0),
                  width: 50,
                  height: 50,
                  radiusType: RadiusType.circle,
                  color: Colors.transparent,
                  hasShadow: true,
                  child: Image.asset('assets/images/logo.png'),
                ),
                const Text(
                  "RETAKO",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: currentWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget currentWidget() {
    switch (currentIndex) {
      case 0:
        return const Text("Modul");
      case 1:
        return const EducationPosterView();
      case 2:
        return const VideoView();
      default:
        return const Text("Modul");
    }
  }
}
