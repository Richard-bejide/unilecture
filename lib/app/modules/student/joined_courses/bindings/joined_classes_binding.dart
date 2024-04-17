import 'package:get/get.dart';
import '../controllers/joined_classes_controller.dart';

class JoinedClassesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JoinedClassesController>(
      () => JoinedClassesController(),
    );
  }
}
