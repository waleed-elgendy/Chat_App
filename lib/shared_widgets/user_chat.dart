import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserChat extends StatelessWidget {
  const UserChat({
    super.key,
    required this.subTitle,
    required this.trailing, required this.username, required this.profilePhoto,
  });

  final Widget? subTitle, trailing;
  final String username, profilePhoto;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30.dm,
          backgroundImage: NetworkImage(profilePhoto),
        ),
        title: Text(username),
        subtitle: subTitle,
        trailing: trailing,
      ),
    );
  }
}
