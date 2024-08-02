import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:firebaseminer/utils/helper/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();

  @override
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
                      "Hii, Welcome Back!",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    const Text(
                      "Hello again, you've been missed",
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
                                  return "Enter A Valid Email";
                                },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.1,
                              child: TextFormField(
                                obscureText: true,
                                controller: txtPass,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hintText: "Password"),
                                validator: (value) {
                                  if (value != null) {
                                    return null;
                                  }
                                  return "Enter Correct PassWord";
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
                            bool isLogin = await FirebaseHelper.helper
                                .login(txtEmail.text, txtPass.text, context);
                            if (isLogin) {
                              Get.offAllNamed('profile');
                            }
                          }
                        },
                        color: Theme.of(context).primaryColor,
                        child: const Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Don't have account? "),
                    InkWell(
                      onTap: () {
                        Get.offNamed('signup');
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w800),
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
