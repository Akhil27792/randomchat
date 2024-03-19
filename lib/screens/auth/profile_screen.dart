// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
// import 'dart:ffi';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_chat/api/api.dart';
import 'package:random_chat/helper/dialogs.dart';
import 'package:random_chat/models/chat_user.dart';
import 'package:random_chat/screens/auth/login_screen.dart';

import '../../main.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late List<ChatUser> list = [];
  String? _image;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return GestureDetector(
      //for hiding keyboard when click on screeen anywhere
      onTap: () => FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Random Chat',
            textAlign: TextAlign.center,
          ),
        ),
        // floating button to Log Out user
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            onPressed: () async {
              //for showing progress dialog
              Dialogs.showProgessBar(context);

              //for sign out  from google and random chat api
              await API.auth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) {
                  //for hiding progress bar
                  Navigator.pop(context);
                  //for moving to home screen
                  Navigator.pop(context);
                  //replacing home screen with login screen
                  Navigator.pushReplacementNamed(
                      context,
                      //why string is getting??
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()) as String);
                });
              });
            },
            icon: const Icon(Icons.logout_outlined),
            label: const Text('Log Out'),
          ),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: mq.width,
                    height: mq.height * .03,
                  ),
                  Stack(
                    children: [
                      _image != null
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(mq.height * 1),
                              child: Image.file(
                                File(_image!),
                                width: mq.height * .2,
                                height: mq.height * .2,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(mq.height * 1),
                              child: CachedNetworkImage(
                                width: mq.height * .2,
                                height: mq.height * .2,
                                imageUrl: widget.user.image,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                  child: Icon(CupertinoIcons.person),
                                ),
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          elevation: 1,
                          onPressed: () {
                            _showBottomSheet();
                          },
                          shape: const CircleBorder(),
                          color: Colors.white,
                          child: const Icon(
                            Icons.edit,
                            color: Color.fromARGB(255, 9, 116, 203),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: mq.height * .03,
                  ),
                  Text(
                    widget.user.email,
                    style: const TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                  SizedBox(
                    height: mq.height * .05,
                  ),
                  TextFormField(
                    initialValue: widget.user.name,
                    onSaved: (val) => API.me.name = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(
                        Icons.person_2_rounded,
                        color: Colors.blueAccent,
                      ),
                      hintText: ('eg: Happy Singh'),
                      label: const Text('Name'),
                    ),
                  ),
                  SizedBox(
                    height: mq.height * .03,
                  ),
                  TextFormField(
                    initialValue: widget.user.about,
                    onSaved: (val) => API.me.about = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(
                        Icons.info_outline,
                        color: Colors.blueAccent,
                      ),
                      hintText: ('eg: Happy Singh'),
                      label: const Text('About'),
                    ),
                  ),
                  SizedBox(
                    height: mq.height * .05,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        API.updateUserInfo().then((value) {
                          Dialogs.showSnackbar(
                              context, "Profile Updated Successfully");
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      // minimumSize: Size(mq.width * .5, mq.height * .06)
                    ),
                    icon: const Icon(
                      Icons.edit,
                      size: 28,
                      color: Colors.black,
                    ),
                    label: const Text(
                      'UPDATE',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: ((context) {
          return ListView(
            shrinkWrap: true,
            padding:
                EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .05),
            children: [
              const Text(
                'Pick Profile Picture',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image.
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path} -- MimeType: ${image.mimeType}');
                          setState(() {
                            _image = image.path;
                          });
                          API.updateProfilePicture(File(image as String));
                          //for removing bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.white,
                          fixedSize: Size(mq.width * .3, mq.height * .15)),
                      child: Image.asset('images/add_image.png')),
                  ElevatedButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image.
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });
                          API.updateProfilePicture(File(_image!));
                          //for removing bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.white,
                          fixedSize: Size(mq.width * .3, mq.height * .15)),
                      child: Image.asset('images/camera.png'))
                ],
              )
            ],
          );
        }));
  }
}
