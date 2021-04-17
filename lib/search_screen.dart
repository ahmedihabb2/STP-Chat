import 'package:chat_stp/Database/cloudfirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ChatScreen.dart';
import 'usermodel.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  QuerySnapshot qs = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Search Screen"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
             color: Colors.white,
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (username) async {
                 qs = await DatabaseServices().getUserByName(username);
                 setState(() {});
                },
              ),
            ),
          ),
          qs == null ? SizedBox() : Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => SingleResult(data: qs.docs[index]),
              itemCount: qs.size,
            ),
          ),
        ],
      ),
    );
  }
}

class SingleResult extends StatelessWidget {
  QueryDocumentSnapshot data;
  String currentUserID;
  SingleResult({this.data});

  @override
  Widget build(BuildContext context) {
    var result = Provider.of<userData>(context);
    currentUserID = result.uid;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat(recevierId: data["uid"],recevierName:data["Username"] ,senderId: currentUserID,)));
        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
              ),
              SizedBox(width: 5.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(
                      "${data["Username"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0
                      ),
                    ),
                    Text("${data["About"]}"),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

