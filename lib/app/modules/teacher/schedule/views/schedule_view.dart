import 'package:uni_lecture/app/shared/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_lecture/app/shared/widgets/scaffold_bg.dart';
import '../controllers/schedule_controller.dart';
import '../widgets/calendar_schedule.dart';

class TeacherScheduleView extends GetView<TeacherScheduleController> {
  const TeacherScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgColor,
      body: const ScaffoldBG(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: ScheduleCalendar(),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
