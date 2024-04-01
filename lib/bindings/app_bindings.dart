import 'package:get/get.dart';
import 'package:processed/features/dashboard/controllers/homecontroller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
