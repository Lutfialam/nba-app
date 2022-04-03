import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nba/model/team.dart';

class TeamDetail extends StatefulWidget {
  TeamModel team;
  TeamDetail({Key? key, required this.team}) : super(key: key);

  @override
  State<TeamDetail> createState() => _TeamDetailState(team);
}

class _TeamDetailState extends State<TeamDetail> {
  TeamModel team;
  _TeamDetailState(this.team);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   iconTheme: IconThemeData(
      //     color: Colors.black,
      //   ),
      //   title: Text(
      //     team.name,
      //     style: TextStyle(
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.topLeft,
          children: [
            Positioned(
              width: size.width,
              height: 250,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/nba.jpg'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5.0,
                    sigmaY: 5.0,
                  ),
                  child: Container(
                    color: Colors.white.withOpacity(0.0),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Icon(
                      Icons.chevron_left_rounded,
                    ),
                    Text(
                      team.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.26,
              width: size.width,
              height: size.height,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: team.logo,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                team.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                team.abbreviation,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
