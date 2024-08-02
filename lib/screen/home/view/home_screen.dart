import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:firebaseminer/utils/helper/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
        actions: [
          TextButton.icon(
            onPressed: () {
              FirebaseHelper.helper.signout();
              Get.offAllNamed('signin');
              DelightToastBar(
                builder: (context) => const ToastCard(
                  title: Text("Signed Out"),
                  leading: Icon(Icons.logout),
                ),
              ).show(context);
            },
            icon: Icon(
              Icons.logout_sharp,
              color: Colors.red.shade900,
            ),
            label: Text("Log Out"),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('user');
        },
        child: Icon(Icons.chat),
      ),
    );
  }
}
