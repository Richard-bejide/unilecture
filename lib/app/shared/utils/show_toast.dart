import 'package:uni_lecture/app/shared/utils/enums.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';

Future<dynamic> showToast({required String message, required ToastType toastType, required BuildContext context}) async {
  return context.showFlash<bool>(
    barrierColor: Colors.black12,
    barrierDismissible: true,
    barrierBlur: 1,
    duration: const Duration(
      milliseconds: 3000,
    ),
    builder: (context, controller) => FlashBar(
      position: FlashPosition.bottom,
      controller: controller,
      elevation: 0,
      iconColor: toastType == ToastType.success
          ? Colors.green
          : toastType == ToastType.info
              ? Colors.blue
              : Colors.red,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
        side: BorderSide(
          color: Colors.white,
          width: 0.5,
        ),
      ),
      indicatorColor: toastType == ToastType.success
          ? Colors.green
          : toastType == ToastType.info
              ? Colors.blue
              : Colors.red,
      icon: Icon(
        toastType == ToastType.success
            ? Icons.check
            : toastType == ToastType.info
                ? Icons.info_outline
                : Icons.error_outline,
      ),
      title: Text(
        toastType == ToastType.success
            ? 'Success'
            : toastType == ToastType.info
                ? 'Info'
                : 'Failed',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      content: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => controller.dismiss(true),
          child: const Text(
            'Okay',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    ),
  );
}
