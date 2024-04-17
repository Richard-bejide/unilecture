import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../models/user_model.dart';
import '../../../../shared/utils/debug_print.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/utils/firestore_utils.dart';
import '../../../../shared/utils/show_toast.dart';
import '../../../../shared/utils/strings.dart';
import '../../home/controllers/home_controller.dart';

class CourseStudentsController extends GetxController {
  CourseModel? courseDetails;
  var isLoading = false.obs;
  var isLoadingCourseMaterials = false.obs;
  var allStudents = <dynamic>[].obs;
  var allCourseMaterials = <CourseModel?>[].obs;

  var currentView = 1.obs;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  Future<void> refreshData() async{
    await getAllStudents();
    refreshController.refreshCompleted();
  }

  void updateCourseDetails(CourseModel? data) {
    courseDetails = data;
  }

  Future<void> getAllStudents() async {
    try {
      isLoading.value = true;
      await FirestoreUtils.getDoc(FirestoreUtils.coursesColl, courseDetails?.id ?? "").then((value) async {
        dPrint('courses students retrieved successful:::');
        dPrint(value.toString());
        dPrint(value?['students'] ?? '');
        if(value != null) {
          allStudents.clear();
          allStudents.value = value['students'] ?? [];
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
  void onInit() {
    Future.delayed(const Duration(milliseconds: 210), () async {
    getAllStudents();
    });
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
