import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_lecture/app/modules/student/account/bindings/account_binding.dart';
import 'package:uni_lecture/app/modules/student/account/views/account_view.dart';
import 'package:uni_lecture/app/modules/student/home/bindings/home_binding.dart';
import 'package:uni_lecture/app/modules/student/home/views/home_view.dart';
import 'package:uni_lecture/app/modules/student/joined_courses/bindings/joined_classes_binding.dart';
import 'package:uni_lecture/app/modules/student/joined_courses/views/joined_classes_view.dart';
import 'package:uni_lecture/app/modules/student/schedule/bindings/schedule_binding.dart';
import 'package:uni_lecture/app/modules/student/schedule/views/schedule_view.dart';
import '../../../../routes/app_pages.dart';

class StudentDashboardController extends GetxController {
  var selectedIndex = 0.obs;

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.HOME) {
      return GetPageRoute(
        settings: settings,
        page: () => const HomeView(),
        binding: HomeBinding(),
      );
    } else if (settings.name == Routes.SCHEDULE) {
      return GetPageRoute(
        settings: settings,
        page: () => const ScheduleView(),
        binding: ScheduleBinding(),
      );
    } else if (settings.name == Routes.JOINEDCLASSES) {
      return GetPageRoute(
        settings: settings,
        page: () => const JoinedClassesView(),
        binding: JoinedClassesBinding(),
      );
    }
    else if (settings.name == Routes.ACCOUNT) {
      return GetPageRoute(
        settings: settings,
        page: () => const AccountView(),
        binding: AccountBinding(),
      );
    }
    return null;
  }
}
