import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_lecture/app/shared/utils/enums.dart';
import 'package:uni_lecture/app/shared/utils/firestore_utils.dart';
import 'package:uni_lecture/app/shared/utils/shared_pref.dart';
import 'package:uni_lecture/app/shared/utils/show_toast.dart';
import '../../../models/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/utils/debug_print.dart';
import '../../../shared/utils/strings.dart';

class RegisterController extends GetxController {
  var formKey = GlobalKey<FormState>();

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  var isLoading = false.obs;

  var obscurePassword = true.obs;
  var currentPage = 1.obs;
  var selectedAccountType = 0.obs;
  var buttonText = 'CONTINUE'.obs;

  Future<void> createAccount() async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim())
          .then((value) {
        dPrint('Sign up successful:::');
        isLoading.value = false;
        uploadUserDetails();
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

  Future<void> uploadUserDetails() async {
    try {
      isLoading.value = true;
      final user = FirebaseAuth.instance.currentUser;
      await FirestoreUtils.setDoc(FirestoreUtils.usersColl, email.text.trim().toLowerCase(), {
        'userName': username.text.trim(),
        'firstName': firstname.text.trim(),
        'lastName': lastname.text.trim(),
        'email': email.text.trim().toLowerCase(),
        'accountType': selectedAccountType.value == 1 ? 'TEACHER' : 'STUDENT',
        'uid': user?.uid,
        'courses': <Map<String,dynamic>>[],
      }).then((value) async {
        dPrint('date uploaded successful:::');
        await FirestoreUtils.getDoc(FirestoreUtils.usersColl, email.text.trim().toLowerCase()).then((value) {
          dPrint('date retrieval successful:::');
          dPrint(value.toString());
          UserModel model = UserModel.fromJson(value);
          setBool('isLoggedIn', true);
          setBool('isTeacher', selectedAccountType.value == 1);
          setString('email', email.text.trim().toLowerCase());
          setString('userData', jsonEncode(model));
        });
        isLoading.value = false;
        if (selectedAccountType.value == 1) {
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

  void studentDashboard() {
    Get.offAllNamed(Routes.STUDENT_DASHBOARD);
  }

  void teacherDashboard() {
    Get.offAllNamed(Routes.TEACHER_DASHBOARD);
  }
}
