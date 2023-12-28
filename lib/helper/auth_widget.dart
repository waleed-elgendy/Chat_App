import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  String? token,email,profilePhoto;
  bool initial = true;
  @override
  Widget build(BuildContext context) {
    if (initial) {
      SharedPreferences.getInstance().then((sharedPrefValue) {
        setState(() {
          initial = false;
          token = sharedPrefValue.getString('token');
          email = sharedPrefValue.getString('email');
          profilePhoto = sharedPrefValue.getString('profilePhoto');
        });
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      if (token == null) {
        return const LoginPage();
      }else {
        return HomePage(email: email!,profilePhoto: profilePhoto!,groupBack: false,);
      }
    }
  }
}