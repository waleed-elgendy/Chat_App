import 'package:chat_app/shared_widgets/nav_bar_icon.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatelessWidget {
   BottomNavBar({Key? key,required this.selectIndex,required this.onTap}) : super(key: key);
  int selectIndex;
   void Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        currentIndex: selectIndex,
        enableFeedback: false,
        onTap: onTap,
        backgroundColor: const Color(0xffF3F4F9),
        selectedItemColor: const Color(0xff001C38),
        items: [
          BottomNavigationBarItem(
            icon: NavBarIcon(
                icon: Icons.home_filled, index: 0, selectIndex: selectIndex),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: NavBarIcon(
                icon: Icons.group_outlined,
                index: 1,
                selectIndex: selectIndex),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: NavBarIcon(
                icon: Icons.groups, index: 2, selectIndex: selectIndex),
            label: 'Group',
          ),
        ],
      ),
    );
  }
}
