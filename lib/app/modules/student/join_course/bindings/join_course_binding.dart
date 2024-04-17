import 'package:get/get.dart';
import '../controllers/join_course_controller.dart';

class JoinCourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JoinCourseController>(
      () => JoinCourseController(),
    );
  }
}
