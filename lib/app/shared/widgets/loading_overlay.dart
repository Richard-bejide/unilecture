 import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoadingOverlayWidget extends StatelessWidget {
  final bool isLoading;
  final String? loadingText;
  final Widget child;

  const LoadingOverlayWidget(
      {Key? key,
      required this.isLoading,
      required this.child,
      this.loadingText = 'Please wait...'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      opacity: 0.4,
      color: Colors.black87,
      isLoading: isLoading,
      progressIndicator: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(loadingText!,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                  fontFamily: 'graphik')),
          const SizedBox(height: 8),
          const SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
        ],
      ),
      child: child,
    );
  }
}
