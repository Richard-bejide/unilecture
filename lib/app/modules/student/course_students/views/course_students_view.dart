import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uni_lecture/app/shared/widgets/back_button.dart';
import '../../../../models/user_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/utils/colors.dart';
import '../../../../shared/utils/text_style.dart';
import '../../chat/controllers/chat_controller.dart';
import '../controllers/course_students_controller.dart';

class CourseStudentsView extends GetView<CourseStudentsController> {
  const CourseStudentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Obx(
          () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    controller.courseDetails?.imageUrl == null
                        ? Container(
                            width: Get.width,
                            height: Get.height * 0.3,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                image: const DecorationImage(
                                    image: AssetImage(
                                      'assets/images/app_icon.png',
                                    ),
                                    fit: BoxFit.fill)),
                          )
                        : CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              width: Get.width,
                              height: Get.height * 0.3,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                        'assets/images/app_icon.png',
                                      ),
                                      fit: BoxFit.fill)),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: Get.width,
                              height: Get.height * 0.3,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                        'assets/images/app_icon.png',
                                      ),
                                      fit: BoxFit.fill)),
                            ),
                            fit: BoxFit.cover,
                            imageUrl: controller.courseDetails!.imageUrl!,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: Get.width,
                                height: Get.height * 0.3,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    image: DecorationImage(image: imageProvider, fit: BoxFit.fill)),
                              );
                            },
                          ),
                    Container(
                      width: Get.width,
                      height: Get.height * 0.3,
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
                            backButton(),
                            const Spacer(),
                            Center(
                              child: SizedBox(
                                width: Get.width * 0.8,
                                child: Text(
                                  controller.courseDetails?.name ?? '',
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppText.semiBoldText
                                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Center(
                              child: Text(
                                'By',
                                textAlign: TextAlign.center,
                                style: AppText.semiBoldText
                                    .copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white70),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Center(
                              child: SizedBox(
                                width: Get.width * 0.8,
                                child: Text(
                                  controller.courseDetails?.teacherName ?? '',
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppText.semiBoldText
                                      .copyWith(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        controller.currentView.value = 1;
                      },
                      child: Text(
                        'Students(${controller.allStudents.length})',
                        style: TextStyle(
                            color: controller.currentView.value == 1 ? Colors.black : Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            decoration:
                                controller.currentView.value == 1 ? TextDecoration.underline : TextDecoration.none),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        controller.currentView.value = 2;
                      },
                      child: Text(
                        'Course Materials(0)',
                        style: TextStyle(
                            color: controller.currentView.value == 2 ? Colors.black : Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            decoration:
                                controller.currentView.value == 2 ? TextDecoration.underline : TextDecoration.none),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    onRefresh: () async {
                      await controller.refreshData();
                    },
                    header: const WaterDropMaterialHeader(),
                    controller: controller.refreshController,
                    child: SingleChildScrollView(
                      child: controller.currentView.value == 1
                          ? controller.isLoading.value
                               ? SizedBox(
                              height: Get.height * 0.5,
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
                               : controller.allStudents.isEmpty
                                   ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                            child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            'assets/images/no_messages.png',
                            height: 100,
                            width: 150,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'No Students yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1D2939),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            'All students taking this course will appear here',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF98A1B2),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )))
                                   : Padding(
                                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                     child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.all(0),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.allStudents.length,
                              itemBuilder: (BuildContext context, int index) {
                                dynamic student = controller.allStudents[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          "${index + 1}",
                                          style: AppText.semiBoldText.copyWith(
                                              fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black87),
                                        ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      student?['imageUrl'] == null
                                          ? CircleAvatar(
                                              radius: 20.0,
                                              backgroundColor: AppColors.kPrimaryColor,
                                              child:
                                                  const Center(child: Icon(Icons.image, size: 30.0, color: Colors.white)),
                                            )
                                          : CachedNetworkImage(
                                              placeholder: (context, url) => Center(
                                                  child: SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child: CircularProgressIndicator(color: AppColors.kPrimaryColor))),
                                              errorWidget: (context, url, error) => CircleAvatar(
                                                radius: 20.0,
                                                backgroundColor: AppColors.kPrimaryColor,
                                                child: const Center(
                                                    child: Icon(Icons.person_outlined, size: 30.0, color: Colors.white)),
                                              ),
                                              fit: BoxFit.cover,
                                              imageUrl: student?['imageUrl'] ?? '',
                                              imageBuilder: (context, imageProvider) {
                                                return CircleAvatar(
                                                  radius: 20.0,
                                                  backgroundImage: imageProvider,
                                                );
                                              },
                                            ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: Get.width * 0.6,
                                            child: Text(
                                              student?['name'] ?? '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppText.semiBoldText.copyWith(
                                                  fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black),
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          SizedBox(
                                            width: Get.width * 0.6,
                                            child: Text(
                                              student?['email'] ?? '',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppText.semiBoldText.copyWith(
                                                  fontSize: 11, fontWeight: FontWeight.w300, color: Colors.black87),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }),
                                   )
                          : controller.isLoadingCourseMaterials.value
                               ? SizedBox(
                        height: Get.height * 0.5,
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
                               : controller.allCourseMaterials.isEmpty
                                  ? Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Center(
                                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            'assets/images/no_messages.png',
                            height: 100,
                            width: 150,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'No Course Materials yet!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1D2939),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            'All materials for the course will appear here',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF98A1B2),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                                    ),
                                  )
                                  : Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.all(0),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.allCourseMaterials.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                   //
                                },
                                child: Container(
                                ),
                              ),
                            );
                          }),
                                  ),
                    ),
                  ),
                )
              ]),
        ),
    );
  }
}
