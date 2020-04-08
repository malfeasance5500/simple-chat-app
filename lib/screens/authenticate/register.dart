import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool loading;
  final _formkey = GlobalKey<FormState>();
  String email;
  String password;
  String username;
  String error ="";
  
  final AuthService _auth = AuthService(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
        backgroundColor: Colors.grey[900],
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.people, color: Colors.grey[100],),
            label: Text(
              "Sign up",
              style: TextStyle(
                color: Colors.grey[100]
              ),
              ),
            onPressed: () => widget.toggleView(),
          )
        ],
      ),
      body: Container(
        color: Colors.grey[700],
        padding: EdgeInsets.symmetric(vertical:4.0, horizontal:20.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                // text form field for email 
                decoration: InputDecoration (
                  fillColor: Colors.grey[300],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[500], width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[900], width:2.0)
                  ),
                  hintText: "Email"
                ),
                validator: (val) => val.isEmpty ? "Please enter a email":null,
                onChanged: (val){
                  setState( ()=> email=val );
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                // text form field for email 
                decoration: InputDecoration (
                  fillColor: Colors.grey[300],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[500], width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[900], width:2.0)
                  ),
                  hintText: "Username"
                ),
                validator: (val) => val.isEmpty ? "Please enter a username":null,
                onChanged: (val){
                  setState( ()=> username=val );
                },
              ),
              SizedBox(
                height: 20.0,
              ),

              TextFormField(
                // text form field for password
                decoration: InputDecoration (
                  fillColor: Colors.grey[300],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[500], width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[900], width:2.0)
                  ),
                  hintText: "password"
                ),
                validator: (val) => val.length<6 ? "Please enter a password more than 6 characters long":null,
                obscureText: true,
                onChanged: (val){
                  setState(()=> password = val);
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.grey[100],
                child: Text("Sign up"),
                onPressed: () async {
                  if (_formkey.currentState.validate() ){
                    setState( ()=> loading = true );
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password, username) ;
                    print("register.dart, register account result: " + result.toString());
                    if (result == null){
                      print("an error on register.dart has  occurred");
                      setState(() => error = "Please enter a valid email address");
                      loading = false;
                    }
                  }
                },  
              ),
              SizedBox(height: 20.0,),
              Text(error,
              style: TextStyle(color: Colors.red),),
            ],

          ),
        ),
      ),
    );
  }
}