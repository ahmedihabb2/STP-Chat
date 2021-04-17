import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Chat extends StatefulWidget {
  final senderId;
  final recevierId;
  final recevierName;

  Chat({@required this.senderId,@required this.recevierId,@required this.recevierName});
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String chatID;
  TextEditingController takeMessage = TextEditingController();
  var messagesList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupChatRoom();
    setUids();
  }
  setupChatRoom()
  {

    if(widget.senderId.hashCode <= widget.recevierId.hashCode)
    {
      chatID = '${widget.senderId}-${widget.recevierId}';

    }
    else
    {
      chatID = '${widget.recevierId}-${widget.senderId}';

    }
  }
  setUids()
  {
    var doc1ref = FirebaseFirestore.instance.collection("Messages")
        .doc(chatID);
    doc1ref.set({
      "uids": [widget.senderId,widget.recevierId]
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("${widget.recevierName}"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Column(
          children: [
            createMessagesList(),
            takeInput()
          ],
        ),
      ),
    );
  }

  takeInput() {
    return Row(
      children: [
        Material(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            child: IconButton(
              icon: Icon(Icons.image),
              color: Colors.blue,
              onPressed: () {},
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: TextField(
              controller: takeMessage,
              style: TextStyle(color: Colors.black, fontSize: 15.0),
              decoration: InputDecoration.collapsed(
                hintText: "Type here ...",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),

        Material(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: Icon(Icons.send),
              color: Colors.blue,
              onPressed: () {
                sendMessage();

              },
            ),
          ),
        ),
      ],
    );
  }

  createMessagesList()
  {
    return Expanded(
      child: StreamBuilder(
        stream:FirebaseFirestore.instance
          .collection("Messages")
          .doc(chatID)
          .collection(chatID)
          .orderBy("timestamp" , descending: true)
          .snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if(!snapshot.hasData || snapshot.data.size==0)
          {

            return Center(
              child: Text("No Messages Yet"),
            );
          }
          else
          {
            messagesList = snapshot.data.docs;
            return ListView.builder(
              itemBuilder: (context,index)
              {
                return createSingleMessage(snapshot.data.docs[index]);
              },
              itemCount: snapshot.data.docs.length,
              reverse: true,
            );
          }
        },
      ),
    );
  }
  createSingleMessage(DocumentSnapshot documentSnapshot)
  {
    return (documentSnapshot['idFrom'] == widget.senderId) ?
    Padding(
      padding: const EdgeInsets.only(left:8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Text(
                documentSnapshot['content'],
                style: TextStyle(color: Colors.white , fontWeight: FontWeight.w500,fontSize: 16),
              ),
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              width: 200.0,
              decoration: BoxDecoration(color: Colors.blue[400] , borderRadius: BorderRadius.circular(8.0)),
              margin: EdgeInsets.only(bottom:10.0 , right: 10.0),
            )
          ]
      ),
    ): Padding(
      padding: const EdgeInsets.only(left:8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Container(
              child: Text(
                documentSnapshot['content'],
                style: TextStyle(color: Colors.white , fontWeight: FontWeight.w500,fontSize: 16),
              ),
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              width: 200.0,
              decoration: BoxDecoration(color: Colors.grey , borderRadius: BorderRadius.circular(8.0)),
              margin: EdgeInsets.only(bottom:10.0 , left: 10.0),
            )
          ]
      ),
    );
  }
  sendMessage() {
    String msgcontent = takeMessage.text;
    if (msgcontent != "")
      {
        takeMessage.clear();
        var timestamp = DateTime.now().microsecondsSinceEpoch.toString();
        var docref =FirebaseFirestore.instance.collection("Messages")
        .doc(chatID)
        .collection(chatID)
        .doc(timestamp);

        docref.set({
          "content" : msgcontent,
          "idFrom" : widget.senderId,
          "idTo" : widget.recevierId,
          "timestamp" : timestamp,
        });
        FirebaseFirestore.instance.collection("Messages")
            .doc(chatID).update({
          "LastMessage" : msgcontent,
          "lasttimestamp" : timestamp
        });

      }
  }
}
