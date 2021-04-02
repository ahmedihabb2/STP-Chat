import 'package:chat_stp/Home.dart';
import 'package:chat_stp/login_screen.dart';
import 'package:chat_stp/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userData>(context);
    if(user != null)
      {
        return Home();
      }
    else
      {
        return LoginScreen();
      }
  }
}
