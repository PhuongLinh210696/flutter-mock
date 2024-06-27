import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            fillColor: const Color.fromRGBO(224, 228, 255, 1),
            enabledBorder:
                const OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(59, 72, 176, 1))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(59, 72, 176, 1)))),
      ),
    );
  }
}
