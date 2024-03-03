// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:random_chat/api/api.dart';
import 'package:random_chat/helper/dialogs.dart';
import 'package:random_chat/screens/auth/home_screen.dart';

import '../../main.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {

  double opacityLevel = 0.0;
  @override
  void initState() {
    
    super.initState();

    Future.delayed(const Duration(milliseconds: 100),(){

setState(() {
        
        opacityLevel = opacityLevel == 1 ? 0 : 1.0;

});    });
  }
  _handleGoogleBtnClick(){
    //for showing progress
    Dialogs.showProgessBar(context);
_signInWithGoogle().then((user) async{
  //For hiding Progress bar
  Navigator.pop(context);
  
  if(user!= null){
    log('\nUser:${user.user}');
  log('\nUserAdditionalInfo:${user.additionalUserInfo}');

  if((await API.userExist())){
if(context.mounted){
  Navigator.pushReplacement( context, MaterialPageRoute(builder: (cont)=>const HomeScreen()));

}


  }
  else{
    await API.createUser().then((value){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const HomeScreen()));
    } );
  }
  
  }

} );
  }
  Future<UserCredential?> _signInWithGoogle() async {
 try{ 
  await InternetAddress.lookup('google.com');
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);}
  catch(e){
    log('\n_signInWithGoogle: $e');
    Dialogs.showSnackbar(context,'Something went Wrong (Check Internet)');
    return null;
  }
}
  @override
  Widget build(BuildContext context) {
      mq=MediaQuery.of(context).size;
    return Scaffold(
      
      appBar: AppBar(title: const Text('Random Chat'),elevation: 1,),
      body: Stack(children: [
        Positioned(
           width: mq.height*.3,
            top: mq.height*.15,
            right: mq.width*.23,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds:1500 ),
            opacity: opacityLevel,
            child: Image.asset('images/logo.png'),
          ),
        ),
          Positioned(
          width: mq.width*.90,
          top: mq.height*.70,
          height: mq.height*.06,
          left: mq.width*.05,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 1,
                backgroundColor: Colors.black,
                shape: const StadiumBorder(),
              ),
              onPressed: (){
                _handleGoogleBtnClick();
              }, icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('images/google.png'),
              ), label: RichText(text: const TextSpan(style: TextStyle(fontSize: 17), children:[TextSpan(text:'Sign In with '),
               TextSpan(text:'Google',style: TextStyle(fontWeight: FontWeight.bold)),] 
              
              )
          )),)
      ]),
     
    );
  }
}