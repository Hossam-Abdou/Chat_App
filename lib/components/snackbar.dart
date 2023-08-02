
import 'package:flutter/material.dart';

void snackBar(BuildContext context,String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)),);
}

void s(context,message){

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Registered Successfully'),
    backgroundColor: Colors.green,
  ));
}