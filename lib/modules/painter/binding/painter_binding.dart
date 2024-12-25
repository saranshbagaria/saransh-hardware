import 'package:flutter_testing/modules/painter/service/painter_service.dart';
import 'package:get/get.dart';

import '../controller/painter_controller.dart';

class PainterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PainterService>(() => PainterService());
    Get.lazyPut<PainterController>(() => PainterController(Get.find<IPainterService>()));
  }
}
