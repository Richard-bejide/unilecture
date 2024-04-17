import 'package:get/get.dart';
import '../controllers/course_students_controller.dart';

class TeacherCourseStudentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherCourseStudentsController>(
      () => TeacherCourseStudentsController(),
    );
  }
}
