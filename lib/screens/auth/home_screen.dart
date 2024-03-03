
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_chat/models/chat_user.dart';
import 'package:random_chat/screens/auth/profile_screen.dart';
import 'package:random_chat/widgets/chat_user_card.dart';
import '../../api/api.dart';
import '../../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late  List<ChatUser> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Chat'),
        leading: const Icon(CupertinoIcons.home),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(user: list[0],)));
          }, icon: const Icon(Icons.more_vert))
        ],
      ),
      //floating button to add new user
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          onPressed: ()  {
          },
          child: const Icon(Icons.add_comment_rounded),
        ),
      ),
      body: StreamBuilder(
        stream: API.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.done:
             final data = snapshot.data?.docs;
             list =data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
          }
          if(list.isNotEmpty){
            return ListView.builder(
              itemCount: list.length,
              padding: EdgeInsets.only(top: mq.height * .01),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                // return const ChatUserCard();
                return ChatUserCard(user: list[index],);
              });
          }
          else{
            return const Center(
              child:Text("No Friends Found",style: TextStyle(fontSize: 20),)
            );
          }
        },
      ),
    );
  }
}
