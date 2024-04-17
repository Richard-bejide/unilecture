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
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4), borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Students(6)',
                  style: AppText.semiBoldText.copyWith(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: Get.height * 0.3,
                width: Get.width * 0.2,
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  children: [
                    Image.asset(
                      'assets/images/student_call1.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/images/student_call2.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/images/student_call3.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/images/student_call1.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/images/student_call2.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/images/student_call3.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4), borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Quick Tools',
                  style: AppText.semiBoldText.copyWith(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: Get.height * 0.15,
                width: Get.width * 0.2,
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 16,
                          child:  Icon(
                            Icons.chat,
                            color: Colors.black87,
                            size: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Chat',
                          style: AppText.semiBoldText.copyWith(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 16,
                          child:  Icon(
                            Icons.back_hand_sharp,
                            color: Colors.black87,
                            size: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Raise Hand',
                          style: AppText.semiBoldText.copyWith(
                            fontSize: 12,
                            color: Colors.white,
                          ),
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
          child: Container(
            width: double.infinity,
            height: 110.0,
            decoration: const BoxDecoration(
                // color: Colors.white,
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CallRoundedButton(
                  press: () {},
                  color: classController.mute ? AppColors.kPrimaryColor : Colors.white,
                  iconSrc: "assets/icons/mic.svg",
                  iconColor: Colors.white,
                  title: 'Mute',
                ),
                const SizedBox(
                  width: 15,
                ),
                CallRoundedButton(
                  press: () {},
                  iconSrc: "assets/icons/flip_camera.svg",
                  iconColor: Colors.white,
                  title: 'Camera',
                  color: classController.flipCamera ? AppColors.kPrimaryColor : Colors.white,
                ),
                const SizedBox(
                  width: 15,
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
        ),
      ],
    );
  }
}
