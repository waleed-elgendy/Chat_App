import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, String title,
    ContentType contentType) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 0,
      behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType,
    ),
  ));
}
