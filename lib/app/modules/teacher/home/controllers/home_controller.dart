import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uni_lecture/app/models/courses_model.dart';
import '../../../../models/user_model.dart';
import '../../../../shared/utils/debug_print.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/utils/firestore_utils.dart';
import '../../../../shared/utils/shared_pref.dart';
import '../../../../shared/utils/show_toast.dart';
import '../../../../shared/utils/strings.dart';
import 'dart:developer' as dev;

class TeacherHomeController extends GetxController {

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

  var allClasses = <CoursesModel>[].obs;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  Future<void> refreshData() async{
    await getUserDetails();
    await getYourCreatedCourses(isRefresh: true);
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
    }
  }

  Future<void> getUserDetails() async {
    try {
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
      });
    } on FirebaseException catch (e) {
      dPrint('firebase exception:::');
      showToast(message: e.code, toastType: ToastType.info, context: Get.context!);
    } catch (e) {
      dPrint('exception::: $e');
      showToast(message: AppTexts.unknownError, toastType: ToastType.error, context: Get.context!);
    }
  }

  Future<void> getYourCreatedCourses({bool isRefresh = false}) async {
    try {
      if(!isRefresh)isLoading.value = true;
      await FirestoreUtils.getSnapshotWithKey(FirestoreUtils.coursesColl, 'teacherId',uid.value).then((value) async {
        dPrint('courses data retrieval successful:::');
        dev.log(value.toString());
        if(value != null) {
          allClasses.clear();
          for (var course in value) {
            allClasses.add(CoursesModel(
              teacherName: course['teacherName'],
              teacherId: course['teacherId'],
              teacherImageUrl: course['teacherImageUrl'],
              name: course['name'],
              id: course['id'],
              imageUrl: course['imageUrl'],
            ));
          }
        }
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
    getYourCreatedCourses();
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
