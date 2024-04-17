import 'package:get/get.dart';
import '../controllers/chat_controller.dart';

class TeacherChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherChatController>(
      () => TeacherChatController(),
    );
  }
}
