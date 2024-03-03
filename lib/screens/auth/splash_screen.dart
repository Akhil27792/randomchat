// ignore_for_file: unnecessary_import

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_chat/screens/auth/login_screen.dart';
import 'package:random_chat/screens/auth/home_screen.dart';

import '../../api/api.dart';
import '../../main.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500),(){
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      if(API.auth.currentUser!=null){
         log('\nUser:${API.auth.currentUser}');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
    return  Scaffold(
     body: Stack(children: [
      Positioned(
          width: mq.height*.38,
          top: mq.height*.15,
          right: mq.width*.18,
          
          
          child: Image.asset('images/logo.png')),
          Positioned(
          width: mq.height*.34,
          top: mq.height*.85,
          right: mq.width*.21,
          
          child: const Text('Made by Krishna And Akhil ',textAlign: TextAlign.center,style: TextStyle(fontSize: 16,color: Colors.lightBlueAccent),))
          ,],),
    );
  }
}