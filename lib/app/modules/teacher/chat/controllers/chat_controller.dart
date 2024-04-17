import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uni_lecture/app/models/courses_model.dart';
import 'package:uni_lecture/app/modules/teacher/home/controllers/home_controller.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import '../../../../shared/utils/debug_print.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/utils/firestore_utils.dart';
import '../../../../shared/utils/show_toast.dart';
import '../../../../shared/utils/strings.dart';

class TeacherChatController extends GetxController {
  CoursesModel? courseDetails;
  var enteredText = ''.obs;
  var isLoading = false.obs;
  var sendingMessage = false.obs;
  var showEmojiPicker = false.obs;
  var chatBoxHeight = 0.0.obs;
  var messageHintText = 'Send a message...'.obs;

  late StreamSubscription<QuerySnapshot> subscription;
  var messages = <dynamic>[].obs;

  TextEditingController text = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void updateCourseDetails(CoursesModel? data) {
    courseDetails = data;
  }


  Future<void> subscribeToMessages() async {
    try {
      Future.delayed(const Duration(milliseconds: 500), () async {
        isLoading.value = true;
        subscription = FirebaseFirestore.instance
            .collection(FirestoreUtils.chatsColl)
            .where('courseID', isEqualTo: courseDetails?.id)
            .snapshots()
            .listen((QuerySnapshot snapshot) {
          dPrint('messages retrieval successful:::');
          messages.clear();
          for (var doc in snapshot.docs) {
            dynamic data = doc.data();
            List<dynamic> newMessages = data['messages'];
            messages.value = newMessages.reversed.toList();
          }
          isLoading.value = false;
        });
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

  Future<void> sendMessage(Map<String, dynamic> message) async {
    try {
      sendingMessage.value = true;
      await FirestoreUtils.updateSnapshotListWithKey(
              FirestoreUtils.chatsColl, 'courseID', courseDetails!.id!, 'messages', message)
          .then((value) async {
        dPrint('message sent successfully:::');
        sendingMessage.value = false;
      });
    } on FirebaseException catch (e) {
      sendingMessage.value = false;
      dPrint('firebase exception:::');
      showToast(message: e.code, toastType: ToastType.info, context: Get.context!);
    } catch (e) {
      sendingMessage.value = false;
      dPrint('exception::: $e');
      showToast(message: AppTexts.unknownError, toastType: ToastType.error, context: Get.context!);
    }
  }

  Future<String?> uploadImage(String path) async {
    try {
      sendingMessage.value = true;
      String? url = await FirestoreUtils.uploadFile('chat_images',File(path));
      sendingMessage.value = false;
      dPrint('image upload successful:::');
      return url;
    } on FirebaseException catch (e) {
      sendingMessage.value = false;
      dPrint('firebase exception:::');
      showToast(message: e.code, toastType: ToastType.info, context: Get.context!);
      return null;
    } catch (e) {
      sendingMessage.value = false;
      dPrint('exception::: $e');
      showToast(message: AppTexts.unknownError, toastType: ToastType.error, context: Get.context!);
      return null;
    }
  }

  void unsubscribeFromMessages() {
    subscription.cancel();
  }

  Map<String, dynamic> messageData({required String type, required String message}) {
    final homeController = Get.put(TeacherHomeController());
    return {
      'id': const Uuid().v4(),
      'type': type,
      'message': message,
      'senderName': '${homeController.firstName.value} ${homeController.lastName.value}',
      'senderImageUrl': homeController.image.value,
      'senderID': homeController.uid.value,
      'senderType': homeController.accountType.value,
      'time': DateTime.now().toString(),
    };
  }

  @override
  void onInit() {
    subscribeToMessages();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    unsubscribeFromMessages();
    messages.clear();
    courseDetails = null;
    super.onClose();
  }
}
