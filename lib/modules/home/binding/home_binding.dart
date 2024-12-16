import 'package:get/get.dart';

import '../../../commonModule/commonControllers/image_picker.dart';
import '../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImagePickerController>(() => ImagePickerController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
