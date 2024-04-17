import 'package:get/get.dart';

class TeacherClassController extends GetxController {

  bool mute = true;
  bool video = true;
  bool flipCamera = true;

  String? image = 'assets/images/teacher_call.png';
  String? name = 'Tofunmi Akinteye';
  String? type = 'Teacher';

  var students = <Map<String, dynamic>>[
    {
      'image': 'assets/images/teacher1.png',
      'name': 'Folake Adeshakin',
    },
    {
      'image': 'assets/images/teacher2.png',
      'name': 'Adewale George ',
    },
    {
      'image': 'assets/images/teacher3.png',
      'name': 'Richard Adebayo',
    },
    {
      'image': 'assets/images/teacher4.png',
      'name': 'Emeka Godwin',
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
