import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({Key? key, required this.hint, required this.label,this.suffix,  required this.obscure, this.onchange, this.validate, required this.keyboardType}) : super(key: key);
  final String hint;
  final Widget? label,suffix;
  final bool obscure;
  final Function(String)? onchange ;
  final String? Function(String?)? validate;
  final TextInputType keyboardType;


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.h),
      child: TextFormField(
        validator: validate,
        onChanged: onchange,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hint,
          suffixIcon: suffix,
          hintStyle:  TextStyle(
            fontSize: 17.sp,
            color: const Color(0xffB8B8B8),
          ),
          label: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.dm),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.dm),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.dm),
          ),
        ),
        obscureText: obscure,
        keyboardType: keyboardType,
        style:  TextStyle(
            color: Colors.lightBlue,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Segue UI'),
      ),
    );
  }
}
