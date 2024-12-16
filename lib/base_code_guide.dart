// Base Code Structure to follow :-

// class SignupBinding implements Bindings {
//   @override
//   void dependencies() {
//     // Register SignupService
//     Get.lazyPut<ISignupService>(
//       () => SignupService(),
//     );

//     // Register SignupController
//     Get.lazyPut<SignupController>(
//       () => SignupController(Get.find<ISignupService>()),
//     );
//   }
// }

// class SignupPage extends GetView<SignupController> {
//   const SignupPage({super.key});

//   static const String routeName = "/SignupPage";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.transparent,
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 32),
//           width: double.infinity,
//         ),
//       ),
//     );
//   }
// }

// class SignupController extends GetxController {
//   final ISignupService _signupService;

//   SignupController(this._signupService);
// }

// abstract class ISignupService {}

// class SignupService implements ISignupService {}
