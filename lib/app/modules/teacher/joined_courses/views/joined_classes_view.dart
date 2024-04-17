import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uni_lecture/app/shared/widgets/scaffold_bg.dart';
import '../../../../models/courses_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/utils/colors.dart';
import '../../../../shared/utils/text_style.dart';
import '../../chat/controllers/chat_controller.dart';
import '../controllers/joined_classes_controller.dart';

class TeacherJoinedClassesView extends GetView<TeacherJoinedClassesController> {
  const TeacherJoinedClassesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldBG(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'All Your Courses',
                    style: TextStyle(
                      color: Color(0xFF1D2939),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: AppColors.kPrimaryColor,
                              strokeWidth: 3,
                            ),
                          ),
                        )
                      : SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: false,
                          onRefresh: () async {
                            await controller.refreshData();
                          },
                          header: const WaterDropMaterialHeader(),
                          controller: controller.refreshController,
                          child: controller.allClasses.isEmpty
                              ? SingleChildScrollView(
                                  child: SizedBox(
                                    height: Get.height * 0.5,
                                    child: Center(
                                      child: Text(
                                        'You haven\'t added any course yet!',
                                        style: AppText.semiBoldText
                                            .copyWith(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(0),
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: controller.allClasses.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    CoursesModel course = controller.allClasses[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 20.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.TEACHER_CHAT);
                                          final teacherChatController = Get.put(TeacherChatController());
                                          teacherChatController.updateCourseDetails(course);
                                          },
                                        child: Container(
                                          padding: const EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                            color: AppColors.kPrimaryColor.withOpacity(0.1),
                                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              course.imageUrl == null
                                                  ? CircleAvatar(
                                                      radius: 30.0,
                                                      backgroundColor: AppColors.kPrimaryColor,
                                                      child: const Center(
                                                          child: Icon(Icons.image,
                                                              size: 30.0, color: Colors.white)),
                                                    )
                                                  : CachedNetworkImage(
                                                      placeholder: (context, url) => Center(
                                                          child: SizedBox(
                                                              height: 30,
                                                              width: 30,
                                                              child: CircularProgressIndicator(
                                                                  color: AppColors.kPrimaryColor))),
                                                      errorWidget: (context, url, error) => CircleAvatar(
                                                        radius: 30.0,
                                                        backgroundColor: AppColors.kPrimaryColor,
                                                        child: const Center(
                                                            child: Icon(Icons.person_outlined,
                                                                size: 30.0, color: Colors.white)),
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
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: Get.width * 0.6,
                                                    child: Text(
                                                      course.name ?? '',
                                                      maxLines: 3,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: AppText.semiBoldText.copyWith(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 1,
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.5,
                                                    child: Text(
                                                      course.teacherName ?? '',
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: AppText.semiBoldText.copyWith(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w300,
                                                          color: Colors.black),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
