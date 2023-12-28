import 'package:chat_app/shared_widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key, required this.profilePhoto,
  });
 final String profilePhoto;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 12.h,horizontal: 12.w),
      child: Row(
        children: [
          const Expanded(
            flex: 6,
            child: SearchField(),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: (){
                Scaffold.of(context).openEndDrawer();
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(profilePhoto),
                radius: 24.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
