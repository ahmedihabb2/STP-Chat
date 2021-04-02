import 'package:chat_stp/Database/auth.dart';
import 'package:chat_stp/Home.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernamecont = TextEditingController();
  TextEditingController emailcont = TextEditingController();
  TextEditingController passwordcont = TextEditingController();
  AuthServices authServices =AuthServices();
  // if true -> login page
  // if false -> sign up page
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar:AppBar(
        title: Text("STP - Chat"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Container(
            padding: EdgeInsets.all(15.0),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isLogin ? "Login" : "Sign Up",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10.0,),
                Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  height: 2.0,
                ),
                SizedBox(height: 10.0,),
                isLogin ? SizedBox(): TextFormField(
                  controller: usernamecont,
                  decoration: InputDecoration(
                      hintText: "Username"
                  ),
                ),
                TextFormField(
                  controller: emailcont,
                 decoration: InputDecoration(
                   hintText: "Email"
                 ),
                ),
                TextFormField(
                  obscureText: true,
                  controller: passwordcont,
                  decoration: InputDecoration(
                      hintText: "Password"
                  ),
                ),
                Center(
                  child: isLogin ? RaisedButton(
                    // START THIS IS THE ONPRESSED FUN FOR LOGIN
                    onPressed: ()async{
                     var result= await authServices.signinWithEmailandPassword(emailcont.text, passwordcont.text);
                     if(result != null)
                       {
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                       }
                     else
                       {
                         print("Error");
                       }
                    },
                    // END THIS IS THE ONPRESSED FUN FOR LOGIN
                    color: Colors.blue,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ) : RaisedButton(
                    // START THIS IS THE ONPRESSED FUN FOR Sign Up
                    onPressed: ()async{
                      var result =await authServices.regWithEmailandPassword(emailcont.text, passwordcont.text);
                      if(result != null)
                        {
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                        }
                    },
                    // END THIS IS THE ONPRESSED FUN FOR Sign up
                    color: Colors.blue,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('or'),
                    SizedBox(width: 5.0,),
                    GestureDetector(
                      onTap:(){
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(
                          isLogin ? "Sign Up" : "Login",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
