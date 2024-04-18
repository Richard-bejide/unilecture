import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ScheduleClassController extends GetxController {
  var isLoading = false.obs;
  var startTime = 'Select'.obs;
  var endTime = 'Select'.obs;
  var date = 'Select'.obs;

  var time = <String>[
    'Select',
    '6:00am',
    '7:00am',
    '8:00am',
    '9:00am',
    '10:00am',
    '11:00am',
    '12:00pm',
    '1:00pm',
    '2:00pm',
    '3:00pm',
    '4:00pm',
    '5:00pm',
    '6:00pm',
    '7:00pm',
    '8:00pm',
    '9:00pm',
    '10:00pm',
  ].obs;


  Future<void> scheduleClass() async {
    Get.back();
  }


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
