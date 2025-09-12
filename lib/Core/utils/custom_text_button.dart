import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.text, this.onPressed, this.alignment});

  final String text;
  final void Function()? onPressed;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(alignment: alignment ?? AlignmentGeometry.center),
        onPressed: onPressed ?? () {},
        child: Text(
          text,
          style: TextStyle(color: Colors.blueAccent, fontSize: 16),
        ),
      ),
    );
  }
}
