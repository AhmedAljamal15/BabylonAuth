import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    this.prefix,
    required this.hintText,
    this.controller,
    this.validator,
    required this.keyboardType, this.suffix, this.obscureText,
  });
  final Widget? prefix;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? suffix;
  final TextInputType keyboardType; 

   final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
  
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        suffixIcon: suffix,
        prefixIcon: prefix,
        prefixStyle: TextStyle(color: Colors.grey),
        hintText: hintText,
        border: OutlineInputBorder(borderSide: BorderSide.none),
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[100],
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
