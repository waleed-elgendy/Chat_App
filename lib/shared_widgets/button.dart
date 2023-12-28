import 'package:chat_app/shared_widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      this.onTap,
       this.conColor=Colors.white,
       this.textColor=primaryColor})
      : super(key: key);
  final String text;
  final VoidCallback? onTap;
  final Color conColor, textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:
            EdgeInsets.only(top: 50.h, left: 100.w, right: 100.w, bottom: 15.w),
        child: Container(
          decoration: BoxDecoration(
            color: conColor,
            borderRadius: BorderRadius.circular(18.dm),
          ),
          width: double.infinity,
          height: 50.h,
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 30.sp),
            ),
          ),
        ),
      ),
    );
  }
}
