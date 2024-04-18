import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_lecture/app/shared/utils/colors.dart';
import '../../../../shared/utils/text_style.dart';
import '../../../../shared/widgets/call_button.dart';
import '../controllers/class_controller.dart';

class TeacherClassView extends GetView<TeacherClassController> {
  const TeacherClassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(child: _renderRemoteVideo()),
            Positioned(
              top: 50,
              right: 10,
              child: _renderLocalPreview(),
            ),
          ],
        ));
  }

  // current user video
  Widget _renderLocalPreview() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4), borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'All Students(${controller.students.length})',
                  style: AppText.semiBoldText.copyWith(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: Get.height * 0.1, maxWidth: Get.width * 0.7),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemCount: controller.students.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> student = controller.students[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              student['image'] ?? '',
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            SizedBox(
                              width: 60,
                              child: Text(
                                student['name'] ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // remote user video
  Widget _renderRemoteVideo() {
    final classController = Get.put(TeacherClassController());
    return Stack(
      fit: StackFit.expand,
      children: [
        classController.image != null
            ? Container(
                width: Get.width * 0.99,
                height: Get.height * 0.3,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(),
                    color: Colors.black54,
                    image: DecorationImage(image: AssetImage('assets/images/teacher_call.png'), fit: BoxFit.contain)),
              )
            : Container(
                height: Get.height * 0.4,
                width: Get.width * 0.3,
                decoration: BoxDecoration(color: AppColors.kBgColor),
                child: Image.asset(
                  'assets/images/student_call3.png',
                  fit: BoxFit.cover,
                ),
              ),
        // Black Layer
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Obx(
                () => controller.showPopup.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'John wants to join the class',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                        onTap: () async {
                                          controller.showPopup.value = false;
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          padding: const EdgeInsets.all(2),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Accept',
                                                style: AppText.regularText.copyWith(color: Colors.green, fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        )),
                                    const SizedBox(width: 12),
                                    GestureDetector(
                                        onTap: () async {
                                          controller.showPopup.value = false;
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          padding: const EdgeInsets.all(2),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Reject',
                                                style: AppText.regularText.copyWith(color: Colors.red, fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 110.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CallRoundedButton(
                      press: () {},
                      color: classController.mute ? AppColors.kPrimaryColor : Colors.white,
                      iconSrc: "assets/icons/chat1.svg",
                      iconColor: Colors.white,
                      title: 'Chat',
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CallRoundedButton(
                      press: () {},
                      color: classController.mute ? AppColors.kPrimaryColor : Colors.white,
                      iconSrc: "assets/icons/mic.svg",
                      iconColor: Colors.white,
                      title: 'Mute',
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CallRoundedButton(
                      press: () {},
                      color: classController.mute ? AppColors.kPrimaryColor : Colors.white,
                      iconSrc: "assets/icons/share_screen.svg",
                      iconColor: Colors.white,
                      title: 'Share Screen',
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CallRoundedButton(
                      press: () {},
                      iconSrc: "assets/icons/flip_camera.svg",
                      iconColor: Colors.white,
                      title: 'Camera',
                      color: classController.flipCamera ? AppColors.kPrimaryColor : Colors.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CallRoundedButton(
                      press: () {
                        Get.back();
                      },
                      iconSrc: "assets/icons/call_end.svg",
                      color: Colors.red,
                      iconColor: Colors.white,
                      title: 'Leave call',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
