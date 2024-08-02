import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/helper/firebase_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      "Let's,Get Going!",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    const Text(
                      "Edit Your Profile Using The Form Below",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.sizeOf(context).height / 15,
                      ),
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.1,
                              child: TextFormField(
                                controller: txtName,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hintText: "Name"),
                                validator: (value) {
                                  if (value != null) {
                                    return null;
                                  }
                                  return "Enter A Valid Name";
                                },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.1,
                              child: TextFormField(
                                controller: txtEmail,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hintText: "Email"),
                                validator: (value) {
                                  if (value != null &&
                                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value)) {
                                    return null;
                                  }
                                  return "Enter Correct Email";
                                },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.1,
                              child: TextFormField(
                                controller: txtPhone,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hintText: "Phone"),
                                validator: (value) {
                                  if (value != null) {
                                    return null;
                                  }
                                  return "Enter Phone";
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: MaterialButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            Get.offAllNamed('home');
                          }
                        },
                        color: Theme.of(context).primaryColor,
                        child: const Text(
                          "Continue",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
