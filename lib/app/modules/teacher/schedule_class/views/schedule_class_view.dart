import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:uni_lecture/app/shared/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../shared/utils/colors.dart';
import '../../../../shared/utils/text_style.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../controllers/schedule_class_controller.dart';

class ScheduleClass extends GetView<ScheduleClassController> {
  const ScheduleClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Obx(
            () => Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
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
                            'Schedule Class',
                            style: TextStyle(
                              color: Color(0xFF1D2939),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      tile(
                        title: 'Date',
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 30)),
                          );
                          controller.date.value = pickedDate != null ? DateFormat('dd/MM/yyyy').format(pickedDate) : '';
                        },
                        trailing: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                controller.date.value,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 15),
                              const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey, size: 25),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      tile(
                          title: 'Start time',
                          onTap: () {
                            //
                          },
                          trailing: Column(
                            children: [
                              startTimeDropdown(),
                              Divider(
                                height: 1,
                                color: Colors.grey[200],
                              )
                            ],
                          )),
                      tile(
                          title: 'End time',
                          onTap: () {
                            //
                          },
                          trailing: Column(
                            children: [
                              endTimeDropdown(),
                              Divider(
                                height: 1,
                                color: Colors.grey[200],
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                CustomButton(
                  showLoadingIcon: controller.isLoading.value,
                  buttonColor: AppColors.kPrimaryColor,
                  title: 'Schedule',
                  onPressed: () {
                    controller.scheduleClass();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tile({required String title, required Widget trailing, required Function() onTap}) {
    return Row(
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
          ],
        ),
        GestureDetector(onTap: onTap, child: trailing)
      ],
    );
  }

  Widget startTimeDropdown() {
    final controller = Get.put(ScheduleClassController());
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
          value: controller.startTime.value,
          //isExpanded: true,
          style: AppText.regularText.copyWith(fontSize: 17, fontWeight: FontWeight.bold),
          hint: Text(controller.startTime.value,
              style: AppText.regularText.copyWith(
                color: Colors.grey,
              )),
          underline: const SizedBox(),
          items: controller.time
              .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: AppText.regularText,
                  )))
              .toList(),
          onChanged: (String? value) {
            if (value != null) {
              controller.startTime.value = value;
            }
          }),
    );
  }

  Widget endTimeDropdown() {
    final controller = Get.put(ScheduleClassController());
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
          value: controller.endTime.value,
          //isExpanded: true,
          style: AppText.regularText.copyWith(fontSize: 17, fontWeight: FontWeight.bold),
          hint: Text(controller.endTime.value,
              style: AppText.regularText.copyWith(
                color: Colors.grey,
              )),
          underline: const SizedBox(),
          items: controller.time
              .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: AppText.regularText,
                  )))
              .toList(),
          onChanged: (String? value) {
            if (value != null) {
              controller.endTime.value = value;
            }
          }),
    );
  }
}
