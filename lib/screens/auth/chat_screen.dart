import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_chat/main.dart';
import 'package:random_chat/models/chat_user.dart';

class Chatscreen extends StatefulWidget {
  final ChatUser user;

  const Chatscreen({super.key, required this.user});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
            AppBar(automaticallyImplyLeading: false, flexibleSpace: _appBar()),
        // body
        body: const Column(
          children: [],
        ),
      ),
    );
  }

// app bar widget
  Widget _appBar() {
    return InkWell(
        onTap: () {},
        child: Row(children: [
          // back button
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black54,
              )),
          ClipRRect(
            borderRadius: BorderRadius.circular(mq.width * .4),
            child: CachedNetworkImage(
              width: mq.width * .1,
              height: mq.width * .7,
              imageUrl: widget.user.image,
              // placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => const CircleAvatar(
                child: Icon(CupertinoIcons.person),
              ),
            ),
          ),
          //for adding some space
          const SizedBox(width: 10),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.user.name,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500)),

                //for adding some space
                const SizedBox(height: 2),

                const Text('Last seen not available',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    )),
              ]),
        ]));
  }

  //input field & buttons
  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .025),
      child: Row(
        children: [
          //input field & buttons
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  // emoji button
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Colors.blue,
                        size: 25,
                      )),
                  const Expanded(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                    decoration: InputDecoration(
                        hintText: 'type something...',
                        hintStyle: TextStyle(color: Colors.blue),
                        border: InputBorder.none),
                  )),
                  // pick image from gallery button
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.image,
                        color: Colors.blue,
                        size: 26,
                      )),
                  // take image from camera button
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_rounded,
                          color: Colors.blue)),
                   //adding some space
                   SizedBox(width: mq.width*.02),       
                ],
              ),
            ),
          ),
          // send message button
          MaterialButton(
            onPressed: () {},
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: Colors.green,
            child: const Icon(
              Icons.send,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}