import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/onboarding_view.dart';

class OnboardingController extends GetxController {

  final pages = [
    const PageData(
      icon: Icons.bubble_chart,
      title: "Let's embark on an exciting learning journey together!",
      bgColor: Color(0xFF0043D0),
      textColor: Colors.white,
    ),
    const PageData(
      icon: Icons.format_size,
      title: "Step into a dynamic learning environment designed just for you.",
      textColor: Colors.white,
      bgColor: Color(0xFFFDBFDD),
    ),
    const PageData(
      icon: Icons.hdr_weak,
      title: "From live lectures to group discussions, get ready to experience education like never before.",
      bgColor: Color(0xFFFFFFFF),
    ),
  ];
}
