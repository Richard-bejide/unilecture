import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_lecture/app/shared/utils/text_style.dart';
import 'package:uni_lecture/app/shared/widgets/scaffold_bg.dart';
import '../../../../shared/utils/colors.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(
      body: ScaffoldBG(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
                      color: Color(0xFF1D2939),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        controller.logout();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.all(Radius.circular(16))),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Row(
                            children: [
                              Text(
                                'LOGOUT',
                                style: AppText.regularText.copyWith(color: Colors.red, fontSize: 14),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Icon(
                                Icons.logout,
                                color: Colors.red,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      controller.loadingImage.value
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: AppColors.kPrimaryColor,
                                strokeWidth: 2,
                              ),
                            )
                          : homeController.image.value != ''
                              ? CachedNetworkImage(
                                  placeholder: (context, url) => Center(
                                      child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator(color: AppColors.kPrimaryColor))),
                                  errorWidget: (context, url, error) => CircleAvatar(
                                    radius: 35.0,
                                    backgroundColor: Colors.grey.withOpacity(0.4),
                                    child: const Icon(Icons.person_outlined, size: 25.0, color: Colors.white),
                                  ),
                                  fit: BoxFit.cover,
                                  imageUrl: homeController.image.value,
                                  imageBuilder: (context, imageProvider) {
                                    return CircleAvatar(
                                      radius: 35.0,
                                      backgroundImage: imageProvider,
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.selectImage();
                                        },
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.black12,
                                          radius: 35,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.change_circle_outlined,
                                                color: Colors.white70,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : GestureDetector(
                                  onTap: () {
                                    controller.selectImage();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.kPrimaryColor,
                                    radius: 35,
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.photo_camera_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Get.width * 0.5,
                            child: Text(
                              '${homeController.firstName.value} ${homeController.lastName.value}',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.semiBoldText.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          SizedBox(
                            width: Get.width * 0.5,
                            child: Text(
                              homeController.email.value,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.semiBoldText.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.verified_user_sharp, size: 16, color: AppColors.kPrimaryColor),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                homeController.accountType.value,
                                style: AppText.boldText.copyWith(
                                  fontSize: 10,
                                  color: AppColors.kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey[200],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        tile(
                          title: 'Enable Captions',
                          subtitle: 'Enable subtitles for audio/video contents for users with hearing impairments',
                          onTap: () {
                            //
                          },
                          trailing: SizedBox(
                            height: 20,
                            width: 20,
                            child: Switch(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: controller.enableCaptions.value,
                              activeColor: AppColors.kPrimaryColor,
                              onChanged: (val) {
                                controller.enableCaptions.value = !controller.enableCaptions.value;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        tile(
                          title: 'Enable Screen Magnifier',
                          subtitle: 'Optimize screen readability for users with visual impairments',
                          onTap: () {
                            //
                          },
                          trailing: SizedBox(
                            height: 20,
                            width: 20,
                            child: Switch(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: controller.enableReadability.value,
                              activeColor: AppColors.kPrimaryColor,
                              onChanged: (val) {
                                controller.enableReadability.value = !controller.enableReadability.value;
                              },
                            ),
                          ),
                        ),
                        tile(
                            title: 'Language',
                            subtitle: 'Switch to your preferred language',
                            onTap: () {
                              //
                            },
                            trailing: Column(
                              children: [
                                dropdown(),
                                Divider(
                                  height: 1,
                                  color: Colors.grey[200],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget tile({required String title, required String subtitle, required Widget trailing, required Function() onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Color(0xFF344054),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              SizedBox(
                width: Get.width * 0.6,
                child: Text(
                  subtitle,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
          trailing
        ],
      ),
    );
  }

  Widget dropdown() {
    final controller = Get.put(AccountController());
    return SizedBox(
      width: Get.width * 0.2,
      child: DropdownButton<String>(
          iconSize: 2,
          elevation: 1,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 25,
            color: Colors.grey,
          ),
          value: controller.selectedLanguage.value,
          //isExpanded: true,
          style: AppText.regularText.copyWith(fontSize: 17, fontWeight: FontWeight.bold),
          hint: Text(controller.selectedLanguage.value,
              style: AppText.regularText.copyWith(
                color: Colors.grey,
              )),
          underline: const SizedBox(),
          items: controller.languages
              .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: AppText.regularText,
                  )))
              .toList(),
          onChanged: (String? value) {
            if (value != null) {
              controller.selectedLanguage.value = value;
            }
          }),
    );
  }
}
