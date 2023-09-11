import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/buttons/x_button.dart';
import 'package:getx_pattern_starter/app/common/input/x_field.dart';
import 'package:getx_pattern_starter/app/modules/auth/controllers/auth_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Obx(() {
            return Form(
              key: controller.formKeyRegister,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // MAKE COPY WRITER FOR REGISTER
                    Container(
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    XTextField(
                      labelTextSuffix: "Name",
                      prefixIcon: MdiIcons.accountOutline,
                      keyboardType: TextInputType.emailAddress,
                      onSave: (val) {
                        controller.name.value = val!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    XTextField(
                      labelTextSuffix: "Email",
                      hintText: "example@gmail.com",
                      prefixIcon: MdiIcons.emailOutline,
                      onSave: (val) {
                        // controller.phone.value = val!;
                        controller.email.value = val!;
                      },
                      validator: (value) {
                        // make validator email must be valid
                        bool validEmail =
                            RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!);
                        if (value.isEmpty) {
                          return "Email can't be empty";
                        } else if (!validEmail) {
                          return "Email must be valid";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    XTextField(
                      labelTextSuffix: "Password",
                      prefixIcon: MdiIcons.lockOutline,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !controller.isShowPass.value,
                      suffixIcon: controller.isShowPass.value
                          ? MdiIcons.eyeOffOutline
                          : MdiIcons.eyeOutline,
                      onPressSuffix: () => controller.isShowPass.toggle(),
                      onSave: (val) {
                        controller.password.value = val!;
                      },
                      onChanged: (value) {
                        controller.password.value = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    XTextField(
                      labelTextSuffix: "Confirm Password",
                      prefixIcon: MdiIcons.lockOutline,
                      onSave: (val) {
                        controller.passwordConfirm.value = val!;
                      },
                      obscureText: !controller.isShowPassConfirm.value,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: controller.isShowPassConfirm.value
                          ? MdiIcons.eyeOffOutline
                          : MdiIcons.eyeOutline,
                      onPressSuffix: () =>
                          controller.isShowPassConfirm.toggle(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Confirm Password is required";
                        }
                        //handle minimum
                        if (value.length < 8) {
                          return "Password minimum 8 character";
                        }
                        print(value);
                        print(controller.password.value);
                        if (value != controller.password.value) {
                          return "Password not match";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Obx(() {
                      return XButton(
                        text: "Register",
                        isDisabled: controller.isLoading.value,
                        onPressed: () {
                          if (controller.formKeyRegister.currentState!
                              .validate()) {
                            controller.formKeyRegister.currentState!.save();
                            controller.registerWithEmailPassword();
                          }
                        },
                      );
                    }),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
