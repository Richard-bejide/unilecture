import 'package:get/get.dart';
import '../controllers/schedule_controller.dart';

class TeacherScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherScheduleController>(
      () => TeacherScheduleController(),
    );
  }
}
