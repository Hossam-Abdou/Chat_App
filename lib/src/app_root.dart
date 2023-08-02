
import 'package:chat_app_test/screens/chat_screen.dart';
import 'package:chat_app_test/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/system_cubit.dart';
import '../screens/register_screen.dart';

class AppRoot extends StatelessWidget {


  @override

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers:
        [
        BlocProvider(create: (context)=>ChatCubit()..receiveMessages())
        ],
    child:  MaterialApp(
      debugShowCheckedModeBanner: false,
        home:  RegisterScreen()
    )
    );
  }
}
