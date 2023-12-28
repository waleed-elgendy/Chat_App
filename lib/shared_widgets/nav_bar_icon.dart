import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class NavBarIcon extends StatelessWidget {
  const NavBarIcon({
    super.key, required this.icon, required this.index, required this.selectIndex,
  });
  final IconData icon;
  final int index,selectIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60.w,
        height: 35.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: selectIndex == index
                ? const Color(0xffD3E4FF)
                : const Color(0xffF3F4F9)),
        child:  Icon(icon));
  }
}