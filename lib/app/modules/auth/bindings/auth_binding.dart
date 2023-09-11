import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/providers/auth_controller.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.lazyPut<AuthProvider>(() => AuthProvider());
  }
}
