import 'package:get/get.dart';
import '../controllers/schedule_class_controller.dart';

class ScheduleClassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleClassController>(
      () => ScheduleClassController(),
    );
  }
}
