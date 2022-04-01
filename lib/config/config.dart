class Config {
  final String apiUrl = 'https://free-nba.p.rapidapi.com/';
  final String apiHost = "free-nba.p.rapidapi.com";
  final String apiKey = "d43b7bfdfcmsh33d8449487581aep15f1e2jsn0ca35675627d";
  final String imageAPI = "https://serpapi.com/playground?q=";
  final String imageAPIKey =
      "cecb7651e4fd0d75b9f3d34467b55e0a5eaa6fa0476541f479f9f88328e54003";
  // final String apiUrl = 'https://www.balldontlie.io/api/v1/';

  String getImageLink(String title) {
    return "https://serpapi.com/search.json?q="+ title +"&tbm=isch&ijn=0&api_key=" +
        imageAPIKey;
    // return imageAPI + title + "&tbm=isch&ijn=0&api_key=" + imageAPIKey;
  }
}
