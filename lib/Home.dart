import 'package:chat_stp/search_screen.dart';
import 'package:chat_stp/user_profile.dart';
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
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile()),
              );
            },
          )
        ],
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
               builder:(context) => SearchScreen(),
            ),
          );
        },
      ),
    );
  }
}
