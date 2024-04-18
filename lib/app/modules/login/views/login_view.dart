import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/utils/colors.dart';
import '../../../shared/utils/text_style.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.kBgColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Hello there  👋',
                      style: AppText.boldText.copyWith(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                      width: Get.width * 0.9,
                      child: Text(
                        'Welcome back to Unilecture',
                        style: AppText.regularText,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
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

                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: (){
                          controller.forgotPassword();
                        },
                        highlightColor: AppColors.kPrimaryColor.withOpacity(0.1),
                        child: Container(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            'Forgot Password?',
                            style: AppText.regularText.copyWith(
                              color: AppColors.kPrimaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => CustomButton(
                  showLoadingIcon: controller.isLoading.value,
                  buttonColor: AppColors.kPrimaryColor,
                  title: 'SIGN IN',
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      FocusScope.of(Get.context!).unfocus();
                      controller.login();
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: (){
                  Get.toNamed(Routes.REGISTER);
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
                        'Don\'t have an account?',
                        style: AppText.regularText.copyWith(
                            fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Register',
                        style: AppText.regularText.copyWith(
                            color: AppColors.kPrimaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
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
        ));
  }
}
