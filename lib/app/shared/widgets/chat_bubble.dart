import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
  import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:timeago/timeago.dart' as timeago;
import '../utils/colors.dart';
import '../utils/enums.dart';
import 'package:photo_view/photo_view.dart';


class ChatBubble extends StatefulWidget {
  final MessageSender? sender;
  final Color? bgColor;
  final Color? textColor;
  final String time;
  final String? message;
  final ChatMessageType messageType;

  const ChatBubble(
      {Key? key,
        this.sender,
        this.bgColor,
        this.textColor,
        required this.time,
        this.message,
        required this.messageType})
      : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  CrossAxisAlignment messageAlignment() {
    if (widget.sender == null || widget.sender == MessageSender.boss) {
      return CrossAxisAlignment.start;
    } else {
      return CrossAxisAlignment.end;
    }
  }

  double bottomLeftRadius() {
    if (widget.sender == null || widget.sender == MessageSender.boss) {
      return 0.0;
    } else {
      return 12.0;
    }
  }

  double bottomRightRadius() {
    if (widget.sender == null || widget.sender == MessageSender.boss) {
      return 12.0;
    } else {
      return 0.0;
    }
  }

  Color messageBgColor(BuildContext context) {
    if (widget.sender == null || widget.sender == MessageSender.boss) {
      return const Color(0xFFE4E7EC);
    } else {
      return AppColors.kPrimaryColor;
    }
  }

  Color messageTextColor(BuildContext context) {
    if (widget.sender == null || widget.sender == MessageSender.boss) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: messageAlignment(),
        children: [
          Container(
              constraints: const BoxConstraints(minWidth: 40.0, maxWidth: 280.0),
              decoration: BoxDecoration(
                color: widget.bgColor ?? messageBgColor(context),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(bottomLeftRadius()),
                  bottomRight: Radius.circular(bottomRightRadius()),
                  topLeft: const Radius.circular(12.0),
                  topRight: const Radius.circular(12.0),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 8.0,
              ),
              child: showView(context)),
          Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 12.0,
              ),
              child: Text(
                timeago.format(DateTime.parse(widget.time)),
                style: const TextStyle(
                  fontSize: 10.0,
                  color: Color(0xFF666666),
                ),
              ))
        ],
      ),
    );
  }

  //text Message
  Widget _textMessage(BuildContext context) {
    return Text(
      widget.message ?? "...",
      style: TextStyle(
        fontSize: 13.0,
        color: widget.textColor ?? messageTextColor(context),
        fontWeight: FontWeight.w400,
      ),
    );
  }

  //photo message UI
  Widget _photoMessage(String? photo) {
    return GestureDetector(
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 6.0),
            height: 200.0,
            width: 200.0,
            child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  decoration:
                  BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
                  height: 200.0,
                  width: 200.0,
                  child: const Center(
                      child: SizedBox(
                          height: 60, width: 60, child: CircularProgressIndicator(color: Colors.white))),
                ),
                errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error, size: 30.0, color: Colors.white)),
                fit: BoxFit.cover,
                imageUrl: photo ?? '',
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: 200.0,
                    width: 200.0,
                    decoration: BoxDecoration(image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
                  );
                })),
        onTap: () {
          modal();
        });
  }

  Widget showView(BuildContext context) {
    if (widget.messageType == ChatMessageType.text) {
      return _textMessage(context);
    } else if (widget.messageType == ChatMessageType.photo) {
      return _photoMessage(widget.message);
    } else {
      return Container();
    }
  }

  Future modal() {
    return Get.bottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: Colors.white12,
      BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 6, sigmaX: 6),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: Container(
            height: Get.height * 0.9,
            decoration: BoxDecoration(color: AppColors.kWhiteColor),
            width: double.infinity,
            child: Stack(
              children: [
                Center(
                  child: CachedNetworkImage(
                    placeholder: (context, url) => const Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(color: Colors.white))),
                    errorWidget: (context, url, error) =>
                    const Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(color: Colors.white))),
                    fit: BoxFit.cover,
                    imageUrl: widget.message ?? '',
                    imageBuilder: (context, imageProvider) {
                      return PhotoView(
                        imageProvider: imageProvider,
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
