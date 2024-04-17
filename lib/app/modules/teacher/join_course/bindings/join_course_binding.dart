import 'package:get/get.dart';
import '../controllers/join_course_controller.dart';

class TeacherJoinCourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherJoinCourseController>(
      () => TeacherJoinCourseController(),
    );
  }
}
