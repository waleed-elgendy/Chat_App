import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({Key? key, required this.hint, required this.label,this.suffix,  required this.obscure, this.onchange, this.validate}) : super(key: key);
  final String hint;
  final Widget? label,suffix;
  final bool obscure;
  final Function(String)? onchange ;
  final String? Function(String?)? validate;


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: validate,
        onChanged: onchange,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hint,
          suffixIcon: suffix,
          hintStyle: const TextStyle(
            fontSize: 17,
            color: Color(0xffB8B8B8),
          ),
          label: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        obscureText: obscure,
        style: const TextStyle(
            color: Colors.lightBlue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Segue UI'),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
