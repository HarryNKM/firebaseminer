import 'package:firebaseminer/screen/chat/view/chat_screen.dart';
import 'package:firebaseminer/screen/home/view/home_screen.dart';
import 'package:firebaseminer/screen/login/view/signin_screen.dart';
import 'package:firebaseminer/screen/login/view/signup_screen.dart';
import 'package:firebaseminer/screen/profile/view/profile_screen.dart';
import 'package:firebaseminer/screen/splash/view/splash_screen.dart';
import 'package:firebaseminer/screen/users/view/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

Map<String, WidgetBuilder> app_routes = {
  '/': (context) => SplashScreen(),
  'signin': (context) => SigninScreen(),
  'signup': (context) => SignupScreen(),
  'home': (context) => HomeScreen(),
  'profile': (context) => ProfileScreen(),
  'user': (context) => UsersScreen(),
  'chat': (context) => ChatScreen(),
};
