import 'package:chat_app/models/chats.dart';
import 'package:chat_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  // reference to the collections that we will be using
  final userNameCollectionReference = Firestore.instance.collection("usernames");
  final chatCollectionReference = Firestore.instance.collection("chats");

  // update username collection
  Future updateUsername (String uid, String username) async{
    return await userNameCollectionReference.document(uid).setData({
      "name":username
    });
  }


  // update chat collection
  Future updateChat ( String timeStamp, String message) async {
    print(timeStamp);
    return await chatCollectionReference.document(timeStamp).setData({
      "uid":uid,
      "message": message
    });
  }

  List<Chats> _chatsFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map( (doc){
      return ( Chats( uid: doc.data["uid"].toString(), message:doc.data["message"].toString()  ));
    } ).toList();
  }

  Map _usernamesFromSnapshot(QuerySnapshot snapshot){
    Map<String, String> result= {};
    snapshot.documents.forEach( (name) {
      result[name.documentID] = name.data["name"].toString();
    });
    print(result);
    return(result);
  }

  // set up stream for usernames collection
  Stream<Map> get usernames{
    return userNameCollectionReference.snapshots().map(_usernamesFromSnapshot );
  }

  // set up stream for chat collection 
  Stream <List<Chats>> get chats{
    return chatCollectionReference.snapshots().map( _chatsFromSnapshot  );
  }


}