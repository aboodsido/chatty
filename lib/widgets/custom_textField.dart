import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFromField extends StatelessWidget {
  CustomTextFromField(
      {required this.onChanged,
      required this.hintText,
      required this.obscuring,
      required this.hintTextColor});

  String? hintText;
  bool obscuring;
  Function(String)? onChanged;
  Color? hintTextColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'Require Field';
        }
      },
      onChanged: onChanged,
      obscureText: obscuring,
      style: GoogleFonts.cairo(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffCBC9C9FF),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.cairo(
          color: hintTextColor,
        ),
      ),
    );
  }
}
