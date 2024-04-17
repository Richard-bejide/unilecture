import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../models/courses_model.dart';
import '../../../../shared/utils/debug_print.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/utils/firestore_utils.dart';
import '../../../../shared/utils/show_toast.dart';
import '../../../../shared/utils/strings.dart';
import '../../home/controllers/home_controller.dart';

class TeacherJoinedClassesController extends GetxController {

  var isLoading = false.obs;

  var allClasses = <CoursesModel>[].obs;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  Future<void> refreshData() async{
    await getYourCreatedCourses(isRefresh: true);
    refreshController.refreshCompleted();
  }

  Future<void> getYourCreatedCourses({bool isRefresh = false}) async {
    try {
      final teacherHomeController = Get.put(TeacherHomeController());

      if(!isRefresh)isLoading.value = true;
      await FirestoreUtils.getSnapshotWithKey(FirestoreUtils.coursesColl, 'teacherId',teacherHomeController.uid.value).then((value) async {
        dPrint('courses data retrieval successful:::');
        dPrint(value.toString());
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
  void onInit() {
    getYourCreatedCourses();
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
