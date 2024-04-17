import 'package:flutter/material.dart';
import '../utils/colors.dart';

class ScaffoldBG extends StatelessWidget {
  final Widget child;

  const ScaffoldBG({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kBgColor,
          // gradient: LinearGradient(
          //   begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          //   colors: [
          //     AppColors.kPrimaryColor.withOpacity(0.05),
          //     AppColors.kPrimaryColor.withOpacity(0.15),
          //     AppColors.kPrimaryColor.withOpacity(0.01),
          //   ],
          // )
      ),
      child: child,
    );
  }
}
