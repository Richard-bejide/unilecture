import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_lecture/app/shared/utils/colors.dart';
import 'package:uni_lecture/app/shared/utils/text_style.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/student_dashboard_controller.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class TeacherDashboardView extends GetView<TeacherDashboardController> {
  const TeacherDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: Routes.TEACHER_HOME,
        onGenerateRoute: controller.onGenerateRoute,
      ),
      bottomNavigationBar: showBottomNav(context),
    );
  }

  Widget showBottomNav(BuildContext context) {
    final dashController = Get.put(TeacherDashboardController());
    return Obx(
      () => SalomonBottomBar(
        backgroundColor: AppColors.kPrimaryColor.withOpacity(0.01),
        currentIndex: dashController.selectedIndex.value,
        onTap: (i) {
          dashController.selectedIndex.value = i;
          if (i == 0) {
            Get.toNamed(Routes.TEACHER_HOME, id: 1);
          } else if (i == 1) {
            Get.toNamed(Routes.TEACHER_SCHEDULE, id: 1);
          } else if (i == 2) {
            Get.toNamed(Routes.TEACHER_JOINEDCLASSES, id: 1);
          } else if (i == 3) {
             Get.toNamed(Routes.TEACHER_ACCOUNT, id: 1);
          }
        },
        items: [
          SalomonBottomBarItem(
              icon: const Icon(Icons.home, size: 20),
              title: Text("Home",
                  style:
                      AppText.regularText.copyWith(fontSize: 13, fontWeight: FontWeight.w400, fontFamily: 'grotesk')),
              selectedColor: AppColors.kPrimaryColor,
              unselectedColor: Colors.black54),
          SalomonBottomBarItem(
              icon: const Icon(Icons.calendar_month, size: 20),
              title: Text("Schedule",
                  style:
                      AppText.regularText.copyWith(fontSize: 13, fontWeight: FontWeight.w400, fontFamily: 'grotesk')),
              selectedColor: Colors.pink,
              unselectedColor: Colors.black54),
          SalomonBottomBarItem(
              icon: const Icon(Icons.school_outlined, size: 20),
              title: Text("Courses",
                  style:
                      AppText.regularText.copyWith(fontSize: 13, fontWeight: FontWeight.w400, fontFamily: 'grotesk')),
              selectedColor: Colors.orange,
              unselectedColor: Colors.black54),
          SalomonBottomBarItem(
              icon: const Icon(Icons.person, size: 20),
              title: Text("Profile",
                  style:
                      AppText.regularText.copyWith(fontSize: 13, fontWeight: FontWeight.w400, fontFamily: 'grotesk')),
              selectedColor: Colors.teal,
              unselectedColor: Colors.black54),
        ],
      ),
    );
  }
}
