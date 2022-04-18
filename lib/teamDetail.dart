import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nba/model/team.dart';
import 'package:nba/utils/shared_pref.dart';

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
                    InkWell(
                      onTap: () => {Navigator.pop(context)},
                      child: Icon(
                        Icons.chevron_left_rounded,
                      ),
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
              height: size.height * 0.74,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ),
                    Container(
                      width: size.width,
                      padding: EdgeInsets.all(9),
                      margin: EdgeInsets.only(bottom: 21),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: Color(0xff6C63FF),
                      ),
                      child: InkWell(
                        onTap: () => {
                          SharedPref().addBookMarkId(team.id.toString()),
                        },
                        child: Text(
                          'BookMark this team',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
