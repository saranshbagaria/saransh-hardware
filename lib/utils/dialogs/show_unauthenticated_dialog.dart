import 'package:http/http.dart' as http;

void showUnauthenticatedDialog(http.Response response) {
  // var responseJson = json
  //     .decode(const Utf8Decoder().convert(response.body.toString().codeUnits));
  // String message = responseJson["message"] == "Unauthenticated."
  //     ? "Unauthenticated or Session Expired, Please Login"
  //     : responseJson["message"];
  // showCustomDialog(
  //   dialogContent: AlertDialog(
  //     title: const Text("Alert"),
  //     content: Text(message),
  //     actions: <Widget>[
  //       TextButton(
  //         child: const Text("Ok"),
  //         onPressed: () {},
  //       ),
  //     ],
  //   ),
  //   barrierDismissible: false,
  // );
}
