
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_chat/models/chat_user.dart';

import '../../main.dart';


class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late  List<ChatUser> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Chat',textAlign: TextAlign.center,),
      ),
      // floating button to Log Out user
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 8.0),
      //   child: FloatingActionButton.extended(
      //     backgroundColor: Colors.redAccent,
      //     onPressed: () async {
      //       await API.auth.signOut();
      //       await GoogleSignIn().signOut();
      //     },
      //     icon: const Icon(Icons.logout_outlined),
      //     label: const Text('Log Out'),
      //   ),
        
      // ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal:mq.width*.05),
        child: Column(
          
          children: [
          SizedBox(
            width: mq.width,height: mq.height*.03,
          ),
            ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height*1),
                    child: CachedNetworkImage(
                      width: mq.height*.2,
                      height: mq.height*.2,
                          imageUrl: widget.user.image,
                          errorWidget: (context, url, error) =>const CircleAvatar(child: Icon(CupertinoIcons.person),),
                       ),
                    
                  ),
                  SizedBox(
            height: mq.height*.03,
          ),
          Text(widget.user.email,style: const TextStyle(color: Colors.black54,fontSize: 20),),
          SizedBox(
            height: mq.height*.05,
          ),
          TextFormField(
            initialValue: widget.user.name,
            decoration:    InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              prefixIcon: const Icon(Icons.person_2_rounded,color: Colors.blueAccent,),
              hintText: ('eg: Happy Singh'),
              label: const Text('Name'),

            ),
          ),
          SizedBox(
            height: mq.height*.03,
          ),
           TextFormField(
            initialValue: widget.user.about,
            decoration:    InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              prefixIcon: const Icon(Icons.info_outline,color: Colors.blueAccent,),
              hintText: ('eg: Happy Singh'),
              label: const Text('About'),

            ),
          ),
          SizedBox(
            height: mq.height*.05,
          ),
          ElevatedButton.icon(onPressed: (){}, 
          style: ElevatedButton.styleFrom(shape: const StadiumBorder(),minimumSize:Size(mq.width*.5, mq.height*.06) ),
          icon: const Icon(Icons.edit,size: 28,color: Colors.black,), label: const Text('UPDATE',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),),

          ],
        ),
      ),

    );
  }
}
