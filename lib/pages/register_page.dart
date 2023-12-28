// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/profile_image.dart';
import 'package:chat_app/shared_widgets/button.dart';
import 'package:chat_app/shared_widgets/constants.dart';
import 'package:chat_app/shared_widgets/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool passobsure = true, isLoading = false;
  String? email, pass, userName;
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
                  padding: EdgeInsets.only(bottom: 15.h, top: 20.h),
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                        color: const Color(0xffC7EDE6), fontSize: 30.sp),
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
                    userName = data;
                  },
                  obscure: false,
                  keyboardType: TextInputType.text,
                  hint: "Enter your Username",
                  label: SizedBox(
                    width: 140.w,
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_2_outlined,
                          color: Colors.white,
                          size: 30.dm,
                        ),
                        Text(
                          "  Username",
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
                    email = data;
                  },
                  obscure: false,
                  keyboardType: TextInputType.emailAddress,
                  hint: "Enter your E-mail",
                  label: SizedBox(
                    width: 104.w,
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
                  obscure: passobsure,
                  suffix: InkWell(
                    highlightColor: const Color(0xff2B475E),
                    splashColor: const Color(0xff2B475E),
                    child: Icon(
                      passobsure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      setState(() {
                        passobsure = !passobsure;
                      });
                    },
                  ),
                ),
                CustomButton(
                    text: "Register",
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await registerUser();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileImage(
                                    email: email!, userName: userName!),
                              ));
                        } catch (e) {
                          if (e.toString().length == 92) {
                            showSnackBar(context, e.toString().substring(36),
                                "Registration failed", ContentType.failure);
                          } else if (e.toString().length == 130) {
                            showSnackBar(context, "check your network",
                                "Registration failed", ContentType.failure);
                          } else {
                            showSnackBar(context, e.toString().substring(30),
                                "Registration failed", ContentType.failure);
                          }
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
                      "Already have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 15.sp),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        " Login",
                        style: TextStyle(
                            color: const Color(0xffC7EDE6), fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 35.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: pass!);
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.doc(email).set({
      'email': email,
      "username": userName,
      "profilePhoto":
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
    });
    CollectionReference allUsers =
        FirebaseFirestore.instance.collection("allUsers");
    await allUsers.doc(email).set({
      'email': email,
      "username": userName,
      "profilePhoto":
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
    });
  }
}
