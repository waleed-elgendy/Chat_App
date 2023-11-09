import 'package:chat_app/models/messageModel.dart';
import 'package:chat_app/shared_widgets/chatBuble.dart';
import 'package:chat_app/shared_widgets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.email});
  GlobalKey<FormState> formKey = GlobalKey();
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  TextEditingController controller = TextEditingController();
  final controler = ScrollController();

  final String email;
  String message = '';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(
              Message.fromJson(snapshot.data!.docs[i]),
            );
          }
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
                  const Text("Chat", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            body: Column(
              children: [
                Form(
                  key: formKey,
                  child: Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: controler,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? ChatBubble(
                                messageText: messagesList[index],
                              )
                            : ChatBubbleFromOthers(
                                messageText: messagesList[index]);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.dm),
                  child: TextFormField(
                    validator: (data) {
                      if (data!.isEmpty) {
                        return "field is required";
                      }
                    },
                    controller: controller,
                    onChanged: (value) {
                      message = value;
                    },
                    onFieldSubmitted: (value) {
                      if (!formKey.currentState!.validate()) {
                        messages.add({
                          'messages': value,
                          'createdAt': DateTime.now(),
                          'id': email,
                        });
                        controller.clear();
                        controler.animateTo(
                          0,
                          curve: Curves.fastEaseInToSlowEaseOut,
                          duration: const Duration(milliseconds: 500),
                        );
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Send Message",
                        /*border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: primaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),*/
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
                            onPressed: () {
                              if (message != '') {
                                messages.add({
                                  'messages': message,
                                  'createdAt': DateTime.now(),
                                  'id': email,
                                });
                              }
                              message = '';
                              controller.clear();
                              controler.animateTo(
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
                  const Text("Chat", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
