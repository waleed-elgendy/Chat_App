// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/shared_widgets/chatBuble.dart';
import 'package:chat_app/shared_widgets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class UserChatPage extends StatelessWidget {
  UserChatPage({Key? key, required this.email, required this.friend})
      : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey();
  CollectionReference allUsers =
      FirebaseFirestore.instance.collection('allUsers');
  TextEditingController controller = TextEditingController();
  final scrollController = ScrollController();
  final String email;
  var friend;
  String message = '';

  @override
  Widget build(BuildContext context) {
    CollectionReference chatMessages = FirebaseFirestore.instance
        .collection('users/$email/chats/${friend.email}/chatMessages');
    CollectionReference chatsUser =
        FirebaseFirestore.instance.collection('users/$email/chats');
    return PopScope(
      canPop: false,
      onPopInvoked: (x) async {
        var user = await allUsers.doc(email).get();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return HomePage(
              email: email,
              groupBack: true,
              profilePhoto: user['profilePhoto'],
            );
          },
        ), (route) => false);
      },
      child: StreamBuilder<QuerySnapshot>(
        stream: chatMessages.orderBy('time', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(
                MessageModel.fromJson(snapshot.data!.docs[i]),
              );
            }
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                backgroundColor: primaryColor,
                leadingWidth: 65.w,
                leading: GestureDetector(
                  onTap: () async {
                    var user = await allUsers.doc(email).get();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return HomePage(
                          email: email,
                          groupBack: true,
                          profilePhoto: user['profilePhoto'],
                        );
                      },
                    ), (route) => false);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back, color: Colors.white),
                        CircleAvatar(
                          radius: 16.r,
                          backgroundImage: NetworkImage(friend.profilePhoto),
                        ),
                      ],
                    ),
                  ),
                ),
                title: Padding(
                  padding: EdgeInsets.only(left: 5.h),
                  child: Text(friend.username,
                      style: TextStyle(color: Colors.white, fontSize: 20.sp)),
                ),
              ),
              body: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: scrollController,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return messagesList[index].id != email
                              ? ChatBubbleFromOthers(
                            isGroup: false,
                                  message: messagesList[index],
                                )
                              : ChatBubble(
                            isGroup: false,
                                  message: messagesList[index]);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.dm),
                    child: TextFormField(
                      textInputAction: TextInputAction.newline,
                      maxLines: null,
                      validator: (data) {
                        if (data!.isEmpty) {
                          return "field is required";
                        }
                        return null;
                      },
                      controller: controller,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: InputDecoration(
                          hintText: "Send Message",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: primaryColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20.dm),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: primaryColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20.dm),
                          ),
                          suffixIcon: IconButton(
                              onPressed: ()  {
                                if (message != '') {
                                   chatMessages.add({
                                    'message': message,
                                    'time': DateTime.now(),
                                    'id': email,
                                    "profilePhoto": "",
                                    "username": "",
                                  });
                                   chatsUser.doc(friend.email).set({
                                    "username": friend.username,
                                    "profilePhoto": friend.profilePhoto,
                                    "lastMessage":message,
                                    "time":DateTime.now().toString(),
                                    "email":friend.email
                                  });
                                }
                                message = '';
                                controller.clear();
                                controller.clear();
                                scrollController.animateTo(
                                  0,
                                  curve: Curves.fastEaseInToSlowEaseOut,
                                  duration: const Duration(milliseconds: 500),
                                );
                              },
                              icon: const Icon(
                                Icons.send,
                                color: primaryColor,
                              ))),
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                backgroundColor: primaryColor,
                leadingWidth: 65.w,
                leading: GestureDetector(
                  onTap: () async {
                    var user = await allUsers.doc(email).get();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return HomePage(
                          email: email,
                          groupBack: true,
                          profilePhoto: user['profilePhoto'],
                        );
                      },
                    ), (route) => false);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back, color: Colors.white),
                        CircleAvatar(
                          radius: 16.r,
                          backgroundImage: NetworkImage(friend.profilePhoto),
                        ),
                      ],
                    ),
                  ),
                ),
                title: Padding(
                  padding: EdgeInsets.only(left: 5.h),
                  child: Text(friend.username,
                      style: TextStyle(color: Colors.white, fontSize: 20.sp)),
                ),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
