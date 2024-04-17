import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../routes/app_pages.dart';
import '../../../../shared/utils/colors.dart';
import '../../../../shared/utils/debug_print.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/utils/firestore_utils.dart';
import '../../../../shared/utils/shared_pref.dart';
import '../../../../shared/utils/show_toast.dart';
import '../../../../shared/utils/strings.dart';
import '../../home/controllers/home_controller.dart';

class AccountController extends GetxController {
  var enableCaptions = false.obs;
  var enableReadability = false.obs;
  var selectedLanguage = 'ENGLISH'.obs;

  var languages = <String>[
    'ENGLISH',
    'YORUBA',
    'IGBO',
    'HAUSA',
    'FRENCH',
    'SPANISH',
  ].obs;

  var loadingImage = false.obs;

  FirebaseAuth firebase = FirebaseAuth.instance;
  void logout(){
    removeData('userData');
    removeData('isTeacher');
    removeData('isLoggedIn');
    removeData('email');
    firebase.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }


  Future<void> selectImage() async{
    try{
      await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 20)
          .then((value) async {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: value!.path,
          aspectRatioPresets: [CropAspectRatioPreset.square],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Edit image',
                toolbarColor: AppColors.kPrimaryColor,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Edit image',
            ),
            WebUiSettings(
              context: Get.context!,
            ),
          ],
        );

        if (croppedFile != null){
          uploadImage(File(croppedFile.path));
        }
      });
    }
    catch (e){
      dPrint(e.toString());
    }
  }

  Future<void> uploadImage(File image) async{
    try {
      loadingImage.value = true;
      String? url = await FirestoreUtils.uploadFile('profile_image',image);
      loadingImage.value = false;
      dPrint('image upload successful:::');
      if(url != null) {
        updateProfile(url);
      }else{
        showToast(message: 'Couldn\'t upload your image, try again later', toastType: ToastType.error, context: Get.context!);
      }
    } on FirebaseException catch (e) {
      loadingImage.value = false;
      dPrint('firebase exception:::');
      showToast(message: e.code, toastType: ToastType.info, context: Get.context!);
    } catch (e) {
      loadingImage.value = false;
      dPrint('exception::: $e');
      showToast(message: AppTexts.unknownError, toastType: ToastType.error, context: Get.context!);
    }
  }


  Future<void> updateProfile(String url) async {
    final homeController = Get.put(HomeController());
    try {
      loadingImage.value = true;
      await FirestoreUtils.updateDoc(FirestoreUtils.usersColl, homeController.email.value, {
        'image': url,
      }).then((value) async {
        dPrint('user update successful:::');
        await homeController.getUserDetails();
        showToast(message: 'Your photo has been uploaded successfully.', toastType: ToastType.success, context: Get.context!);
        loadingImage.value = false;
      });
    } on FirebaseException catch (e) {
      loadingImage.value = false;
      dPrint('firebase exception:::');
      showToast(message: e.code, toastType: ToastType.info, context: Get.context!);
    } catch (e) {
      loadingImage.value = false;
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
