import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_chat/screens/auth/chat_screen.dart';

import '../main.dart';
import '../models/chat_user.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .02, vertical: 4),
      color: Colors.blueGrey.shade100,
      //color:colors.blue.shade100,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          //for navigating to chat screen
          Navigator.push(context, MaterialPageRoute(builder: (_) => Chatscreen(user: widget.user,)));
        },
        child:  ListTile(

            //user profile picture
            // leading: const CircleAvatar(child: Icon(CupertinoIcons.person)),

            leading:ClipRRect(
              
              borderRadius: BorderRadius.circular(mq.width*.4),
              child: CachedNetworkImage(
                width: mq.width*.1,
                height: mq.width*.7,
                    imageUrl: widget.user.image,
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>const CircleAvatar(child: Icon(CupertinoIcons.person),),
                 ),
            ),

            //user name
            title:Text(widget.user.name),

            //last message
            subtitle: Text(widget.user.about),

            //last message item
            trailing:Container(width: 15,
            
            height: 15,
            decoration: BoxDecoration(
              color: Colors.greenAccent,borderRadius: BorderRadius.circular(10)
            ),)
      ),
    ));
  }
}
