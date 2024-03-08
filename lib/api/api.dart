import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_chat/models/chat_user.dart';

class API {
  //for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  //for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => auth.currentUser!;
  //for storing self info
  static late ChatUser me;
  //for checking if user exists or not?
  static Future<bool> userExist() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser?.uid)
            .get())
        .exists;
  }

  static Future<void> getSelfInfo() async {
    await firestore
        .collection('users')
        .doc(auth.currentUser?.uid)
        .get()
        .then((user) {
      if (user.exists) {
        me = ChatUser.fromJson(user.data() as Map<String, dynamic>);
        log('My Data: ${user.data()}' as num);
      } else {
        createUser().then((value) => getSelfInfo());
      }
    });
  }

  //for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        image: user.photoURL.toString(),
        about: 'Hi, I am using Random Chat',
        name: user.displayName.toString(),
        createdAt: time,
        isOnline: false,
        id: user.uid,
        lastActive: time,
        pushToken: '',
        email: user.email.toString());
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

//for getting all user from firebase database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }
}
