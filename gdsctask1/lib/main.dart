import 'package:flutter/material.dart';
import 'package:gdsctask1/forgot.dart';
import 'package:gdsctask1/login.dart';
import 'package:gdsctask1/register.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => const MyLogin(),
      'register': (context) => const MyRegister(),
      'forgot': (context) => const MyForgotPassword()
    },
  ));
}
