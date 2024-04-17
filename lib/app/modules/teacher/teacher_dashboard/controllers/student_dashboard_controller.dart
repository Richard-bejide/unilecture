import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../account/bindings/account_binding.dart';
import '../../account/views/account_view.dart';
import '../../home/bindings/home_binding.dart';
import '../../home/views/home_view.dart';
import '../../joined_courses/bindings/joined_classes_binding.dart';
import '../../joined_courses/views/joined_classes_view.dart';
import '../../schedule/bindings/schedule_binding.dart';
import '../../schedule/views/schedule_view.dart';

class TeacherDashboardController extends GetxController {
  var selectedIndex = 0.obs;

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.TEACHER_HOME) {
      return GetPageRoute(
        settings: settings,
        page: () => const TeacherHomeView(),
        binding: TeacherHomeBinding(),
      );
    } else if (settings.name == Routes.TEACHER_SCHEDULE) {
      return GetPageRoute(
        settings: settings,
        page: () => const TeacherScheduleView(),
        binding: TeacherScheduleBinding(),
      );
    } else if (settings.name == Routes.TEACHER_JOINEDCLASSES) {
      return GetPageRoute(
        settings: settings,
        page: () => const TeacherJoinedClassesView(),
        binding: TeacherJoinedClassesBinding(),
      );
    }
    else if (settings.name == Routes.TEACHER_ACCOUNT) {
      return GetPageRoute(
        settings: settings,
        page: () => const TeacherAccountView(),
        binding: TeacherAccountBinding(),
      );
    }
    return null;
  }
}
