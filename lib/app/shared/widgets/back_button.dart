import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget backButton() {
  return GestureDetector(
      onTap: () async {
        Get.back();
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF2F4F7),
          shape: BoxShape.circle,
        ),
        child: const Padding(
          padding:  EdgeInsets.all(4),
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
            size: 22,
          ),
        ),
      ));
}
