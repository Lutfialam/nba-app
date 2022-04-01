import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nba/model/image.dart';
import 'package:nba/model/game.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Game extends StatefulWidget {
  Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  String error = '';
  String dateGame = '';
  bool loading = true;
  List<GameModel> games = [];

  Color getScoreColors(String position, int homeScore, int visitorScore) {
    if (homeScore > visitorScore) {
      return position == "home" ? Color(0xff04DBBF) : Color(0xffFC1467);
    } else if (homeScore < visitorScore) {
      return position == "home" ? Color(0xffFC1467) : Color(0xff04DBBF);
    } else {
      return Colors.white;
    }
  }

  void getGame() {
    setState(() => loading = true);

    if (dateGame.length > 0) {
      GameModel.getGameByDate(dateGame.toString())
          .then((value) => setState(() {
                setState(() => games = value);
                print('object');
              }))
          .onError((error, stackTrace) {
        setState(() {
          error = error.toString();
          loading = false;
        });
        print('object err' + error.toString());
      });
      setState(() => loading = false);
    } else {
      GameModel.getAllGame().then((value) {
        setState(() => games = value);
        print('object 2');
      }).onError((error, stackTrace) {
        setState(() {
          error = error.toString();
          loading = false;
        });
        print('object 2 err' + error.toString());
      });
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    getGame();
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: loading
          ? Center(child: Text('Loading...'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        primary: Color(0xffE8E6E6),
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () => {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2018, 3, 5),
                            maxTime: DateTime(2019, 6, 7), onConfirm: (date) {
                          setState(() => dateGame = date.toString());
                          getGame();
                        }, currentTime: DateTime.now(), locale: LocaleType.id)
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dateGame.length > 0
                                ? dateGame.substring(0, dateGame.indexOf(' '))
                                : 'Game today',
                            style: TextStyle(color: Colors.black),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: games.map((game) {
                      return ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Card(
                          color: Color(0xff6C63FF),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 20),
                                        child: CircleAvatar(
                                          radius: 35,
                                          backgroundImage: game.homeTeam!.logo,
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              game.homeTeam!.abbreviation,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              game.homeTeamScore.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: getScoreColors(
                                                  "home",
                                                  game.homeTeamScore ?? 0,
                                                  game.visitorTeamScore ?? 0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            game.visitorTeam!.abbreviation,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            game.visitorTeamScore.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: getScoreColors(
                                                "visitor",
                                                game.homeTeamScore ?? 0,
                                                game.visitorTeamScore ?? 0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundImage: game.visitorTeam!.logo,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
