import 'package:get/get.dart';
import '../service/painter_list_response.dart';
import '../service/painter_service.dart';

class PainterListController extends GetxController {

  final IPainterService _painterService;

  PainterListController(this._painterService);

  var painters  = <PainterResponse>[].obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var limit = 2.obs;
  var isLoading = false.obs;
  var search = ''.obs;

  @override
  void onInit(){
    fetchPainters();
    super.onInit();
  }

  Future<void> fetchPainters() async {
    isLoading.value = true;
    try {
      PainterListResponse response = await _painterService.getPainterList(
          search.value, limit.value, currentPage.value);

      painters.value = response.painters;
      totalPages.value = response.totalPages;
    } catch(error){
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void goToNextPage() {
    if(currentPage.value < totalPages.value){
      currentPage.value++;
      fetchPainters();
    }
  }

  void goToPreviousPage() {
    if(currentPage.value > 1){
      currentPage.value--;
      fetchPainters();
    }
  }
}
