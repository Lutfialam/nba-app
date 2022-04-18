import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:nba/config/config.dart';
import 'package:nba/model/image.dart';

class TeamModel {
  int? id;
  String name, nickname, abbreviation, city;
  ImageProvider? logo;

  TeamModel({
    this.id,
    this.name = '',
    this.nickname = '',
    this.abbreviation = '',
    this.city = '',
    this.logo,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    ImageModel image = new ImageModel();

    return TeamModel(
      id: json["id"],
      name: json["full_name"],
      nickname: json["name"],
      abbreviation: json["abbreviation"],
      city: json["city"],
      logo: image.getLogo(json['abbreviation']),
    );
  }

  static Future<List<TeamModel>> getAllTeam() async {
    var response =
        await http.get(Uri.parse(Config().apiUrl + 'teams'), headers: {
      "X-RapidAPI-Host": Config().apiHost,
      "X-RapidAPI-Key": Config().apiKey,
    });

    var teams = json.decode(response.body);
    List<dynamic> team = (teams as Map<String, dynamic>)['data'];

    return team.map((data) => TeamModel.fromJson(data)).toList();
  }

  static Future<TeamModel> getTeamById(int id) async {
    var response = await http
        .get(Uri.parse(Config().apiUrl + 'teams/' + id.toString()), headers: {
      "X-RapidAPI-Host": Config().apiHost,
      "X-RapidAPI-Key": Config().apiKey,
    });
    var teams = json.decode(response.body);

    return TeamModel.fromJson(teams);
  }
}
