import 'package:bloc/bloc.dart';
import 'package:chat_app_test/src/app_root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'bloc_observer.dart';
import 'firebase_options.dart';

main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();


  runApp( AppRoot() );
}