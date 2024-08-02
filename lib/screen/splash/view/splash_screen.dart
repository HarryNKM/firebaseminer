import 'package:firebaseminer/utils/helper/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () {
        bool check = FirebaseHelper.helper.checkUser();
        if (check) {
          Get.offAndToNamed('home');
        } else {
          Get.offAndToNamed('signin');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "😂",
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
