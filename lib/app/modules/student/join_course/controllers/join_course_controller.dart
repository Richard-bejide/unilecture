import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../shared/utils/debug_print.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/utils/firestore_utils.dart';
import '../../../../shared/utils/show_toast.dart';
import '../../../../shared/utils/strings.dart';
import '../../home/controllers/home_controller.dart';

class JoinCourseController extends GetxController {
  var isLoading = false.obs;
  var isUploading = false.obs;

  var courseDetails = <String,dynamic>{}.obs;

  TextEditingController course = TextEditingController();

  Future<void> getCourseDetails() async {
    try {
      isLoading.value = true;
      courseDetails.value = <String,dynamic>{};
      await FirestoreUtils.getSnapshotWithKey(FirestoreUtils.coursesColl, 'id', course.text.trim()).then((value) async {
          courseDetails.value = value!.isNotEmpty ? value[0] : <String,dynamic>{};
          isLoading.value = false;
          if(courseDetails.isEmpty) showToast(message: 'Course not found, Check the code and try again.', toastType: ToastType.info, context: Get.context!);
          dPrint('course details fetched successfully:::');
        });
    } on FirebaseException catch (e) {
      isLoading.value = false;
      dPrint('firebase exception:::');
      showToast(message: e.code, toastType: ToastType.info, context: Get.context!);
    } catch (e) {
      isLoading.value = false;
      dPrint('exception::: $e');
      showToast(message: AppTexts.unknownError, toastType: ToastType.error, context: Get.context!);
    }
  }

  Future<void> joinCourse() async {
    final homeController = Get.put(HomeController());
    try {
      isUploading.value = true;
      await FirestoreUtils.updateSnapshotListWithKey(FirestoreUtils.coursesColl, 'id', course.text.trim().toLowerCase(), 'students', {
        'id': homeController.uid.value,
        'email': homeController.email.value,
        'name': '${homeController.firstName.value} ${homeController.lastName.value}',
        'imageUrl': homeController.image.value != '' ? homeController.image.value : null,
      }).then((value) async {
        dPrint('student data uploaded to course successfully:::');
        await FirestoreUtils.updateSnapshotListWithKey(FirestoreUtils.usersColl, 'uid', homeController.uid.value, 'courses', {
          'id': courseDetails['id'],
          'teacherName': courseDetails['teacherName'],
          'name': courseDetails['name'],
          'imageUrl': courseDetails['imageUrl'],
        }).then((value) async {
          isUploading.value = false;
          dPrint('student data upload successful:::');
          homeController.getUserDetails();
          Get.back();
          showToast(message: 'You have joined course successfully.', toastType: ToastType.success, context: Get.context!);
        });
      });
    } on FirebaseException catch (e) {
      isUploading.value = false;
      dPrint('firebase exception:::');
      showToast(message: e.code, toastType: ToastType.info, context: Get.context!);
    } catch (e) {
      isUploading.value = false;
      dPrint('exception::: $e');
      showToast(message: AppTexts.unknownError, toastType: ToastType.error, context: Get.context!);
    }
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
