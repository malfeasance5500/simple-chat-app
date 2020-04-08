import 'dart:async';

import 'package:chat_app/models/chats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  ScrollController controller = new ScrollController();
  @override
  Widget build(BuildContext context) {

  Timer(Duration(milliseconds:200), ()=> controller.jumpTo(controller.position.maxScrollExtent));
  final chats = Provider.of<List<Chats>>(context) ?? [];
  final names = Provider.of<Map>(context) ?? {};
    return ListView.builder(
                  controller:controller,
                  shrinkWrap: true,
                  itemCount: chats.length,
                  itemBuilder: (context, index){
                    return Row(
                      children: <Widget>[
                        SizedBox(width:10.0),
                        Container(
                          // color: Colors.red,
                          child:Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                child: ListTile(
                                title: Text( names[chats[index].uid] , style: TextStyle(fontSize: 30.0, color: Colors.grey[700], decoration: TextDecoration.underline ), ),
                                subtitle: Text( chats[index].message , style: TextStyle(fontSize: 30.0, color: Colors.grey[700], ),),
                                isThreeLine: true,
                                ),
                              ),
                            ),
                          ), 
                        ),
                        
                        Expanded(
                          
                          child: SizedBox(),
                        ),
                        
                      ],
                    );
                  },

                );
  }

}