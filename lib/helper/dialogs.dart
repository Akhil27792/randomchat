import 'package:flutter/material.dart';

class Dialogs{
  static void showSnackbar(BuildContext context, String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg),backgroundColor: Colors.black.withOpacity(.8),behavior: SnackBarBehavior.floating,));
  }
  static void showProgessBar(BuildContext context){
    showDialog(context: context, builder: (context)=>const Center(child: CircularProgressIndicator(color: Colors.black,),));
  }
}