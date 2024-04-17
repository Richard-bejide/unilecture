import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:developer' as dev;
import '../../../../models/courses_model.dart';
import '../../../../models/user_model.dart';
import '../../../../shared/utils/debug_print.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/utils/firestore_utils.dart';
import '../../../../shared/utils/shared_pref.dart';
import '../../../../shared/utils/show_toast.dart';
import '../../../../shared/utils/strings.dart';

class HomeController extends GetxController {

  var isLoading = false.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var userName = ''.obs;
  var image = ''.obs;
  var accountType = ''.obs;
  var uid = ''.obs;


  var selectedClassesFilter = 1.obs;

  var todayClasses = <Map<String, dynamic>>[
    {
      'title': 'Principles of Algorithms Design',
      'banner': 'assets/images/banner2.png',
      'duration': '1 hour',
      'start': '10:00am',
      'isLive': true,
    },
    {
      'title': 'Introduction to Artificial Intelligence',
      'banner': 'assets/images/banner1.png',
      'duration': '2 hours',
      'start': '11:00am',
      'isLive': false,
    },
    {
      'title': 'Human Computer Interaction',
      'banner': 'assets/images/banner3.png',
      'duration': '2 hours',
      'start': '1:00pm',
      'isLive': false,
    },
  ].obs;

  var tomorrowClasses = <Map<String, dynamic>>[
    {
      'title': 'Foundations of Computer science',
      'banner': 'assets/images/banner3.png',
      'duration': '2 hour',
      'start': '10:00am',
      'isLive': false,
    },
    {
      'title': 'Human Computer Interaction',
      'banner': 'assets/images/banner1.png',
      'duration': '2 hours',
      'start': '12:00am',
      'isLive': false,
    },
    {
      'title': 'Introduction to Artificial Intelligence',
      'banner': 'assets/images/banner2.png',
      'duration': '2 hours',
      'start': '2:00pm',
      'isLive': false,
    },
  ].obs;

  var allClasses = <CourseModel?>[].obs;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  Future<void> refreshData() async{
    await getUserDetails();
    refreshController.refreshCompleted();
  }

  Future<void> getUserData() async{
    String? userStr = await getString('userData');
    if(userStr != null) {
      UserModel? user  = UserModel.fromJson(jsonDecode(userStr) as Map<String,dynamic>);
      firstName.value = user.firstName ?? '';
      lastName.value = user.lastName ?? '';
      email.value = user.email ?? '';
      userName.value = user.userName ?? '';
      image.value = user.image ?? '';
      accountType.value = user.accountType ?? '';
      uid.value = user.uid ?? '';
      allClasses.value = user.courses ?? [];
    }
  }

  Future<void> getUserDetails() async {
    try {
      isLoading.value = true;
      await FirestoreUtils.getDoc(FirestoreUtils.usersColl, email.value).then((value) async {
        dPrint('user data retrieval successful:::');
        dPrint(value.toString());
        UserModel model = UserModel.fromJson(value);
        setString('userData', jsonEncode(model));
        setString('email', email.value);
        firstName.value = model.firstName ?? '';
        lastName.value = model.lastName ?? '';
        email.value = model.email ?? '';
        userName.value = model.userName ?? '';
        image.value = model.image ?? '';
        accountType.value = model.accountType ?? '';
        uid.value = model.uid ?? '';
        allClasses.value = model.courses ?? [];
        isLoading.value = false;
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
  void onInit() async {
    await getUserData();
    getUserDetails();
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
