// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/shared_widgets/chatBuble.dart';
import 'package:chat_app/shared_widgets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupChatPage extends StatelessWidget {
  GroupChatPage({super.key, required this.email, required this.profilePhoto});

  GlobalKey<FormState> formKey = GlobalKey();
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  CollectionReference allUsers =
      FirebaseFirestore.instance.collection('allUsers');
  TextEditingController controller = TextEditingController();
  final scrollController = ScrollController();
  final String email,profilePhoto;
  String message = '';

  @override
  Widget build(BuildContext context) {
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
        stream: messages.orderBy('time', descending: true).snapshots(),
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
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) {
                          return HomePage(
                            email: email,
                            groupBack: true,
                            profilePhoto: profilePhoto,
                          );
                        },
                      ), (route) => false);
                    },
                    color: Colors.white),
                title: const Text("Group Chat",
                    style: TextStyle(color: Colors.white)),
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
                            isGroup: true,
                                  message: messagesList[index],
                                )
                              : ChatBubble(
                            isGroup: true,
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
                              onPressed: () async {
                                if (message != '') {
                                  var user = await allUsers.doc(email).get();
                                  messages.add({
                                    'message': message,
                                    'time': DateTime.now(),
                                    'id': email,
                                    'username': user['username'],
                                    'profilePhoto': user['profilePhoto'],
                                  });
                                }
                                message = '';
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
                automaticallyImplyLeading: false,
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      width: 62.w,
                    ),
                    const Text("Group Chat",
                        style: TextStyle(color: Colors.white)),
                  ],
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
