import 'package:flutter/material.dart';
import 'package:nba/main.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.topLeft,
        children: [
          Positioned(
            top: 0,
            width: size.width,
            height: size.height * 0.65,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/welcome_cover.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            width: size.width,
            height: size.height * 0.35,
            child: Container(
              alignment: Alignment.bottomLeft,
              // height: size.height * 0.33,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Color(0xff6C63FF),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Hello!',
                            style: TextStyle(
                              fontSize: 37,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Welcome to NBA APP! Click next if you want to see nba games or team!',
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) => Main(),
                          ),
                        )
                      },
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Next >',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
