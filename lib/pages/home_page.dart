// ignore_for_file: use_build_context_synchronously, must_be_immutable


import 'package:chat_app/pages/all_users_page.dart';
import 'package:chat_app/pages/group_chat_page.dart';
import 'package:chat_app/pages/chats_list_page.dart';
import 'package:chat_app/pages/friends_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/shared_widgets/bottom_nav_bar.dart';
import 'package:chat_app/shared_widgets/constants.dart';
import 'package:chat_app/shared_widgets/floating_action_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.email, required this.groupBack, required this.profilePhoto})
      : super(key: key);
  final String email,profilePhoto;
  bool groupBack;

  @override
  State<HomePage> createState() => _HomePageState();
}

int selectIndex = 0;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    if (widget.groupBack) {
      selectIndex = 0;
      widget.groupBack = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
       ChatsPage(profilePhoto: widget.profilePhoto,email: widget.email),
       FriendsPage(email: widget.email),
      GroupChatPage(email: widget.email,profilePhoto: widget.profilePhoto),
    ];
    return Scaffold(
      endDrawer: Drawer(
        width: 270.w,
      child: Column(
        children: [
           DrawerHeader(
            child: Column(
              children: [
                SizedBox(height: 30.h,),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(widget.profilePhoto),
                    radius: 24.r,
                  ),
                  title: Text(widget.email,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(
                    color: primaryColor,fontSize: 17.sp
                  )),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              await SharedPreferences.getInstance().then((sharedPrefValue) {
                sharedPrefValue.remove('token');
              });
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                      (route) => false);
            },
            child: const ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.logout_sharp),
            ),
          ),
        ],
      ),
      ),
      floatingActionButton: selectIndex == 2
          ? null
          : FloatingButton(
              icon: selectIndex == 0
                  ? const Icon(Icons.edit_outlined)
                  : const Icon(Icons.add),
              onTap: selectIndex == 0
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  Material(
                              child: FriendsPage(email:widget.email,),
                            ),
                          ));
                    }
                  : () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Material(
                              child: AllUsers(
                                email: widget.email,
                              ),
                            ),
                          ));
                    }),
      bottomNavigationBar: selectIndex == 2
          ? null
          : BottomNavBar(
              selectIndex: selectIndex,
              onTap: (index) {
                setState(() {
                  selectIndex = index;
                });
              }),
      body: pages[selectIndex],
    );
  }
  /*Future<String> getUserPhoto() async {
    var doc= await FirebaseFirestore.instance.collection('allUsers').doc(widget.email).get();
    AllUsersModel user=AllUsersModel.fromJson(doc);
    String profilePhoto=user.profilePhoto;
    print("555$profilePhoto");
    return profilePhoto;
  }*/
}


