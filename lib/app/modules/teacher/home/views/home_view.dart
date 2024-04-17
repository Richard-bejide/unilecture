import 'package:cached_network_image/cached_network_image.dart';
import 'package:new_im_animations/im_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uni_lecture/app/models/courses_model.dart';
import 'package:uni_lecture/app/modules/teacher/chat/controllers/chat_controller.dart';
import 'package:uni_lecture/app/shared/utils/colors.dart';
import 'package:uni_lecture/app/shared/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uni_lecture/app/shared/widgets/scaffold_bg.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class TeacherHomeView extends GetView<TeacherHomeController> {
  const TeacherHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.kPrimaryColor,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: () {
          Get.toNamed(Routes.TEACHER_JOINCLASS);
        },
        mini: true,
        elevation: 3,
        tooltip: 'Create Course',
        child: const Icon(
          Icons.add,
          size: 20,
        ),
      ),
      backgroundColor: AppColors.kBgColor,
      body: ScaffoldBG(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                DateTime.now().hour >= 17
                    ? 'Good Evening 🌤️'
                    : DateTime.now().hour >= 12
                        ? 'Good Afternoon 🌤️'
                        : 'Good Morning 🌤️',
                style: AppText.regularText.copyWith(
                  color: const Color(0xFF475467),
                  fontSize: 13,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              search(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  onRefresh: () async {
                    await controller.refreshData();
                  },
                  header: const WaterDropMaterialHeader(),
                  controller: controller.refreshController,
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      classes(),
                      const SizedBox(
                        height: 30,
                      ),
                      allClasses(),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget search() {
    final homeController = Get.put(TeacherHomeController());
    return SizedBox(
      width: double.maxFinite,
      height: 40,
      child: TextField(
        //controller: controller.search,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        onChanged: (val) {
          //
        },
        decoration: InputDecoration(
          filled: true,
          counterText: '',
          fillColor: AppColors.kPrimaryColor.withOpacity(0.1),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.kBgColor, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.kBgColor, width: 0.5),
          ),
          contentPadding: const EdgeInsets.only(left: 5.0),
          prefixIcon: const Icon(Icons.search_rounded, color: Colors.black54),
          hintText: "Search...",
          hintStyle: const TextStyle(color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget classes() {
    final homeController = Get.put(TeacherHomeController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                'Classes you have ${controller.selectedClassesFilter.value == 1 ? 'Today' : 'Tomorrow'}',
                style: AppText.semiBoldText,
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            PopupMenuButton<int>(
                itemBuilder: (context) => [
                      const PopupMenuItem(value: 1, child: Text('Today')),
                      const PopupMenuItem(value: 2, child: Text('Tomorrow')),
                    ],
                onSelected: (val) {
                  controller.selectedClassesFilter.value = val;
                },
                icon: Container(
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      'assets/icons/filter.svg',
                      height: 16,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
                position: PopupMenuPosition.under,
                elevation: 0)
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        SizedBox(
          height: Get.height * 0.36,
          child: Obx(
            () => ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(0),
                physics: const BouncingScrollPhysics(),
                itemCount: controller.selectedClassesFilter.value == 1
                    ? homeController.todayClasses.length
                    : homeController.tomorrowClasses.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> cls = controller.selectedClassesFilter.value == 1
                      ? homeController.todayClasses[index]
                      : homeController.tomorrowClasses[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.CLASS);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor.withOpacity(0.1),
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white24,
                              offset: Offset(2, 4),
                              blurRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: Get.height * 0.25,
                              width: Get.width * 0.6,
                              decoration: BoxDecoration(
                                color: AppColors.kPrimaryColor,
                                image: DecorationImage(image: AssetImage(cls['banner']), fit: BoxFit.fill),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                              ),
                              child: cls['isLive']
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Sonar(
                                            radius: 14,
                                            waveColor: Colors.green,
                                            child: const CircleAvatar(
                                              backgroundColor: Colors.green,
                                              radius: 6,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              'LIVE',
                                              style: AppText.boldText.copyWith(
                                                fontSize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.5,
                                    child: Text(
                                      cls['title'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppText.semiBoldText
                                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.55,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/clock2.svg',
                                              height: 15,
                                              color: Colors.black,
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              cls['start'],
                                              style: AppText.semiBoldText.copyWith(
                                                  fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/duration.svg',
                                              height: 14,
                                              color: Colors.black,
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              cls['duration'],
                                              style: AppText.semiBoldText.copyWith(
                                                  fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget allClasses() {
    final homeController = Get.put(TeacherHomeController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'All Your Courses',
              style: AppText.semiBoldText,
            ),
            const SizedBox(
              width: 3,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.TEACHER_JOINEDCLASSES);
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.transparent,
                child: Text(
                  'See all',
                  style: AppText.boldText.copyWith(color: AppColors.kPrimaryColor, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Obx(
          () => controller.isLoading.value
              ? SizedBox(
                  height: Get.height * 0.15,
                  child: Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: AppColors.kPrimaryColor,
                        strokeWidth: 3,
                      ),
                    ),
                  ),
                )
              : controller.allClasses.isEmpty
                  ? SizedBox(
                      height: Get.height * 0.15,
                      child: Center(
                        child: Text(
                          'You haven\'t added any course yet!',
                          style: AppText.semiBoldText
                              .copyWith(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.black),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: Get.height * 0.13,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(0),
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.allClasses.length,
                          itemBuilder: (BuildContext context, int index) {
                            CoursesModel? course = homeController.allClasses[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.TEACHER_CHAT);
                                  final teacherChatController = Get.put(TeacherChatController());
                                  teacherChatController.updateCourseDetails(course);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.kPrimaryColor.withOpacity(0.1),
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      course.imageUrl == null
                                          ? CircleAvatar(
                                              radius: 30.0,
                                              backgroundColor: AppColors.kPrimaryColor,
                                              child: const Center(
                                                  child: Icon(Icons.image, size: 30.0, color: Colors.white)),
                                            )
                                          : CachedNetworkImage(
                                              placeholder: (context, url) => Center(
                                                  child: SizedBox(
                                                      height: 30,
                                                      width: 30,
                                                      child:
                                                          CircularProgressIndicator(color: AppColors.kPrimaryColor))),
                                              errorWidget: (context, url, error) => CircleAvatar(
                                                radius: 30.0,
                                                backgroundColor: AppColors.kPrimaryColor,
                                                child: const Center(
                                                    child:
                                                        Icon(Icons.person_outlined, size: 30.0, color: Colors.white)),
                                              ),
                                              fit: BoxFit.cover,
                                              imageUrl: course.imageUrl!,
                                              imageBuilder: (context, imageProvider) {
                                                return CircleAvatar(
                                                  radius: 30.0,
                                                  backgroundImage: imageProvider,
                                                );
                                              },
                                            ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: Get.width * 0.4,
                                            child: Text(
                                              course.name ?? '',
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppText.semiBoldText.copyWith(
                                                  fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 1,
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.4,
                                            child: Text(
                                              course.teacherName ?? '',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppText.semiBoldText.copyWith(
                                                  fontSize: 10, fontWeight: FontWeight.w300, color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
        )
      ],
    );
  }
}
