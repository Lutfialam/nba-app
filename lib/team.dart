import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nba/model/image.dart';
import 'package:nba/model/team.dart';
import 'package:nba/teamDetail.dart';

class Team extends StatefulWidget {
  Team({Key? key}) : super(key: key);

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {
  String error = '';
  bool loading = true;
  List<TeamModel> teams = [];

  @override
  Widget build(BuildContext context) {
    TeamModel.getAllTeam().then((value) {
      print('kesini coeg');
      setState(() {
        teams = value;
        loading = false;
      });
    }).onError((error, stackTrace) {
      setState(() {
        error = error.toString();
        loading = false;
      });
    });
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: loading
          ? Center(child: Text('Loading...'))
          : SingleChildScrollView(
              child: Column(
                children: error.length > 0
                    ? [Text('Error when getting data')]
                    : teams.map((team) {
                        return ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Card(
                            color: Color(0xff6C63FF),
                            child: InkWell(
                              onTap: () => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TeamDetail(team: team)))
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundImage: team.logo ??
                                            AssetImage('assets/images/nba.jpg'),
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 0.6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            team.name,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            team.abbreviation,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
              ),
            ),
    );
  }
}
