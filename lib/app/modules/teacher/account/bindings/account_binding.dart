import 'package:get/get.dart';
import '../controllers/account_controller.dart';

class TeacherAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherAccountController>(
      () => TeacherAccountController(),
    );
  }
}
