import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nba/bookmark.dart';
import 'package:nba/game.dart';
import 'package:nba/home.dart';
import 'package:nba/team.dart';
import 'package:nba/welcome.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await dotenv.load(fileName: ".env");

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Routing Navigation',
    initialRoute: '/',
    theme: ThemeData(
      backgroundColor: Color(0xff6C63FF),
      fontFamily: 'Poppins',
    ),
    routes: {
      '/': (context) => Welcome(),
      '/main': (context) => Main(),
      '/home': (context) => Home(),
      '/games': (context) => Game(),
      '/teams': (context) => Team(),
      '/bookmark': (context) => BookMark(),
    },
  ));
}

class Main extends StatefulWidget {
  Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int currentIndex = 0;
  final screens = [Home(), Game(), BookMark(), Team()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Color(0xff6C63FF),
        onTap: (index) => setState(() => currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: 'Game'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: 'bookmark'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Team'),
        ],
      ),
    );
  }
}
