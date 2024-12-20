import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/domain/Them_controller.dart';
import 'package:todo/domain/splash_controller.dart';
import 'package:flutter/material.dart';

void main() async {
  await GetStorage.init();
  await ScreenUtil.ensureScreenSize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemController themeController = Get.put(ThemController());
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(384.0, 784.0),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetBuilder<ThemController>(
          builder: (c) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              textTheme: TextTheme(),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              textTheme: TextTheme(),
            ),
            themeMode: c.isLight ? ThemeMode.light : ThemeMode.dark,
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GetX<SplashController>(
          builder: (controller) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // First image
                AnimatedOpacity(
                  opacity: controller.isFirstImageVisible.value ? 1.0 : 0.0,
                  duration: Duration(seconds: 1),
                  child: Image.asset(
                    'assets/img1.png', // Replace with your first image path
                    // width: 200,
                    // height: 200,
                  ),
                ),
                // Second image
                AnimatedOpacity(
                  opacity: controller.isSecondImageVisible.value ? 1.0 : 0.0,
                  duration: Duration(seconds: 1),
                  child: Image.asset(
                    'assets/img2.png', // Replace with your second image path
                    // width: 200,
                    // height: 200,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
