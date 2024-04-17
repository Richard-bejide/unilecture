import 'package:get/get.dart';
import '../controllers/student_dashboard_controller.dart';

class TeacherDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherDashboardController>(
      () => TeacherDashboardController(),
    );
  }
}
