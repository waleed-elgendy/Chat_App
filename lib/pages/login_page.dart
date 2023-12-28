// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/shared_widgets/button.dart';
import 'package:chat_app/shared_widgets/constants.dart';
import 'package:chat_app/shared_widgets/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

CollectionReference allUsers =
    FirebaseFirestore.instance.collection('allUsers');

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool passobscure = true, isLoading = false;
  String? email, pass;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(color: primaryColor),
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 60.h,
                    ),
                    child: Image.asset(
                      "assets/logo.png",
                      width: 150.w,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Chattify",
                    style: TextStyle(
                        color: const Color(0xfffeb200), fontSize: 50.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 25.h, top: 80.h),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        color: const Color(0xffC7EDE6), fontSize: 30.sp),
                  ),
                ),
                CustomTextFormField(
                  validate: (data) {
                    if (data!.isEmpty) return "field is required";
                    return null;
                  },
                  onchange: (data) {
                    email = data;
                  },
                  keyboardType: TextInputType.emailAddress,
                  obscure: false,
                  hint: "Enter your E-mail",
                  label: SizedBox(
                    width: 105.w,
                    child: Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                          size: 30.dm,
                        ),
                        Text(
                          "  E-mail",
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.sp),
                        )
                      ],
                    ),
                  ),
                ),
                CustomTextFormField(
                  validate: (data) {
                    if (data!.isEmpty) {
                      return "field is required";
                    }
                    return null;
                  },
                  onchange: (data) {
                    pass = data;
                  },
                  hint: "Enter your Password",
                  keyboardType: TextInputType.visiblePassword,
                  label: SizedBox(
                    width: 135.w,
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 30.dm,
                        ),
                        Text(
                          "  Password",
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.sp),
                        )
                      ],
                    ),
                  ),
                  obscure: passobscure,
                  suffix: InkWell(
                    highlightColor: const Color(0xff2B475E),
                    splashColor: const Color(0xff2B475E),
                    child: Icon(
                      passobscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      setState(() {
                        passobscure = !passobscure;
                      });
                    },
                  ),
                ),
                CustomButton(
                    text: "Login",
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await loginUser();
                          var user = await allUsers.doc(email).get();
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage(
                                email: email!,
                                groupBack: false,
                                profilePhoto: user['profilePhoto']);
                          }), (route) => false);
                        } catch (e) {
                          showSnackBar(
                              context,
                              "check email or password and try again",
                              "Login failed",
                              ContentType.failure);
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 15.sp),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        " Register",
                        style: TextStyle(
                            color: const Color(0xffC7EDE6), fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: pass!);
    var token =  await FirebaseAuth.instance.currentUser!.getIdToken();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token.toString());
    await prefs.setString('email', email!);
    var userx = await allUsers.doc(email).get();
    await prefs.setString('profilePhoto', userx['profilePhoto']);

  }
}
