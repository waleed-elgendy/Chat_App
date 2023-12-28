import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key, required this.icon,required this.onTap,
  });
  final Icon icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56.w,
      height: 56.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.dm)),
          color: const Color(0xffD3E4FF),
          shape: BoxShape.rectangle),
      child:  IconButton(icon:icon,onPressed: onTap, color: const Color(0xff001C38)),
    );
  }
}
