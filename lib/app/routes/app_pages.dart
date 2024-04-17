import 'package:uni_lecture/app/modules/onboarding/bindings/onboarding_binding.dart';
import 'package:uni_lecture/app/modules/onboarding/views/onboarding_view.dart';
import 'package:uni_lecture/app/modules/register/bindings/register_binding.dart';
import 'package:uni_lecture/app/modules/register/views/register_view.dart';
import 'package:uni_lecture/app/modules/student/account/bindings/account_binding.dart';
import 'package:uni_lecture/app/modules/student/account/views/account_view.dart';
import 'package:uni_lecture/app/modules/student/chat/views/chat_view.dart';
import 'package:uni_lecture/app/modules/student/class_screen/bindings/class_binding.dart';
import 'package:uni_lecture/app/modules/student/class_screen/views/class_view.dart';
import 'package:uni_lecture/app/modules/student/course_students/bindings/course_students_binding.dart';
import 'package:uni_lecture/app/modules/student/course_students/views/course_students_view.dart';
import 'package:uni_lecture/app/modules/student/join_course/bindings/join_course_binding.dart';
import 'package:uni_lecture/app/modules/student/join_course/views/join_course_view.dart';
import 'package:uni_lecture/app/modules/student/joined_courses/bindings/joined_classes_binding.dart';
import 'package:uni_lecture/app/modules/student/joined_courses/views/joined_classes_view.dart';
import 'package:uni_lecture/app/modules/splash/bindings/splash_binding.dart';
import 'package:get/get.dart';
import 'package:uni_lecture/app/modules/student/schedule/bindings/schedule_binding.dart';
import 'package:uni_lecture/app/modules/student/schedule/views/schedule_view.dart';
import 'package:uni_lecture/app/modules/student/student_dashboard/bindings/student_dashboard_binding.dart';
import 'package:uni_lecture/app/modules/student/student_dashboard/views/student_dashboard_view.dart';
import 'package:uni_lecture/app/modules/teacher/account/bindings/account_binding.dart';
import 'package:uni_lecture/app/modules/teacher/account/views/account_view.dart';
import 'package:uni_lecture/app/modules/teacher/chat/bindings/chat_binding.dart';
import 'package:uni_lecture/app/modules/teacher/chat/views/chat_view.dart';
import 'package:uni_lecture/app/modules/teacher/class_screen/bindings/class_binding.dart';
import 'package:uni_lecture/app/modules/teacher/class_screen/views/class_view.dart';
import 'package:uni_lecture/app/modules/teacher/home/bindings/home_binding.dart';
import 'package:uni_lecture/app/modules/teacher/home/views/home_view.dart';
import 'package:uni_lecture/app/modules/teacher/join_course/bindings/join_course_binding.dart';
import 'package:uni_lecture/app/modules/teacher/join_course/views/join_course_view.dart';
import 'package:uni_lecture/app/modules/teacher/joined_courses/bindings/joined_classes_binding.dart';
import 'package:uni_lecture/app/modules/teacher/joined_courses/views/joined_classes_view.dart';
import 'package:uni_lecture/app/modules/teacher/schedule/bindings/schedule_binding.dart';
import 'package:uni_lecture/app/modules/teacher/schedule/views/schedule_view.dart';
  import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/student/chat/bindings/chat_binding.dart';
import '../modules/student/home/bindings/home_binding.dart';
import '../modules/student/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/teacher/course_students/bindings/course_students_binding.dart';
import '../modules/teacher/course_students/views/course_students_view.dart';
import '../modules/teacher/teacher_dashboard/bindings/student_dashboard_binding.dart';
import '../modules/teacher/teacher_dashboard/views/student_dashboard_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGOTPASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),



    ///student

    GetPage(
      name: _Paths.STUDENT_DASHBOARD,
      page: () => const StudentDashboardView(),
      binding: StudentDashboardBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SCHEDULE,
      page: () => const ScheduleView(),
      binding: ScheduleBinding(),
    ),
    GetPage(
      name: _Paths.JOINEDCLASSES,
      page: () => const JoinedClassesView(),
      binding: JoinedClassesBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => const AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.JOINCLASS,
      page: () => const JoinCourseView(),
      binding: JoinCourseBinding(),
    ),
    GetPage(
      name: _Paths.CLASS,
      page: () => const ClassView(),
      binding: ClassBinding(),
    ),
    GetPage(
      name: _Paths.COURSESTUDENTS,
      page: () => const CourseStudentsView(),
      binding: CourseStudentsBinding(),
    ),



    ///teacher

    GetPage(
      name: _Paths.TEACHER_DASHBOARD,
      page: () => const TeacherDashboardView(),
      binding: TeacherDashboardBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_HOME,
      page: () => const TeacherHomeView(),
      binding: TeacherHomeBinding(),
      children: [
        GetPage(
          name: _Paths.TEACHER_HOME,
          page: () => const TeacherHomeView(),
          binding: TeacherHomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.TEACHER_SCHEDULE,
      page: () => const TeacherScheduleView(),
      binding: TeacherScheduleBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_JOINEDCLASSES,
      page: () => const TeacherJoinedClassesView(),
      binding: TeacherJoinedClassesBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_CHAT,
      page: () => const TeacherChatView(),
      binding: TeacherChatBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_ACCOUNT,
      page: () => const TeacherAccountView(),
      binding: TeacherAccountBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_JOINCLASS,
      page: () => const TeacherJoinCourseView(),
      binding: TeacherJoinCourseBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_CLASS,
      page: () => const TeacherClassView(),
      binding: TeacherClassBinding(),
    ),
    GetPage(
      name: _Paths.TEACHERCOURSESTUDENTS,
      page: () => const TeacherCourseStudentsView(),
      binding: TeacherCourseStudentsBinding(),
    ),
  ];
}
