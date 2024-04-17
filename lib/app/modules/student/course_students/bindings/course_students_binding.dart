import 'package:get/get.dart';
import '../controllers/course_students_controller.dart';

class CourseStudentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourseStudentsController>(
      () => CourseStudentsController(),
    );
  }
}
