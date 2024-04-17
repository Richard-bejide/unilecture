import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uni_lecture/app/shared/utils/enums.dart';
import 'package:uni_lecture/app/shared/utils/show_toast.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/utils/colors.dart';
import '../../../shared/utils/text_style.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.currentPage.value == 2) {
          controller.currentPage.value--;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.kBgColor,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(() => controller.currentPage.value == 1 ? firstPage(context) : secondPage()),
          )),
    );
  }

  Widget firstPage(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () async {
                        Get.back();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFF2F4F7),
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.grey,
                            size: 22,
                          ),
                        ),
                      )),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: 200,
                        child: LinearProgressIndicator(
                          color: AppColors.kPrimaryColor,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          minHeight: 12,
                          borderRadius: BorderRadius.circular(30),
                          value: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'What type of account would you like to create? 🤔',
                textAlign: TextAlign.center,
                style: AppText.boldText.copyWith(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => box(
                  title: 'Teacher',
                  icon: 'assets/icons/person.svg',
                  iconColor: Colors.deepOrangeAccent,
                  onTap: () {
                    controller.selectedAccountType.value = 1;
                  },
                  selectedColor: controller.selectedAccountType.value == 1
                      ? AppColors.kPrimaryColor
                      : Colors.grey.withOpacity(0.3),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Obx(
                () => box(
                  title: 'Student',
                  icon: 'assets/icons/students.svg',
                  iconColor: Colors.blueAccent,
                  onTap: () {
                    controller.selectedAccountType.value = 2;
                  },
                  selectedColor: controller.selectedAccountType.value == 2
                      ? AppColors.kPrimaryColor
                      : Colors.grey.withOpacity(0.3),
                ),
              )
            ],
          ),
        ),
         CustomButton(
            buttonColor: AppColors.kPrimaryColor,
           title: controller.buttonText.value,
            onPressed: () {
              if(controller.selectedAccountType.value != 0) {
                controller.currentPage.value++;
              }else{
                showToast(message: 'Please, Select an account type!', toastType: ToastType.info, context: context);
              }
            },
          ),
        const SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            Get.offNamed(Routes.LOGIN);
          },
          highlightColor: AppColors.kPrimaryColor.withOpacity(0.1),
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: AppText.regularText.copyWith(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  'SIGN IN',
                  style: AppText.regularText
                      .copyWith(color: AppColors.kPrimaryColor, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget secondPage() {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () async {
                        controller.currentPage.value--;
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFF2F4F7),
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.grey,
                            size: 22,
                          ),
                        ),
                      )),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: 200,
                        child: LinearProgressIndicator(
                          color: AppColors.kPrimaryColor,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          minHeight: 12,
                          borderRadius: BorderRadius.circular(30),
                          value: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Create an account 📝',
                textAlign: TextAlign.center,
                style: AppText.boldText.copyWith(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                width: Get.width * 0.8,
                child: Text(
                  'Please complete your profile. Don\'t worry. Your data will remain private and only you can see it.',
                  textAlign: TextAlign.center,
                  style: AppText.regularText,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'Enter your username',
                      labelText: 'Username',
                      validator: (inputValue) {
                        if (inputValue == null || inputValue.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                      controller: controller.username,
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      hintText: 'Enter your first name',
                      labelText: 'First Name',
                      validator: (inputValue) {
                        if (inputValue == null || inputValue.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                      controller: controller.firstname,
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      hintText: 'Enter your last name',
                      labelText: 'Last Name',
                      validator: (inputValue) {
                        if (inputValue == null || inputValue.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                      controller: controller.lastname,
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      hintText: 'Enter your email address',
                      labelText: 'Email Address',
                      validator: (inputValue) {
                        if (inputValue == null || inputValue.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                      controller: controller.email,
                    ),
                    const SizedBox(height: 5),
                    Obx(
                      () => CustomTextField(
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        obscureText: controller.obscurePassword.value,
                        suffix: GestureDetector(
                          onTap: () {
                            controller.obscurePassword.value = !controller.obscurePassword.value;
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3.0),
                            child: Icon(
                                controller.obscurePassword.value
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.kPrimaryColor,
                                size: 18),
                          ),
                        ),
                        validator: (inputValue) {
                          if (inputValue == null || inputValue.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                        controller: controller.password,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Obx(
                    () => CustomButton(
                  showLoadingIcon: controller.isLoading.value,
                  buttonColor: AppColors.kPrimaryColor,
                  title: controller.buttonText.value,
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      FocusScope.of(Get.context!).unfocus();
                      controller.createAccount();
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  Get.offNamed(Routes.LOGIN);
                },
                highlightColor: AppColors.kPrimaryColor.withOpacity(0.1),
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: AppText.regularText.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'SIGN IN',
                        style: AppText.regularText
                            .copyWith(color: AppColors.kPrimaryColor, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
        ),
    );
  }

  Widget box(
      {required String title,
      required String icon,
      required Color iconColor,
      required Function() onTap,
      required Color selectedColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: selectedColor,
              width: 4,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                16,
              ),
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        12,
                      ),
                      bottomLeft: Radius.circular(
                        12,
                      ),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: iconColor.withOpacity(0.5),
                    radius: 24,
                    child: SvgPicture.asset(
                      icon,
                      color: Colors.white,
                      height: 24,
                    ),
                  ),
                )),
            const SizedBox(
              width: 12,
            ),
            Text(
              title,
              style: AppText.boldText,
            ),
          ],
        ),
      ),
    );
  }
}
