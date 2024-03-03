import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_chat/models/chat_user.dart';

class API{
  //for authentication
  static FirebaseAuth auth=FirebaseAuth.instance;
 //for accessing cloud firestore database
 static FirebaseFirestore firestore = FirebaseFirestore.instance;
 static User get user=>auth.currentUser!;
 //for checking if user exists or not?
 static Future<bool> userExist() async{
  return (await firestore.collection('users').doc(auth.currentUser?.uid).get()).exists;
 }
   //for creating a new user
static Future<void> createUser()async{
  final time=DateTime.now().millisecondsSinceEpoch.toString();
   final chatUser= ChatUser(image: user.photoURL.toString(), about: 'Hi, I am using Random Chat', name: user.displayName.toString(), createdAt:time , isOnline: false, id: user.uid, lastActive: time, pushToken: '', email: user.email.toString());
   return await firestore.collection('users').doc(user.uid).set(chatUser.toJson());
}
}