import 'package:get/get.dart';

class TeacherScheduleController extends GetxController {
  var allClasses = <Map<String, dynamic>>[
    {
      'title': 'Foundations of Computer science',
      'teacher_image': 'assets/images/teacher1.png',
      'teacher_name': 'Ademola Aderonke',
      'start_time': '9:00am',
      'end_time': '11:00am',
      'isLive': true,
    },
    {
      'title': 'Human Computer Interaction',
      'teacher_image': 'assets/images/teacher1.png',
      'teacher_name': 'Ademola Aderonke',
      'start_time': '11:00am',
      'end_time': '1:00pm',
      'isLive': false,
    },
    {
      'title': 'Introduction to Artificial Intelligence',
      'teacher_image': 'assets/images/teacher1.png',
      'teacher_name': 'Ademola Aderonke',
      'start_time': '1:00pm',
      'end_time': '3:00pm',
      'isLive': false,
    },
    {
      'title': 'Database Design',
      'teacher_image': 'assets/images/teacher1.png',
      'teacher_name': 'Ademola Aderonke',
      'start_time': '3:00pm',
      'end_time': '5:00pm',
      'isLive': false,
    },
  ].obs;

  @override
  void onInit() async {
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
