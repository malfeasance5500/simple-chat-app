import 'package:chat_app/models/user.dart';
import 'package:chat_app/screens/wrapper.dart';
import 'package:chat_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // provides the value of the User object that comes from the user stream in auth.dart
    return StreamProvider<User>.value(
      // specifying the stream 
      value: AuthService().user,
          child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
