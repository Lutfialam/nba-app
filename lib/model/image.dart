import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:nba/config/config.dart';

class ImageModel {
  String title;

  ImageModel({
    this.title = '',
  });

  static Future<String> getImage(String title) async {
    var response = await http.get(Uri.parse(Config().getImageLink(title)));
    var image = json.decode(response.body);
    // print(response.body);
    // List imgList = (image as Map<String, dynamic>)['suggested_searches'];

    // print('object');
    print(image['suggested_searches'][0]['link']);
    // print('object');
    return image['suggested_searches'][0]['link'];
  }

  ImageProvider getLogo(String code) {
    ImageProvider image;
    try {
      image = AssetImage("assets/images/$code.png");
    } catch (e) {
      print(e.toString());
      image = AssetImage('assets/images/nba.jpg');
    }
    return image;
  }
}
