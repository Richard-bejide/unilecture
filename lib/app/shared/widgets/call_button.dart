import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CallRoundedButton extends StatelessWidget {
  const CallRoundedButton({
    Key? key,
    this.size = 64,
    required this.title,
    required this.iconSrc,
    this.color = Colors.white,
    this.iconColor = Colors.black,
    required this.press,
  }) : super(key: key);

  final String title;
  final double size;
  final String iconSrc;
  final Color? color, iconColor;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              padding: EdgeInsets.all(15 / 64 * size),
              backgroundColor: color,
              foregroundColor: color,
              shape: const CircleBorder(
              ),
            ),
            onPressed: press,
            child: SvgPicture.asset(iconSrc, color: iconColor),
          ),
          const SizedBox(height: 5),
          Text(title,style: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}