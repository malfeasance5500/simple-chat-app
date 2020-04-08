import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService{
  // create a firebase auth instance to communicate with the firebase api
  final _auth = FirebaseAuth.instance;

  // returns a User object for easy use
  User _returnUserFromFirebaseUser(FirebaseUser user){
    var answer = (user != null) ? User(uid: user.uid) : null;
    return (answer);
  }


  // stream get auth change 
  // provides value for when the user state changes, either returns null or a user uid
  Stream<User> get user{
    return _auth.onAuthStateChanged.map( (FirebaseUser user) => _returnUserFromFirebaseUser(user) );
  }


  // sign in user with email and password
  Future signInWithEmailAndPassword (String email, String password) async{
    try{
      AuthResult result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _returnUserFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  // register with email and password
  Future registerWithEmailAndPassword (String email, String password, String username) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUsername(user.uid, username);
      return _returnUserFromFirebaseUser(user);
      // return yes;
    }catch(e){
      print("auth error");
      print(e.toString());
      return null;
    }
  }

  
  // sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}