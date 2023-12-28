import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/shared_widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubbleFromOthers extends StatelessWidget {
  const ChatBubbleFromOthers({
    super.key,
    required this.message, required this.isGroup,
  });
  final MessageModel message;
  final bool isGroup;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          isGroup?Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: CircleAvatar(
              backgroundImage: NetworkImage(message.profilePhoto),
              radius: 15.r,
            ),
          ):const SizedBox(),
          Flexible(
            child: Container(
              margin:
                  EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h, top: 15.h),
              decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.dm),
                    topRight: Radius.circular(32.dm),
                    bottomRight: Radius.circular(32.dm),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15.w, top: 15.h, bottom: 8.h, right: 15.w),
                    child: Text(
                      message.messageText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  isGroup?Padding(
                    padding: EdgeInsets.only(left: 5.w, bottom: 8.h, right: 18.w),
                    child: Text(
                      message.username,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                      ),
                    ),
                  ):const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message, required this.isGroup,
  });
  final MessageModel message;
  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              margin:
              EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h, top: 15.h),
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                    bottomLeft: Radius.circular(32),
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15.w, top: 15.h, bottom: 4.h, right: 15.w),
                    child: Text(
                      maxLines: null,
                      message.messageText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  isGroup?Padding(
                    padding:  EdgeInsets.only(right: 5.w, bottom: 8.h, left: 18.w),
                    child: Text(
                      message.username,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ):const SizedBox(),
                ],
              ),
            ),
          ),
         isGroup? Padding(
            padding: EdgeInsets.only(right: 5.w),
            child: CircleAvatar(
              backgroundImage: NetworkImage(message.profilePhoto),
              radius: 15.r,
            ),
          ):const SizedBox(),
        ],
      ),
    );
  }
}
