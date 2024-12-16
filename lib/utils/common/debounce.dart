import 'dart:async';

class Debounce {
  final int milliseconds;
  Timer? _timer;
  Debounce({required this.milliseconds});
  void run(void Function() action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

/*To run it-
   final Debounce _debounce = Debounce(milliseconds: 500);
    _debounce.run(() {
      addRemoveFavourite(
        context: Get.context!,
        restId: (resDetailModel.value.data?.id ?? -1).toString(),
        pastValue: pastValue,
      );
    });
  */
