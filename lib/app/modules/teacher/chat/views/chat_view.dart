import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_lecture/app/shared/utils/colors.dart';
import 'package:uni_lecture/app/shared/widgets/back_button.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/chat_bubble.dart';
import '../../course_students/controllers/course_students_controller.dart';
import '../controllers/chat_controller.dart';

class TeacherChatView extends GetView<TeacherChatController> {
  const TeacherChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        backButton(),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                            onTap: () async {
                              //
                            },
                            child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    controller.courseDetails?.imageUrl == null
                                        ? CircleAvatar(
                                            radius: 20.0,
                                            backgroundColor: AppColors.kPrimaryColor,
                                            child:
                                                const Center(child: Icon(Icons.image, size: 30.0, color: Colors.white)),
                                          )
                                        : CachedNetworkImage(
                                            placeholder: (context, url) => Center(
                                                child: SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: CircularProgressIndicator(color: AppColors.kPrimaryColor))),
                                            errorWidget: (context, url, error) => CircleAvatar(
                                              radius: 20.0,
                                              backgroundColor: AppColors.kPrimaryColor,
                                              child: const Center(
                                                  child: Icon(Icons.person_outlined, size: 30.0, color: Colors.white)),
                                            ),
                                            fit: BoxFit.cover,
                                            imageUrl: controller.courseDetails?.imageUrl ?? '',
                                            imageBuilder: (context, imageProvider) {
                                              return CircleAvatar(
                                                radius: 20.0,
                                                backgroundImage: imageProvider,
                                              );
                                            },
                                          ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.4,
                                          child: Text(
                                            controller.courseDetails?.name ?? '',
                                            style: const TextStyle(
                                              color: Color(0xFF1D2939),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          controller.courseDetails?.teacherName ?? '',
                                          style: const TextStyle(
                                            color: Color(0xFF667085),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: controller.courseDetails?.id ?? '')).then(
                                  (value) => Fluttertoast.showToast(
                                msg: "Course link copied!",
                                backgroundColor: AppColors.kPrimaryColor,
                                // textColor: MyColors.white,
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(2.0),
                            child: const Icon(
                              Icons.share,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        GestureDetector(
                          onTap: () {
                           //
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(2.0),
                            child: const Icon(
                              Icons.schedule,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.TEACHERCOURSESTUDENTS);
                            final courseStudentsController = Get.put(TeacherCourseStudentsController());
                            courseStudentsController.updateCourseDetails(controller.courseDetails);
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(2.0),
                            child: const Icon(
                              Icons.more_vert,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Divider(
                color: Colors.grey.withOpacity(0.1),
                height: 1,
              ),
              const SizedBox(
                height: 4,
              ),
              Expanded(
                child: controller.isLoading.value
                    ? Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: AppColors.kPrimaryColor,
                            strokeWidth: 3,
                          ),
                        ),
                      )
                    : controller.messages.isNotEmpty
                        ? Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.all(8),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: AppColors.kPrimaryColor.withOpacity(0.01),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              reverse: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.messages.length,
                              controller: controller.scrollController,
                              itemBuilder: (BuildContext context, int index) {
                                dynamic messages = controller.messages[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: messages['senderType'] == 'TEACHER' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        messages['senderType'] == 'TEACHER' ? MainAxisAlignment.end : MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          messages['senderImageUrl'] == null
                                              ? CircleAvatar(
                                            radius: 14.0,
                                            backgroundColor: AppColors.kPrimaryColor,
                                            child: const Center(
                                                child: Icon(Icons.image, size: 30.0, color: Colors.white)),
                                          )
                                              : CachedNetworkImage(
                                            placeholder: (context, url) => Center(
                                                child: SizedBox(
                                                    height: 14,
                                                    width: 14,
                                                    child:
                                                    CircularProgressIndicator(color: AppColors.kPrimaryColor))),
                                            errorWidget: (context, url, error) => CircleAvatar(
                                              radius: 14.0,
                                              backgroundColor: AppColors.kPrimaryColor,
                                              child: const Center(
                                                  child:
                                                  Icon(Icons.person_outlined, size: 30.0, color: Colors.white)),
                                            ),
                                            fit: BoxFit.cover,
                                            imageUrl: messages['senderImageUrl'],
                                            imageBuilder: (context, imageProvider) {
                                              return CircleAvatar(
                                                radius: 14.0,
                                                backgroundImage: imageProvider,
                                              );
                                            },
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ConstrainedBox(
                                                constraints: BoxConstraints(maxWidth: Get.width * 0.4),
                                                child: Text(
                                                  messages['senderName'],
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Color(0xFF667085),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                messages['senderType'] == 'TEACHER' ? 'Teacher' : 'Student',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Color(0xFF667085),
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      ChatBubble(
                                        messageType: messages['type'] == 'text' ? ChatMessageType.text : ChatMessageType.photo,
                                        sender: messages['senderType'] == 'TEACHER' ? MessageSender.me : MessageSender.boss,
                                        message: messages['message'],
                                        time: messages['time'],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(
                            width: Get.width,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.all(16),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/no_messages.png',
                                  height: 100,
                                  width: 150,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'No messages',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF1D2939),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Text(
                                  'Send a message to start a conversation',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF98A1B2),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF2F4F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        onTap: () {
                          controller.showEmojiPicker.value = false;
                        },
                        textInputAction: TextInputAction.newline,
                        minLines: 1,
                        maxLines: 4,
                        controller: controller.text,
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(2.0),
                          hintText: controller.messageHintText.value,
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400),
                          border: InputBorder.none,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    await ImagePicker()
                                        .pickImage(source: ImageSource.gallery, imageQuality: 20)
                                        .then((value) async {
                                      if (value != null) {
                                        String? url = await controller.uploadImage(value.path);
                                        if (url != null) {
                                          Map<String, dynamic> message =
                                          controller.messageData(type: 'image', message: url);
                                           await controller.sendMessage(message);
                                        }
                                      }
                                    });
                                  },
                                  child: Container(
                                      color: Colors.transparent,
                                      padding: const EdgeInsets.all(2),
                                      child: SvgPicture.asset(
                                        'assets/icons/link.svg',
                                        height: 18,
                                      ))),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.showEmojiPicker.value = !controller.showEmojiPicker.value;
                                },
                                child: Container(
                                    color: Colors.transparent,
                                    padding: const EdgeInsets.all(2),
                                    child: SvgPicture.asset(
                                      'assets/icons/emoji.svg',
                                      height: 18,
                                    )),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (controller.text.text.trim() != '') {
                                Map<String, dynamic> message = controller.messageData(type: 'text', message: controller.text.text.trim());
                                FocusScope.of(context).unfocus();
                                await controller.sendMessage(message);
                                controller.text.clear();
                                if (controller.chatBoxHeight.value != Get.height - 175 - 250) {
                                  controller.chatBoxHeight.value -= 250.0;
                                } else {
                                  controller.chatBoxHeight.value += 250.0;
                                }
                                controller.showEmojiPicker.value = false;
                              }
                            },
                            child: controller.sendingMessage.value
                                ? Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: AppColors.kPrimaryColor,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                : Container(
                                    color: Colors.transparent,
                                    padding: const EdgeInsets.all(2),
                                    child: SvgPicture.asset(
                                      'assets/icons/send.svg',
                                      height: 18,
                                    )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              controller.showEmojiPicker.value ? _showEmoji() : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget _showEmoji() {
    FocusScope.of(Get.context!).unfocus();
    final controller = Get.put(TeacherChatController());
    return SizedBox(
      height: 250,
      width: Get.width,
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          controller.text.text += emoji.emoji;
        },
        onBackspacePressed: () {},
        config: const Config(
            columns: 7,
            emojiSizeMax: 28.0,
            verticalSpacing: 0,
            horizontalSpacing: 0.0,
            initCategory: Category.RECENT,
            recentsLimit: 28,
            categoryIcons: CategoryIcons(),
            buttonMode: ButtonMode.MATERIAL),
      ),
    );
  }
}
