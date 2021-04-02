import 'package:flutter/material.dart';

import 'Database/auth.dart';
import 'login_screen.dart';

class Home extends StatelessWidget {
  AuthServices authServices =AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Signout"),
          onPressed: ()
          async{
            await authServices.signUserout();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
          },
        ),
      ),
    );
  }
}
