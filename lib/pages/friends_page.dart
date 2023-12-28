import 'package:chat_app/models/all_users_model.dart';
import 'package:chat_app/shared_widgets/chats_list_view.dart';
import 'package:chat_app/shared_widgets/constants.dart';
import 'package:chat_app/shared_widgets/search_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  Widget build(BuildContext context) {
    CollectionReference friends =
        FirebaseFirestore.instance.collection('users/$email/friends');
    return StreamBuilder(
      stream: friends.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<AllUsersModel> friendsList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            friendsList.add(AllUsersModel.fromJson(snapshot.data!.docs[i]));
          }
          if (friendsList.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Text("Friends",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.w, bottom: 20.h),
                    child: const SearchField(),
                  ),
                  SizedBox(height: 20.h),

                  SizedBox(
                      height: 320.h, child: Image.asset("assets/friends.png")),
                  Text(
                    "   your friends list is empty\n          add friends now",
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
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Text("Friends",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.w, bottom: 20.h),
                    child: const SearchField(),
                  ),
                  ChatsListView(
                    subTitle: null,
                    trailing: null,
                    email: email,
                    allUsersList: friendsList,
                    addNew: false,
                    chatsPage: false,
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
