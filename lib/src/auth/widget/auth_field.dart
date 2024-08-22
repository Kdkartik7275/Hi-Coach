// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obsecure;
  final FormFieldValidator<String>? validator;
  Widget? suffixIcon;
  AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obsecure = false,
    required this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecure,
      validator: validator,
      decoration: InputDecoration(hintText: hintText, suffixIcon: suffixIcon),
    );
  }
}
