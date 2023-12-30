// ignore_for_file: must_be_immutable

import 'package:chat_app/models/all_users_model.dart';
import 'package:chat_app/shared_widgets/chats_list_view.dart';
import 'package:chat_app/shared_widgets/constants.dart';
import 'package:chat_app/shared_widgets/search_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllUsers extends StatelessWidget {
  AllUsers({Key? key, required this.email}) : super(key: key);
  final String email;
  CollectionReference allUsers =
      FirebaseFirestore.instance.collection('allUsers');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: allUsers.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<AllUsersModel> allUsersList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            if (snapshot.data!.docs[i]['email'] != email) {
              allUsersList.add(
                AllUsersModel.fromJson(snapshot.data!.docs[i]),
              );
            }
          }
          if (allUsersList.isEmpty) {
            return Scaffold(
              body: Padding(
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
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(height: 320.h, child: Image.asset("assets/img.jpg")),
                    Text(
                      "No users found",
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Padding(
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
                    ChatsListView(
                      subTitle: null,
                      trailing: const Icon(Icons.group_add_rounded),
                      allUsersList: allUsersList,
                      email: email,
                      addNew: true,
                      chatsPage: false,
                    ),
                  ],
                ),
              ),
            );
          }
        } else {
          return Scaffold(
            body: Padding(
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
            ),
          );
        }
      },
    );
  }
}
