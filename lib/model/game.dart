import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:nba/config/config.dart';
import 'package:nba/model/image.dart';
import 'package:nba/model/team.dart';

class GameModel {
  int? id;
  int? period;
  int? season;
  int? homeTeamScore;
  int? visitorTeamScore;
  String? status, date;
  TeamModel? homeTeam, visitorTeam;
  ImageProvider? logo;

  GameModel({
    this.id,
    this.period,
    this.homeTeam,
    this.homeTeamScore,
    this.status,
    this.season,
    this.date,
    this.visitorTeam,
    this.visitorTeamScore,
    this.logo,
  });

  TeamModel mapTeam(Map<String, dynamic> json, String team) {
    ImageModel image = new ImageModel();
    TeamModel teamData = TeamModel.fromJson(json[team]);

    return TeamModel(
      id: teamData.id,
      abbreviation: teamData.abbreviation,
      city: teamData.city,
      name: teamData.name,
      nickname: teamData.nickname,
      logo: image.getLogo(teamData.abbreviation),
    );
  }

  factory GameModel.fromJson(Map<String, dynamic> json) {
    TeamModel homeTeam = GameModel().mapTeam(json, "home_team");
    TeamModel visitorTeam = GameModel().mapTeam(json, "visitor_team");

    return GameModel(
      id: json["id"],
      period: json["period"],
      homeTeam: homeTeam,
      homeTeamScore: json["home_team_score"],
      status: json["status"],
      season: json["season"],
      date: json["date"],
      visitorTeam: visitorTeam,
      visitorTeamScore: json["visitor_team_score"],
    );
  }

  static Future<List<GameModel>> getAllGame() async {
    var response = await http.get(
      Uri.parse(Config().apiUrl + 'games'),
      headers: {
        "X-RapidAPI-Host": Config().apiHost,
        "X-RapidAPI-Key": Config().apiKey,
      },
    );

    var games = json.decode(response.body);
    List<dynamic> team = (games as Map<String, dynamic>)['data'];

    return team.map((data) => GameModel.fromJson(data)).toList();
  }

  static Future<List<GameModel>> getSeveralGame(int limit) async {
    var response = await http.get(
      Uri.parse(Config().apiUrl + 'games?per_page=$limit'),
      headers: {
        "X-RapidAPI-Host": Config().apiHost,
        "X-RapidAPI-Key": Config().apiKey,
      },
    );

    var games = json.decode(response.body);
    List<dynamic> team = (games as Map<String, dynamic>)['data'];

    return team.map((data) => GameModel.fromJson(data)).toList();
  }

  static Future<List<GameModel>> getGameByDate(String date) async {
    var response = await http.get(
      Uri.parse("${Config().apiUrl}games?date=$date"),
      headers: {
        "X-RapidAPI-Host": Config().apiHost,
        "X-RapidAPI-Key": Config().apiKey,
      },
    );

    var games = json.decode(response.body);
    List<dynamic> team = (games as Map<String, dynamic>)['data'];

    return team.map((data) => GameModel.fromJson(data)).toList();
  }
}
