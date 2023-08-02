import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

   final String label;
   final bool isPassword;
   final TextEditingController controller;
  CustomTextField({
    required this.label,
    this.isPassword=false,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 23
      ),
      child: Column(
        children: [
          TextFormField(

            controller: controller,
            obscureText: isPassword,
            decoration:  InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              hintText: '$label',
            ),
          ),
        ],
      ),
    );
  }
}
