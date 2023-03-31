import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/home.dart';
import 'package:flutter_todo/pages/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: '1:711156932780:android:0fa668cace1f84de2f7f09',
      apiKey: 'BEu4FYkvy757t66Y8eRATeZ68IY54L9jlgh1skt4nWmKSbD55hjaAoE0mVZK7QEkaRYQAdXBwcpXKZ4EH0Uf1sk',
      projectId: 'project1-c3ada',
      messagingSenderId: '711156932780 ',
    ),
  );
  runApp(MaterialApp(
  theme: ThemeData(colorScheme: const ColorScheme.light().copyWith(primary: Colors.deepOrange)),
  initialRoute: '/',
  routes: {
    '/': (context) => const MainScreen(),
    '/todo': (context) => const Home(),
  },
));}
