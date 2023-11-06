import 'package:chat_app/shared_widgets/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.text,  this.ontap}) : super(key: key);
  final String text;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 100, right: 100, bottom: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          width: double.infinity,
          height: 50,
          child:  Center(
            child: Text(
              text,
              style: const TextStyle(color: primaryColor, fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
