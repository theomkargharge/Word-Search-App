import 'package:get/get.dart';
import 'package:search_app/splash_screen/splash_screen/controller/splash_screen_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
  }
}
