import 'package:flutter/foundation.dart';

class Message
{
String? text;
DateTime? time;
String? sender;

Message({this.text, this.time, this.sender});
Map<String,dynamic>toMap()
{
  return{
    'text':text,
    'time':time,
    'sender':sender,
     };
    }
    }