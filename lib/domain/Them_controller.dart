import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

GetStorage box = GetStorage();

class ThemController extends GetxController {
  bool isLight = box.read("islight") ?? true;

  void changeThem() {
    isLight = !isLight;
    box.write("islight", isLight);
    update();
  }
}
