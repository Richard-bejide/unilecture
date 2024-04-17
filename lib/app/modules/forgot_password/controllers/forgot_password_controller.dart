import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../../shared/utils/debug_print.dart';
import '../../../shared/utils/enums.dart';
import '../../../shared/utils/show_toast.dart';
import '../../../shared/utils/strings.dart';

class ForgotPasswordController extends GetxController {
  var currentPage = 1.obs;

  var formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  TextEditingController otp = TextEditingController();

  TextEditingController newPassword = TextEditingController();

  TextEditingController newPasswordConfirmation = TextEditingController();

  var isLoading = false.obs;

  var isResendingCode = false.obs;

  var obscureNewPassword = true.obs;

  var obscureNewPasswordConfirmation = true.obs;

  var isResendCodeEnable = false.obs;

  late CountdownController countdownController;

  void enableResendCode(bool value) {
    isResendCodeEnable.value = value;
  }

  Future<void> sendCode() async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text.trim().toLowerCase()).then((value) {
        dPrint('Code send successful:::');
        isLoading.value = false;
        //countdownController = CountdownController(autoStart: true);
        //currentPage.value = 2;
        showToast(message: 'Password reset link has been sent to your mail', toastType: ToastType.success, context: Get.context!);
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

  Future<void> resendCode() async {
    if (!isResendCodeEnable.value) {
      Fluttertoast.showToast(msg: "Please retry when the countdown is done", backgroundColor: Colors.red);
    } else {
      try {
        isResendingCode.value = true;
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text.trim().toLowerCase()).then((value) {
          dPrint('Code send successful:::');
          countdownController.restart();
          otp.clear();
          FocusScope.of(Get.context!).unfocus();
          enableResendCode(false);
          showToast(message: 'Verification code has been re-sent', toastType: ToastType.info, context: Get.context!);
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
  }

  Future<void> verifyCode() async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance.verifyPasswordResetCode(otp.text).then((value) {
        dPrint('Code has been verified successfully:::');
        isLoading.value = false;
        currentPage.value = 3;
      });
    } on FirebaseException catch (e) {
      otp.clear();
      isLoading.value = false;
      dPrint('firebase exception:::');
      showToast(message: e.code, toastType: ToastType.info, context: Get.context!);
    } catch (e) {
      otp.clear();
      isLoading.value = false;
      dPrint('exception::: $e');
      showToast(message: AppTexts.unknownError, toastType: ToastType.error, context: Get.context!);
    }
  }

  Future<void> createNewPassword() async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance
          .confirmPasswordReset(code: otp.text, newPassword: newPasswordConfirmation.text.trim())
          .then((value) {
        dPrint('Code has been verified successfully:::');
        isLoading.value = false;
        currentPage.value = 4;
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

  void goToLogin() {
    Get.back();
  }
}
