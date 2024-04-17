import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_lecture/app/shared/utils/enums.dart';
import 'package:uni_lecture/app/shared/utils/show_toast.dart';
import 'package:uni_lecture/app/shared/widgets/back_button.dart';
import 'package:uni_lecture/app/shared/widgets/scaffold_bg.dart';
import '../../../../shared/utils/colors.dart';
import '../../../../shared/utils/debug_print.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../controllers/join_course_controller.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class TeacherJoinCourseView extends GetView<TeacherJoinCourseController> {
  const TeacherJoinCourseView({Key? key}) : super(key: key);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  backButton(),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Create Course',
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
              Expanded(
                child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomTextField(
                      hintText: 'Enter your course name',
                      labelText: 'Course Name',
                      validator: (inputValue) {
                        if (inputValue == null || inputValue.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                      controller: controller.courseName,
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await [Permission.photos].request();
                              final pickedImage = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery, imageQuality: 70);
                              if (pickedImage != null) {
                                dPrint('image path ${pickedImage.path}');
                                controller.doc1.value = pickedImage.path;
                              }
                            },
                            child: Obx(
                              () => Container(
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  height: MediaQuery.of(context).size.height * 0.15,
                                  decoration: BoxDecoration(
                                      color: AppColors.kPrimaryColor.withOpacity(0.05),
                                      shape: BoxShape.rectangle),
                                  child: Center(
                                    child: controller.doc1.value != ''
                                        ? Container(
                                      width: MediaQuery.of(context).size.width * 0.7,
                                      height: MediaQuery.of(context).size.height * 0.15,
                                      decoration: BoxDecoration(
                                          color: AppColors.kPrimaryColor.withOpacity(0.05),
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: FileImage(File(controller.doc1.value)),fit: BoxFit.cover)),
                                    )
                                        : Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                                      child: Center(
                                          child: Icon(Icons.add_a_photo_outlined,
                                              size: 60.0, color: Colors.grey.withOpacity(0.7))),
                                    ),
                                  )),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Click to add course image',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              Obx(
                    () => CustomButton(
                  showLoadingIcon: controller.isLoading.value,
                  buttonColor: AppColors.kPrimaryColor,
                  title: 'Create Course',
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      FocusScope.of(Get.context!).unfocus();
                      if(controller.doc1.value != ''){
                      controller.uploadCourse();
                    }else{
                        showToast(message: 'Add Course Image', toastType: ToastType.info, context: context);
                      }
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
