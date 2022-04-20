import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  final String apiUrl = dotenv.get("API_URL");
  final String apiHost = dotenv.get("API_HOST");
  final String apiKey = dotenv.get("API_KEY");
}
