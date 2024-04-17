import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/utils/shared_pref.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  late bool isLoggedIn;
  late bool skipOnboarding;
  late bool isTeacher;

  void navigateToView() {
    Future.delayed(const Duration(milliseconds: 210), () async {
      if (!isLoggedIn && !skipOnboarding) {
        Future.delayed(
          const Duration(milliseconds: 210),
          () => Get.offNamed(Routes.ONBOARDING),
        ); //login view
      } else if (!isLoggedIn && skipOnboarding) {
        Future.delayed(
          const Duration(milliseconds: 210),
          () => Get.offNamed(Routes.LOGIN),
        ); //login view
      } else if (isLoggedIn && isTeacher) {
        Future.delayed(
          const Duration(milliseconds: 210),
          () => Get.offNamed(Routes.TEACHER_DASHBOARD),
        ); //login view
      } else if (isLoggedIn && !isTeacher) {
        Future.delayed(
          const Duration(milliseconds: 210),
          () => Get.offNamed(Routes.STUDENT_DASHBOARD),
        ); //login view
      } else {
        Future.delayed(
          const Duration(milliseconds: 210),
          () => Get.offNamed(Routes.ONBOARDING),
        ); // default
      }
    });
  }

  @override
  void onInit() async {
    animationInitilization();
    skipOnboarding = await getBool('skipOnboarding') ?? false;
    isLoggedIn = await getBool('isLoggedIn') ?? false;
    isTeacher = await getBool('isTeacher') ?? false;
    Future.delayed(const Duration(seconds: 2), () async {
      navigateToView();
    });
    super.onInit();
  }

  animationInitilization() {
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeOut).obs.value;
    animation.addListener(() => update());
    animationController.forward();
  }
}
