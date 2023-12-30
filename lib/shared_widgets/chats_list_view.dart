// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/user_chat_page.dart';
import 'package:chat_app/shared_widgets/user_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatsListView extends StatelessWidget {
   ChatsListView({
    super.key,
    required this.subTitle,
    required this.trailing,
    required this.allUsersList,
    required this.email, required this.addNew, required this.chatsPage,
  });
  final Widget? subTitle, trailing;
  var allUsersList;
  final String email;
  final bool addNew,chatsPage;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: allUsersList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              if(addNew){
                CollectionReference friends =
                FirebaseFirestore.instance.collection("users/$email/friends");
                await friends.doc(allUsersList[index].email).set({
                  'email': allUsersList[index].email,
                  "username": allUsersList[index].username,
                  "profilePhoto": allUsersList[index].profilePhoto,
                });
                CollectionReference friendsX =
                FirebaseFirestore.instance.collection("users/${allUsersList[index].email}/friends");
                CollectionReference allUsers =
                FirebaseFirestore.instance.collection('allUsers');
                var userX = await allUsers.doc(email).get();
                await friendsX.doc(email).set({
                  'email': email,
                  "username": userX['username'],
                  "profilePhoto": userX['profilePhoto'],
                });
                Navigator.pop(context);
                showSnackBar(
                    context,
                    "${allUsersList[index].username} added to your friends",
                    "Success",
                    ContentType.success);
              }else {
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                 return UserChatPage(email: email, friend: allUsersList[index]);
               },));
              }
            },
            child: chatsPage?UserChat(
              subTitle: Text(allUsersList[index].lastMessage),
              trailing: Text(allUsersList[index].time.toString().substring(0,10)),
              username: allUsersList[index].username,
              profilePhoto: allUsersList[index].profilePhoto,
            ):UserChat(
              subTitle: subTitle,
              trailing: trailing,
              username: allUsersList[index].username,
              profilePhoto: allUsersList[index].profilePhoto,
            ),
          );
        },
      ),
    );
  }
}
