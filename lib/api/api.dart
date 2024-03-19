import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_chat/models/chat_user.dart';

class API {
  //for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  //for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  //for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;
  static User get user => auth.currentUser!;
  //for storing self info
  static late ChatUser me;
  //for checking if user exists or not?
  static Future<bool> userExist() async {
    return (await firestore
            .collection('users')
            .doc(user.uid)
            .get())
        .exists;
  }

  static Future<void> getSelfInfo() async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .get()
        .then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        log('My Data: ${user.data()}' as num );
      } else {
       await createUser().then((value) => getSelfInfo());
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

//for updating user information
  static Future<void> updateUserInfo() async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'name': me.name, 'about': me.about});
  }

//updating profile picture of user
  static Future<void> updateProfilePicture(File file) async {
    //getting image extension
    final ext = file.path.split('.').last;
    // log('Extension: $ext' as num );
    //storage file ref with path
    final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');
    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'images/$ext'))
        .then((p0) {
      log('Data transferred: ${p0.bytesTransferred / 1000}kb ' as num);
    });
    //updating image in firebase database
    me.image = await ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'image': me.image});
  }
}
