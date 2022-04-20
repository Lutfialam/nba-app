import 'package:flutter/widgets.dart';

class ImageModel {
  String title;

  ImageModel({
    this.title = '',
  });

  ImageProvider getLogo(String code) {
    Image image = Image.asset(
      "assets/images/$code.png",
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Image.asset(
          "assets/images/nba.jpg",
        );
      },
    );

    ImageProvider result = image.image;
    return result;
  }
}
