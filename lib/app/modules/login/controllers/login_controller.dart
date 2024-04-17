import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uni_lecture/app/models/user_model.dart';
import 'package:uni_lecture/app/shared/utils/shared_pref.dart';
import 'package:flutter/material.dart';
 import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart';
import '../../../api/api_endpoints.dart';
import '../../../api/api_requests.dart';
import '../../../models/api_response.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/utils/debug_print.dart';
import '../../../shared/utils/enums.dart';
import '../../../shared/utils/firestore_utils.dart';
import '../../../shared/utils/show_toast.dart';
import '../../../shared/utils/strings.dart';

class LoginController extends GetxController {

  var formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  var isLoading = false.obs;

  var obscurePassword = true.obs;

  Future<void> login() async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim())
          .then((value) {
        dPrint('Sign in successful:::');
        isLoading.value = false;
        if(value.user?.emailVerified ?? false) {
          getUserDetails();
        }else{
          dPrint('Email not verified:::');
          value.user?.sendEmailVerification();
          showToast(message: 'Verify your email to continue. \nVerification link has been sent to your mail', toastType: ToastType.info, context: Get.context!);
        }
      });
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      dPrint('firebase exception:::');
      showToast(message: e.code, toastType: ToastType.info, context: Get.context!);
    } catch (e) {
      isLoading.value = false;
      dPrint('exception::: $e');
      showToast(message: AppTexts.unknownError, toastType: ToastType.error, context: Get.context!);
    }
  }

  Future<void> getUserDetails() async {
    try {
      isLoading.value = true;

      await FirestoreUtils.getDoc(FirestoreUtils.usersColl, email.text.trim().toLowerCase()).then((value) async {
        dPrint('date retrieval successful:::');
        dPrint(value.toString());
        UserModel model = UserModel.fromJson(value);
        setString('userData', jsonEncode(model));
        setBool('isTeacher', model.accountType == 'TEACHER');
        setBool('isLoggedIn', true);
        setString('email', email.text.trim().toLowerCase());
        isLoading.value = false;
        if (model.accountType == 'TEACHER') {
          teacherDashboard();
        } else {
          studentDashboard();
        }
      });
      isLoading.value = false;
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

  void forgotPassword() {
    Get.toNamed(Routes.FORGOTPASSWORD);
  }

  void studentDashboard() {
    Get.offAllNamed(Routes.STUDENT_DASHBOARD);
  }

  void teacherDashboard() {
    Get.offAllNamed(Routes.TEACHER_DASHBOARD);
  }
}
