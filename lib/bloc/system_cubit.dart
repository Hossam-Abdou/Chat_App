import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/message_model.dart';
part 'system_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super( ChatInitial() );

  static ChatCubit get (context)=>BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Stream ?messagesStream;


  Login()async
  {
    emit(ChatLoginloading());
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email:emailController.text,
      password:passwordController.text,
    ).then((value) {
      emit(ChatLoginSuccess());
    }).catchError((error) {
      emit(ChatLoginError(error: error.toString()));
    });
  }


  Register()async {
    emit(ChatLoginloading());
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email:emailController.text,
      password:passwordController.text,
    ).then((value) {
      emit(ChatRegisterSuccess());
    }).catchError((error) {
      emit(ChatRegisterError(error: error.toString()));
    });

  }

  sendMessage(String text,DateTime time) {
    String userEmail =FirebaseAuth.instance.currentUser!.email!;

    Message message = Message(text: text, time:time, sender: userEmail);
    FirebaseFirestore.instance
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      emit(ChatSendSuccess());
    }).catchError((error){
      emit(ChatSendError());
      print(error);
    });
  }
  receiveMessages()
  {
    messagesStream=FirebaseFirestore.instance
        .collection('messages')
        .orderBy('time')
        .snapshots();
    emit(ChatReceiveMessageState());
  }


}
// try {
// UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
// email:emailController.text,
// password:passwordController.text,
// );
// emit(ChatRegisterSuccess());
// const snackBar = SnackBar(
// content: Text('Registered Successfully'),
// backgroundColor: Colors.green,
// );
// } on FirebaseAuthException catch (e) {
// if (e.code == 'weak-password')
// {
// const snackBar = SnackBar(
// content: Text('The password provided is too weak.'),
// backgroundColor: Colors.blueGrey,
// );
// emit(ChatRegisterError());
// }
// else if (e.code == 'email-already-in-use')
// {
// const snackBar = SnackBar(
// content: Text('The account already exists for that email.'),
// backgroundColor: Colors.blueGrey,
// );
// emit(ChatRegisterError());
// }
// }