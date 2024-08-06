import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path/path.dart';

class FirebaseHelper {
  static FirebaseHelper helper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  User? getUser() {
    return user;
  }

  Future<bool> login(String email, String pass, BuildContext context) async {
    try {
      UserCredential credential =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      if (credential.user != null) {
        user = credential.user;
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      DelightToastBar(
        position: DelightSnackbarPosition.top,
        builder: (context) => ToastCard(
          title: Text("${e.message}"),
        ),
      ).show(context);
      return false;
    }
  }

  bool checkUser() {
    user = auth.currentUser;
    return user != null;
  }

  void signout() {
    auth.signOut();
  }

  Future<void> signUpAuth(email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(e.code, "");
      }
      Get.snackbar(e.code, "");
    }
  }
}
