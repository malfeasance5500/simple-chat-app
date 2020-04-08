import 'package:chat_app/models/user.dart';
import 'package:chat_app/screens/authenticate/authenticate.dart';
import 'package:chat_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // get the value of the user id from the User stream in auth.dart
    final user = Provider.of<User>(context);
    print(user);

    if (user == null){
      // return authenticate or homepage based on whether user is signed in anot
    return Authenticate();
    }else{
      return Home();
    }
    
  }
}