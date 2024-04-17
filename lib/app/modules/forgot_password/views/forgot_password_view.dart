import 'package:uni_lecture/app/shared/utils/colors.dart';
import 'package:uni_lecture/app/shared/utils/enums.dart';
import 'package:uni_lecture/app/shared/utils/show_toast.dart';
import 'package:uni_lecture/app/shared/widgets/back_button.dart';
import 'package:uni_lecture/app/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../../../shared/utils/text_style.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.currentPage.value == 1) {
          return true;
        } else {
          controller.currentPage.value--;
          return false;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Obx(() {
              switch (controller.currentPage.value) {
                case 2:
                  return secondPage();
                case 3:
                  return thirdPage();
                case 4:
                  return fourthPage();
                default:
                  return firstPage();
              }
            }),
          ),
        ),
      ),
    );
  }

  Widget firstPage() {
    final controller = Get.put(ForgotPasswordController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        backButton(),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Forgot Password 🔒',
          style: AppText.boldText.copyWith(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        SizedBox(
          width: Get.width * 0.9,
          child: Text(
            'Please enter your email address so we’ll send a one-time code to reset your password.',
            style: AppText.regularText,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Form(
          key: controller.formKey,
          child: CustomTextField(
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
        ),
        const SizedBox(
          height: 60,
        ),
        CustomButton(
          showLoadingIcon: controller.isLoading.value,
          buttonColor: AppColors.kPrimaryColor,
          title: 'Send Code',
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              FocusScope.of(Get.context!).unfocus();
              controller.sendCode();
            }
          },
        ),
      ],
    );
  }

  Widget secondPage() {
    final controller = Get.put(ForgotPasswordController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        backBtn(),
        const SizedBox(
          height: 20,
        ),
        Text(
          'You\'ve got a mail 📥',
          style: AppText.boldText.copyWith(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        SizedBox(
          width: Get.width * 0.9,
          child: Text(
            'Please enter verification code sent to your email',
            style: AppText.regularText,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Center(
          child: Pinput(
            useNativeKeyboard: true,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            length: 6,
            preFilledWidget: Text('_',style: AppText.regularText,),
            showCursor: true,
            defaultPinTheme: PinTheme(
              width: 50,
              height: 45,
              textStyle: AppText.regularText
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
              decoration: BoxDecoration(
                  color: const Color(0xFFF2F4F7),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.shade300, width: 0.5)),
            ),
            submittedPinTheme: PinTheme(
              width: 50,
              height: 45,
              textStyle: AppText.regularText
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
              decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.shade300, width: 0.5)),
            ),
            focusedPinTheme: PinTheme(
              width: 50,
              height: 45,
              textStyle: AppText.regularText
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
              decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: AppColors.kPrimaryColor.withOpacity(0.4),
                      width: 0.5)),
            ),
            controller: controller.otp,
            onChanged: (val) {
            },
            onCompleted: (val) {
              FocusScope.of(Get.context!).unfocus();
            },
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                controller.resendCode();
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Didn’t get a code?  ',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    controller.isResendingCode.value
                        ? SizedBox(
                      height: 17,
                            width: 17,
                            child: CircularProgressIndicator(
                              color: AppColors.kPrimaryColor,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Resend',
                            style: TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                  ],
                ),
              ),
            ),
            Countdown(
              seconds: 30,
              build: (BuildContext context, double time) => Text(
                "${time.toInt()}s",
                style: TextStyle(
                  color: AppColors.kBlackColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              interval: const Duration(seconds: 1),
              controller: controller.countdownController,
              onFinished: () {
                controller.enableResendCode(true);
              },
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        CustomButton(
          showLoadingIcon: controller.isLoading.value,
          buttonColor: AppColors.kPrimaryColor,
          title: 'Confirm',
          onPressed: () {
            FocusScope.of(Get.context!).unfocus();
            if(controller.otp.text != '' && controller.otp.text.isNotEmpty && controller.otp.text.length == 6) {
              controller.verifyCode();
            }else{
              showToast(message: 'Please, enter the correct code', toastType: ToastType.info, context: Get.context!);
            }
          },
        ),
      ],
    );
  }

  Widget thirdPage() {
    final controller = Get.put(ForgotPasswordController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        backBtn(),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Create new password 🔒',
          style: AppText.boldText.copyWith(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        SizedBox(
          width: Get.width * 0.8,
          child: Text(
            'Create your new password to get back into your account',
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
                obscureText: controller.obscureNewPassword.value,
                hintText: 'Enter your password',
                labelText: 'Password',
                validator: (inputValue) {
                  if (inputValue == null || inputValue.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
                controller: controller.newPassword,
                suffix: SizedBox(
                  width: 40,
                  child: GestureDetector(
                    onTap: () {
                      controller.obscureNewPassword.value =
                          !controller.obscureNewPassword.value;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Icon(
                        controller.obscureNewPassword.value
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.black54,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ),
              CustomTextField(
                obscureText: controller.obscureNewPasswordConfirmation.value,
                hintText: 'Enter your password',
                labelText: 'Confirm Password',
                validator: (inputValue) {
                  if (inputValue == null || inputValue.isEmpty) {
                    return 'Field is required';
                  }
                  if (inputValue != controller.newPassword.value.text) {
                    return 'Passwords do not match. Kindly Re-enter password again';
                  }
                  return null;
                },
                controller: controller.newPasswordConfirmation,
                suffix: SizedBox(
                  width: 40,
                  child: GestureDetector(
                    onTap: () {
                      controller.obscureNewPasswordConfirmation.value =
                          !controller.obscureNewPasswordConfirmation.value;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Icon(
                        controller.obscureNewPasswordConfirmation.value
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.black54,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        CustomButton(
          showLoadingIcon: controller.isLoading.value,
          buttonColor: AppColors.kPrimaryColor,
          title: 'Reset Password',
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              FocusScope.of(Get.context!).unfocus();
              controller.createNewPassword();
            }
          },
        ),
      ],
    );
  }

  Widget fourthPage() {
    final controller = Get.put(ForgotPasswordController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '💪',
              textAlign: TextAlign.center,
              style: AppText.boldText.copyWith(fontSize: 50, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: Get.width * 0.6,
              child: Text(
                'Great! your password has been reset',
                textAlign: TextAlign.center,
                style: AppText.boldText
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const Spacer(),
        CustomButton(
          buttonColor: AppColors.kPrimaryColor,
          title: 'Back to Login',
          onPressed: () {
            controller.goToLogin();
          },
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget backBtn() {
    final controller = Get.put(ForgotPasswordController());
    return GestureDetector(
        onTap: () async {
          controller.currentPage.value--;
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
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
        ));
  }
}
