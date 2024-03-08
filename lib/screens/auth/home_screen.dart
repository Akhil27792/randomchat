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
  //for storing all users
  late List<ChatUser> _list = [];
  //for storing searched items
  final List<ChatUser> _searchList = [];
  //for storing search status
  bool _isSearching = false;
  @override
  void initState() {
    super.initState();
    API.getSelfInfo(); // Get self info to display on the profile button
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search By Name",
                ),
                style: const TextStyle(fontSize: 16, letterSpacing: 0.5),
                //when search text changes then updated search list
                onChanged: (value) {
                  //search logic
                  _searchList.clear();
                  for (var i in _list) {
                    if (i.name.toLowerCase().contains(value.toLowerCase())) {
                      _searchList.add(i);
                    }
                    setState(() {
                      _searchList;
                    });
                  }
                },
                autofocus: true,
              )
            : const Text('Random Chat'),
        leading: const Icon(CupertinoIcons.home),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt)),
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
              });
            },
            icon: Icon(_isSearching
                ? CupertinoIcons.clear_circled_solid
                : Icons.search),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                              user: API.me,
                            )));
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      //floating button to add new user
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add_comment_rounded),
        ),
      ),
      body: StreamBuilder(
        stream: API.getAllUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              _list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
          }
          if (_list.isNotEmpty) {
            return ListView.builder(
                itemCount: _isSearching ? _searchList.length : _list.length,
                padding: EdgeInsets.only(top: mq.height * .01),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  // return const ChatUserCard();
                  return ChatUserCard(
                    user: _isSearching ? _searchList[index] : _list[index],
                  );
                });
          } else {
            return const Center(
                child: Text(
              "No Friends Found",
              style: TextStyle(fontSize: 20),
            ));
          }
        },
      ),
    );
  }
}
