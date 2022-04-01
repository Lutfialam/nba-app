import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nba/game.dart';
import 'package:nba/standings.dart';
import 'package:nba/team.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Routing Navigation',
    initialRoute: '/',
    theme: ThemeData(backgroundColor: Color(0xff6C63FF)),
    routes: {
      '/': (context) => Main(),
      '/home': (context) => Home(),
      '/game': (context) => Game(),
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
  final screens = [Home(), Game(), Standings(), Team()];

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
          BottomNavigationBarItem(icon: Icon(Icons.sort), label: 'Standings'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Team'),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            child: Image.asset(
              'assets/images/nba.jpg',
              fit: BoxFit.cover,
              height: 200,
              width: screenWidth,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Available leagues',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xff726767),
                      fontSize: 20,
                    )),
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.5,
                      child: Card(
                        elevation: 8.0,
                        child: Text('data'),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.5,
                      child: Card(
                        elevation: 8.0,
                        child: Text('data'),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.5,
                      child: Card(
                        elevation: 8.0,
                        child: Text('data'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
