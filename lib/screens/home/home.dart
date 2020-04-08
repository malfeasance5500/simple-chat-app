import 'package:chat_app/models/chats.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/screens/home/chat.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final User user = Provider.of<User>(context);

    void showSettings(){
      final key = GlobalKey<FormState>();
      final controller = TextEditingController();
      String error = "";
      showDialog(
        context:context,
        builder: (context){
          return AlertDialog(
            content: Form(
              key: key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: TextField(
                      autofocus:true,
                      controller:controller,
                    ),
                  ),
                  Text(
                    error,
                    style: TextStyle(
                      color: Colors.red
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: RaisedButton(
                      child: Text("Set username"),
                      onPressed: () async{
                        if (controller.text.trim() =="" ){
                          setState(()=> error = "Set a username");
                        }else{
                          await DatabaseService(uid: user.uid).updateUsername(user.uid, controller.text.trim());
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      );
    }

    return MultiProvider(
      providers: [
        StreamProvider<List<Chats>>.value(
          value: DatabaseService().chats,
        ),
        StreamProvider<Map>.value(
          value: DatabaseService().usernames,
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text(""),
          actions: <Widget>[
            FlatButton.icon(
              label: Text("Log out", style: TextStyle(color: Colors.grey[100]),),
              icon: Icon(Icons.person_pin, color: Colors.grey[100],),
              onPressed: () => _auth.signOut(),            

            ),
            FlatButton.icon(
              label: Text("", style: TextStyle(color: Colors.grey[100]),),
              icon: Icon(Icons.more_vert, color: Colors.grey[100],),
              onPressed: () => showSettings(),            

            ),
            
          ],
        ),
        body: Container(
          color: Colors.grey[700],
          
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Chat(),
              ),
              SizedBox(height: 10.0,),
              Row(
                children: <Widget>[
                  SizedBox(width: 20.0,),
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      maxLines: null,
                      onChanged: (val){
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey[300],
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500], width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[900], width: 2.0)
                        ),
                        hintText: "Start typing..."
                      ),
                    ),
                  ),
                  FlatButton.icon(onPressed: () async{
                    print("pressed");
                    print(widget.controller.text);
                    if (widget.controller.text.trim() != ""){
                      var message = widget.controller.text.trim();
                      widget.controller.clear();
                      print(DateTime.now().millisecondsSinceEpoch.toString());
                      await DatabaseService(uid: user.uid).updateChat(DateTime.now().millisecondsSinceEpoch.toString(),message);
                    }
                  }, icon: Icon(Icons.send), label: Text(""))
                ],
              ),
              SizedBox(height: 20.0,),
            ],
          ),
        ) ,
      ),
    );
  }
}


        