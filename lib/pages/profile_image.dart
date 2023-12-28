// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/shared_widgets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key, required this.email, required this.userName})
      : super(key: key);
  final String email, userName;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? image;
  Future pickImage(ImageSource imageSource) async {
    try {
      final imageTemporary = await ImagePicker().pickImage(source: imageSource);
      if (imageTemporary == null) return;
      setState(() {
        image = File(imageTemporary.path);
      });
    } on PlatformException catch (e) {
      log('Failed to pick image : $e');
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    String profilePhotoUrl = '';
    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(color: primaryColor),
      inAsyncCall: isLoading,
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Pick Profile Picture",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    fontSize: 26.sp,
                  ),
                ),
                subtitle: Text(
                  "Have a favorite selfie?  Upload it Now.",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 120.w),
              child: GestureDetector(
                onTap: () async {
                  var status = await Permission.storage.status;
                  if (status.isDenied) {
                    // You can request multiple permissions at once.
                    await [
                      Permission.storage,
                      Permission.camera,
                    ].request();
                  }
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27),
                            ),
                            content: StatefulBuilder(
                              builder: (context, setState) {
                                return SizedBox(
                                  //color: Colors.white,
                                  height: 120.h,
                                  width: 100.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await pickImage(ImageSource.gallery);
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.photo,
                                              size: 35.r,
                                              color: primaryColor,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              "Choose from gallery",
                                              style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 18.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                      InkWell(
                                        onTap: () async {
                                          await pickImage(ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.camera_alt,
                                              size: 35.sp,
                                              color: primaryColor,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              "Take Photo",
                                              style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 18.sp),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ));
                      });
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(22.r),
                  dashPattern: [10.h.w],
                  color: primaryColor,
                  strokeWidth: 2.w.h,
                  child: image != null
                      ? Container(
                          height: 168,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(image!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(
                                (22.r),
                              )),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(40),
                          child: Icon(
                            Icons.camera_alt,
                            size: 85.r,
                            color: primaryColor,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 400.h),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) {
                          return const LoginPage();
                        },
                      ), (route) => false);
                      showSnackBar(
                          context,
                          "Registration Success you can Login Now",
                          "success",
                          ContentType.success);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffC7EDE6), width: 1.5.w),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26.r),
                        ),
                        width: double.infinity,
                        height: 50.h,
                        child: Center(
                          child: Text(
                            "Skip for now",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 19.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 80.h),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if (image == null) {
                        showSnackBar(context, "please choose an image",
                            "failed", ContentType.failure);
                        return;
                      } else {
                        Reference referenceImageToUpload = FirebaseStorage
                            .instance
                            .ref()
                            .child('Users Profile Photos')
                            .child(widget.email);
                        try {
                          await referenceImageToUpload
                              .putFile(File(image!.path));
                          profilePhotoUrl =
                              await referenceImageToUpload.getDownloadURL();
                          CollectionReference users =
                              FirebaseFirestore.instance.collection("users");
                          await users.doc(widget.email).set({
                            'email': widget.email,
                            "username": widget.userName,
                            "profilePhoto": profilePhotoUrl,
                          });
                          CollectionReference allUsers =
                              FirebaseFirestore.instance.collection("allUsers");
                          await allUsers.doc(widget.email).set({
                            'email': widget.email,
                            "username": widget.userName,
                            "profilePhoto": profilePhotoUrl
                          });
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                            builder: (context) {
                              return HomePage(
                                  email: widget.email,
                                  groupBack: false,
                                  profilePhoto: profilePhotoUrl);
                            },
                          ), (route) => false);
                          showSnackBar(
                              context,
                              "Registration Success start chat now",
                              "success",
                              ContentType.success);
                        } catch (e) {
                          showSnackBar(context, "try again",
                              "Registration failed", ContentType.success);
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w, left: 22.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(26.r),
                        ),
                        height: 50.h,
                        child: Center(
                          child: Text(
                            "ok",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
