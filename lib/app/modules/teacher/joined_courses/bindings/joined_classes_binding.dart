import 'package:get/get.dart';
import '../controllers/joined_classes_controller.dart';

class TeacherJoinedClassesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherJoinedClassesController>(
      () => TeacherJoinedClassesController(),
    );
  }
}
