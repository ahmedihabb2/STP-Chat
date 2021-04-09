import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("STP" , style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold, color: Colors.white),),
       SizedBox(height: 6,),
          SpinKitWanderingCubes(
        color: Colors.white,
        size: 40.0,
      )
        ],
      ),
    );
  }
}
