import 'package:get/get.dart';

class ClassController extends GetxController {

  var joinedClass = false.obs;

  bool mute = true;
  bool video = true;
  bool flipCamera = true;

  String? image = 'assets/images/teacher_call.png';
  String? name = 'Richard Bejide';
  String? type = 'Teacher';

  var students = <Map<String, dynamic>>[
    {
      'image': 'assets/images/student_call1.png',
      'name': 'Folake Adeshakin',
    },
    {
      'image': 'assets/images/student_call2.png',
      'name': 'Adewale George ',
    },
    {
      'image': 'assets/images/student_call3.png',
      'name': 'Richard Adebayo',
    },
  ].obs;


  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 4), () async {
        joinedClass.value = true;
    });
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
