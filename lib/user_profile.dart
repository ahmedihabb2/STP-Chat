import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 80.0,
                      backgroundImage: NetworkImage('https://yt3.ggpht.com/ytc/AAUvwnh-0SJUxi58lUsKdmBWgVZ7YmVy0pfJlBH8EnaopA=s900-c-k-c0x00ffffff-no-rj'),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 20.0,
                      child: Icon(Icons.camera_alt),
                    ),
                  ],
                ),
                EditField(label: "Username", content: "Username"),
                Separator(),
                EditField(label: "Email", content: "email@exmaple.com"),
                Separator(),
                EditField(label: "About", content: "Hey There I am using STP Chat!"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget EditField({String label , String content}){
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$label",
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            Text(
              "$content",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      CircleAvatar(
        radius: 18.0,
        backgroundColor: Colors.blue,
        child: Icon(Icons.edit, size: 17.0,),
      ),
    ],
  );
}

Widget Separator() => Column(
    children: [
      SizedBox(height: 10.0,),
      Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
        child: SizedBox(),
      ),
      SizedBox(height: 20.0,),
    ]
);