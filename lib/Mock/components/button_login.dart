import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {

  final Function()? onTap;
  final String stringButton;
  const ButtonLogin({super.key,required this.onTap,required this.stringButton});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(32, 64, 188, 1), 
          borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(
          stringButton,
          style: const TextStyle(
              color: Colors.white, 
              fontSize: 16, 
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
    );
  }
}
