import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right:  12.w),
      height: 45.h,
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          filled: true,
          fillColor: const Color(0xffEFF1F8),
          hintStyle:  TextStyle(fontSize: 15.sp),
          prefixIcon: const Icon(Icons.search_outlined),
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24.r)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xffEFF1F8),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(24.r),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xffEFF1F8),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(24.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xffEFF1F8),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
      ),
    );
  }
}
