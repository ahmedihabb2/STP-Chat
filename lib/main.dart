import 'package:chat_stp/Database/auth.dart';
import 'package:chat_stp/Wrapper.dart';
import 'package:chat_stp/loading.dart';
import 'package:chat_stp/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:chat_stp/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'ChatScreen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<userData>.value(
      value: AuthServices().userStream(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Wrapper(),
      ),
    );
  }
}
