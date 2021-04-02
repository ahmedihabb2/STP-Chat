import 'package:chat_stp/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices
{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Get stream from firebase

  Stream<userData> userStream()
  {
    return _auth.authStateChanges().map(getuserID);
  }



 // get user id
   userData  getuserID(User user)
  {
    return user !=null ? userData(uid: user.uid) : null;
  }

  //reg with email and password
  Future regWithEmailandPassword(String email , String password)
  async{
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email:email, password: password);
      User user = result.user;
      return getuserID(user);
    }catch(error)
    {
      print(error.toString());
      return null;
    }

  }

  //Sign in with email and pass
  Future signinWithEmailandPassword(String email , String password)
  async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return getuserID(user);
    }catch(error)
    {
      print(error.toString());
      return null;
    }
  }

//Sign out
Future signUserout()
async{
  await _auth.signOut();
}
}