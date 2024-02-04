import 'package:flutter/material.dart';
import 'package:todosqflite/Screens/add_note_screen.dart';
import 'package:todosqflite/Screens/home.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key ? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Todo list',
      debugShowCheckedModeBanner: false,
      home:MyHome(

      )
    );
  }
}

