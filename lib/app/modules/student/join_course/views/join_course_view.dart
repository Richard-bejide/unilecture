import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_lecture/app/shared/utils/text_style.dart';
import 'package:uni_lecture/app/shared/widgets/back_button.dart';
import 'package:uni_lecture/app/shared/widgets/loading_overlay.dart';
import 'package:uni_lecture/app/shared/widgets/scaffold_bg.dart';
import '../../../../shared/utils/colors.dart';
import '../controllers/join_course_controller.dart';

class JoinCourseView extends GetView<JoinCourseController> {
  const JoinCourseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlayWidget(
        isLoading: controller.isUploading.value,
        child: Scaffold(
          body: ScaffoldBG(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      backButton(),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Join Course',
                        style: TextStyle(
                          color: Color(0xFF1D2939),
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      textField(),
                      const SizedBox(
                        width: 10,
                      ),
                      Obx(
                        () => controller.isLoading.value
                            ? SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: AppColors.kPrimaryColor,
                                  strokeWidth: 3,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  if(controller.course.text.trim().isNotEmpty && controller.course.text.trim() != '') {
                                    FocusScope.of(context).unfocus();
                                    controller.getCourseDetails();
                                  }
                                },
                                child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.arrow_forward,
                                          color: AppColors.kPrimaryColor,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          '',
                                          style: AppText.boldText.copyWith(color: AppColors.kPrimaryColor),
                                        ),
                                      ],
                                    ))),
                      ),
                    ],
                  ),
                  Text(
                    'Ask your teacher for the class link, then enter it here.',
                    style: AppText.regularText.copyWith(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(
                      () => controller.courseDetails.isNotEmpty
                        ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Verify course details',
                              style: AppText.regularText.copyWith(color: Colors.black87,fontSize: 12),
                            ),
                            const SizedBox(height: 2),
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.kPrimaryColor.withOpacity(0.1),
                                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        controller.courseDetails['imageUrl'] == null
                                            ? CircleAvatar(
                                                radius: 30.0,
                                                backgroundColor: AppColors.kPrimaryColor,
                                                child: const Center(child: Icon(Icons.image, size: 30.0, color: Colors.white)),
                                              )
                                            : CachedNetworkImage(
                                                placeholder: (context, url) => Center(
                                                    child: SizedBox(
                                                        height: 30,
                                                        width: 30,
                                                        child: CircularProgressIndicator(color: AppColors.kPrimaryColor))),
                                                errorWidget: (context, url, error) => CircleAvatar(
                                                  radius: 30.0,
                                                  backgroundColor: AppColors.kPrimaryColor,
                                                  child: const Center(
                                                      child: Icon(Icons.person_outlined, size: 30.0, color: Colors.white)),
                                                ),
                                                fit: BoxFit.cover,
                                                imageUrl: controller.courseDetails['imageUrl'],
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
                                                controller.courseDetails['name'] ?? '',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppText.semiBoldText
                                                    .copyWith(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 1,
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.4,
                                              child: Text(
                                                controller.courseDetails['teacherName'] ?? '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppText.semiBoldText
                                                    .copyWith(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                InkWell(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      controller.joinCourse();
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: AppColors.kPrimaryColor,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              'JOIN',
                                              style: AppText.boldText.copyWith(color: AppColors.kPrimaryColor),
                                            ),
                                          ],
                                        ))),
                              ],
                            ),
                          ],
                        )
                        : const SizedBox(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textField() {
    final joinController = Get.put(JoinCourseController());
    return Expanded(
      child: TextField(
        controller: joinController.course,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.characters,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, letterSpacing: 1.1),
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
          contentPadding: const EdgeInsets.only(left: 15.0),
          hintText: "ASDQ-JFK-2T4REWQ-F5AS-12WS",
          hintStyle: const TextStyle(color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
