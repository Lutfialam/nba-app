import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nba/model/game.dart';

class GameDetail extends StatefulWidget {
  GameModel game;
  GameDetail({Key? key, required this.game}) : super(key: key);

  @override
  State<GameDetail> createState() => _GameDetailState(game);
}

class _GameDetailState extends State<GameDetail> {
  GameModel game;
  _GameDetailState(this.game);

  Color getScoreColors(String position, int homeScore, int visitorScore) {
    if (homeScore > visitorScore) {
      return position == "home" ? Color(0xff04DBBF) : Color(0xffFC1467);
    } else if (homeScore < visitorScore) {
      return position == "home" ? Color(0xffFC1467) : Color(0xff04DBBF);
    } else {
      return Colors.white;
    }
  }

  String getWinner() {
    int homeScore = game.homeTeamScore ?? 0;
    int visitorScore = game.visitorTeamScore ?? 0;

    if (homeScore > visitorScore) {
      return game.homeTeam!.abbreviation;
    } else if (homeScore < visitorScore) {
      return game.visitorTeam!.abbreviation;
    } else {
      return "PASS";
    }
  }

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
                      '${game.homeTeam!.abbreviation} vs ${game.visitorTeam!.abbreviation}',
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
              child: SingleChildScrollView(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: game.homeTeam!.logo,
                              ),
                              Text(
                                '${game.homeTeam!.abbreviation}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff726767),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${game.homeTeamScore}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: getScoreColors(
                                    "home",
                                    game.homeTeamScore ?? 0,
                                    game.visitorTeamScore ?? 0,
                                  ),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  color: Color(0xff6C63FF),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Final',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                'VS',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    color: Color(0xff726767)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: game.visitorTeam!.logo,
                              ),
                              Text(
                                '${game.visitorTeam!.abbreviation}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff726767),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${game.visitorTeamScore}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: getScoreColors(
                                    "visitor",
                                    game.homeTeamScore ?? 0,
                                    game.visitorTeamScore ?? 0,
                                  ),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.44,
                              height: 165,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xffE8E6E6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Home Team',
                                    style: TextStyle(
                                      color: Color(0xff726767),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "Name: ${game.homeTeam!.name} \n" +
                                        "Code: ${game.homeTeam!.abbreviation} \n" +
                                        "division: ${game.homeTeam!.division} \n" +
                                        "Conference: ${game.homeTeam!.conference}",
                                    style: TextStyle(
                                      color: Color(0xff726767),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.44,
                              height: 165,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xffE8E6E6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Visitor Team',
                                    style: TextStyle(
                                      color: Color(0xff726767),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "Name: ${game.visitorTeam!.name} \n" +
                                        "Code: ${game.visitorTeam!.abbreviation} \n" +
                                        "division: ${game.visitorTeam!.division} \n" +
                                        "Conference: ${game.visitorTeam!.conference}",
                                    style: TextStyle(
                                      color: Color(0xff726767),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          '${game.date} \n' +
                              'Season: ${game.season} \n' +
                              'Status: ${game.status} \n' +
                              'Period: ${game.period} \n' +
                              'Winner: ${getWinner()}',
                          style: TextStyle(
                            color: Color(0xff726767),
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
