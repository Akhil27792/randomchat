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
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
onTap: () {},
child: Row(
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
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
            Text(
              widget.user.name,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500)),

                  //for adding some space
       const SizedBox(height: 2),

            const Text('Last seen not available',
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  )
            ),
          ],
        )
      ],
    ));
  }
}
