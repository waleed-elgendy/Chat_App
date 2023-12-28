import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/shared_widgets/chats_list_view.dart';
import 'package:chat_app/shared_widgets/constants.dart';
import 'package:chat_app/shared_widgets/search_bar.dart';
import 'package:chat_app/shared_widgets/search_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key, required this.profilePhoto, required this.email})
      : super(key: key);
  final String profilePhoto;
  final String email;
  @override
  build(BuildContext context) {
    CollectionReference chats =
        FirebaseFirestore.instance.collection('users/$email/chats');
    return StreamBuilder(
      stream: chats.orderBy('time',descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ChatModel> chatsList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            chatsList.add(ChatModel.fromJson(snapshot.data!.docs[i]));
          }
          if (chatsList.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomSearchBar(profilePhoto: profilePhoto,),
                  SizedBox(height: 80.h),
                  SizedBox(
                      height: 320.h, child: Image.asset("assets/img2.png")),
                  Text(
                    "Start Chatting Now",
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.sp),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSearchBar(profilePhoto: profilePhoto,),
                  ChatsListView(
                    subTitle: null,
                    trailing: null,
                    email: email,
                    allUsersList: chatsList,
                    addNew: false,
                    chatsPage: true,
                  ),
                ],
              ),
            );
          }
        } else {
          return Padding(
            padding: EdgeInsets.only(top: 63.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back))),
                      const Expanded(flex: 8, child: SearchField()),
                    ],
                  ),
                ),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
