import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
 import 'package:uuid/uuid.dart';
import '../../../../shared/utils/debug_print.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/utils/firestore_utils.dart';
import '../../../../shared/utils/show_toast.dart';
import '../../../../shared/utils/strings.dart';
 import 'dart:io';

import '../../home/controllers/home_controller.dart';

class TeacherJoinCourseController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController courseName = TextEditingController();
  var isLoading = false.obs;
  var doc1 = ''.obs;
  final String uniqueCourseId = const Uuid().v4();
  final String uniqueChatId = const Uuid().v4();

  Future<String?> uploadImage() async {
    try {
      isLoading.value = true;
      String? url = await FirestoreUtils.uploadFile('course_image',File(doc1.value));
      isLoading.value = false;
      dPrint('image upload successful:::');
      return url;
    } on FirebaseException catch (e) {
      isLoading.value = false;
      dPrint('firebase exception:::');
      showToast(message: e.code, toastType: ToastType.info, context: Get.context!);
      return null;
    } catch (e) {
      isLoading.value = false;
      dPrint('exception::: $e');
      showToast(message: AppTexts.unknownError, toastType: ToastType.error, context: Get.context!);
      return null;
    }
  }

  Future<void> uploadCourse() async {
    final teacherController = Get.put(TeacherHomeController());
    try {
      isLoading.value = true;
      await FirestoreUtils.setDoc(FirestoreUtils.coursesColl, uniqueCourseId, {
        'id': uniqueCourseId,
        'name': courseName.text.trim(),
        'imageUrl': await uploadImage(),
        'students': <Map<String,dynamic>>[],
        'teacherId': teacherController.uid.value,
        'teacherName': '${teacherController.firstName.value} ${teacherController.lastName.value}',
        'teacherImageUrl': teacherController.image.value != '' ? teacherController.image.value : null,
      }).then((value) async {
        isLoading.value = false;
        dPrint('course data upload successful:::');
        createChat();
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

  Future<void> createChat() async {
    final teacherController = Get.put(TeacherHomeController());
    try {
      isLoading.value = true;
      await FirestoreUtils.setDoc(FirestoreUtils.chatsColl, uniqueChatId, {
        'id': uniqueChatId,
        'courseID': uniqueCourseId,
        'messages': <Map<String,dynamic>>[]
      }).then((value) async {
        isLoading.value = false;
        dPrint('chat created successfully:::');
        teacherController.getYourCreatedCourses();
        Get.back();
        showToast(message: 'Your course has been created successfully.', toastType: ToastType.success, context: Get.context!);
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
