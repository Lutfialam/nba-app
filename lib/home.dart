import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nba/gameDetail.dart';
import 'package:nba/model/game.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color getScoreColors(String position, int homeScore, int visitorScore) {
    if (homeScore > visitorScore) {
      return position == "home" ? Color(0xff04DBBF) : Color(0xffFC1467);
    } else if (homeScore < visitorScore) {
      return position == "home" ? Color(0xffFC1467) : Color(0xff04DBBF);
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: FutureBuilder<List<GameModel>>(
        future: GameModel.getSeveralGame(2),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: AssetImage('assets/images/nba.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Last game',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Color(0xff726767),
                          fontSize: 20,
                        ),
                      ),
                      Column(
                        children: snapshot.data!.map((game) {
                          return InkWell(
                            onTap: () => {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      GameDetail(game: game),
                                ),
                              ),
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Color(0xff6C63FF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          color: Colors.white,
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
                                            left: 20,
                                            right: 20,
                                            top: 5,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                          color: Color(0xffE8E6E6),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'Final',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Color(0xff726767),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'VS',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                          color: Colors.white,
                                        ),
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
                                          color: Colors.white,
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
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return Container(
              width: size.width,
              height: size.height,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff6C63FF)),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
