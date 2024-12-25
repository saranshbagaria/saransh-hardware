import 'package:flutter_testing/modules/painter/controller/painter_list_controller.dart';
import 'package:flutter_testing/modules/painter/service/painter_service.dart';
import 'package:get/get.dart';

class PainterListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IPainterService>(() => PainterService());
    Get.lazyPut<PainterListController>(() => PainterListController(Get.find<IPainterService>()));
  }
}

