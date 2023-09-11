import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/buttons/x_button.dart';
import 'package:getx_pattern_starter/app/common/input/gender_picker.dart';
import 'package:getx_pattern_starter/app/common/input/x_field.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/modules/home/views/question_view.dart';
import 'package:sp_util/sp_util.dart';

class FormProfileView extends StatefulWidget {
  const FormProfileView({super.key});

  @override
  State<FormProfileView> createState() => _FormProfileViewState();
}

class _FormProfileViewState extends State<FormProfileView> {
  String age = "";
  String gender = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Image.asset('assets/images/logo.png'),
            const Text(
              "Selamat datang di aplikasi",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              "RETAKO",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Remaja Tanpa Rokok",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 50),
            XTextField(
              labelTextSuffix: "Masukan Umur",
              hintText: "Masukan Umur",
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  age = value;
                });
              },
            ),
            const SizedBox(height: 10),
            GenderPicker(
              onSelected: (val) {
                // setState(() {
                gender = val;
                // });
              },
            ),
            const SizedBox(height: 20),
            XButton(
              text: "Masuk",
              onPressed: () {
                saveForm();
              },
            )
          ],
        ),
      ),
    );
  }

  void saveForm() {
    // save to sp util
    if (gender.isEmpty || age.isEmpty) {
      // setState(() {
      // });
      Utils.snackMessage(
          title: "Perhatiam",
          messages: "Umur dan Jenis Kelamin tidak boleh kosong",
          type: "warning");
    } else {
      SpUtil.putString("age", age);
      SpUtil.putString("gender", gender);
      Get.to(() => const QuestionView());
    }
  }
}
