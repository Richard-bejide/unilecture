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

class JoinedClassesController extends GetxController {

  var isLoading = false.obs;
  var allClasses = <CourseModel?>[].obs;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  Future<void> refreshData() async{
    await getUserDetails();
    refreshController.refreshCompleted();
  }


  Future<void> getUserDetails() async {
    try {
      isLoading.value = true;
      final homeController = Get.put(HomeController());

      await FirestoreUtils.getDoc(FirestoreUtils.usersColl, homeController.email.value).then((value) async {
        dPrint('courses retrieved successful:::');
        dPrint(value.toString());
        UserModel model = UserModel.fromJson(value);
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
  void onInit() {
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
