import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final Color buttonColor;
  final Color textColor;
  final Color borderColor;
  final Color loadingIconColor;
  final bool showLoadingIcon;
  final bool enabled;

  const CustomButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.buttonColor = Colors.blue,
      this.textColor = Colors.white,
      this.borderColor = Colors.transparent,
      this.loadingIconColor = Colors.white,
      this.showLoadingIcon = false,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
     child: ElevatedButton(
         style: ElevatedButton.styleFrom(
           elevation:5,
           backgroundColor: enabled && !showLoadingIcon
               ? buttonColor
               : buttonColor.withOpacity(0.5),
           foregroundColor: enabled && !showLoadingIcon
               ? Colors.white
               : buttonColor.withOpacity(0.1),
           padding: const EdgeInsets.symmetric(
             horizontal: 13,
             vertical: 12,
           ),
           shape: RoundedRectangleBorder(
             side: BorderSide(
               color: borderColor,
             ),
             borderRadius: const BorderRadius.all(
               Radius.circular(30.0),
             ),
           ),
         ),
         onPressed: !enabled
             ? () {}
             : showLoadingIcon
                 ? () {}
                 : onPressed,
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Text(
               title,
               style: TextStyle(
                 color: textColor,
                 letterSpacing: 0.0,
                 fontSize: 13.0,
                 fontWeight: FontWeight.w700,
               ),
             ),
             showLoadingIcon
                 ? Padding(
                     padding: const EdgeInsets.only(
                       left: 10.0,
                     ),
                     child: SizedBox(
                       width: 20,
                       height: 20,
                       child: CircularProgressIndicator(
                         color: loadingIconColor,
                         strokeWidth: 3,
                       ),
                     ),
                   )
                 : const SizedBox(),
           ],
         )),
      );
  }
}
