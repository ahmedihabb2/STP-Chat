import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices
{
  final CollectionReference _users = FirebaseFirestore.instance.collection("Users");
  //Set user data
Future setUserData(String uid , String username)
async{
   return _users.doc(uid).set({
     "uid"  : uid,
     "Username" : username,
   "About" : "Hey i am using STP Chat"
});
}

Future getUserByName(username) async{
  return _users.where("Username", isEqualTo: username).get();
}

}