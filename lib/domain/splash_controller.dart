// splash_controller.dart
import 'package:get/get.dart';
import 'dart:async';

import 'package:todo/ui/layout/home_page.dart';

class SplashController extends GetxController {
  RxBool isFirstImageVisible = false.obs;
  RxBool isSecondImageVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    _startSplashAnimation();
  }

  void _startSplashAnimation() {
    // First image fades in
    isFirstImageVisible.value = true;

    // After 2 seconds, hide first image and show second image
    Future.delayed(Duration(seconds: 1), () {
      // isFirstImageVisible.value = false;
      isSecondImageVisible.value = true;

      // After 2 more seconds, navigate to HomePage
      Future.delayed(Duration(seconds: 1), () {
        _navigateToHome();
      });
    });
  }

  void _navigateToHome() {
    Get.off(() => HomePage(),
        transition: Transition.rightToLeftWithFade,
        duration: Duration(milliseconds: 1000));
  }
}
