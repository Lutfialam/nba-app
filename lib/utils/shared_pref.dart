import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future addBookMarkId(String value) async {
    print(value);
    final SharedPreferences prefs = await _prefs;

    List bookMarkIds = await this.getBookMarkList();

    if (bookMarkIds.length > 0) {
      List hasId =
          bookMarkIds.where((element) => element.toString() == value).toList();
      if (hasId.length <= 0) {
        prefs.setStringList("bookmark_id", <String>[...bookMarkIds, value]);
      }
    } else {
      prefs.setStringList("bookmark_id", <String>[value]);
    }
  }

  Future<List<String>> getBookMarkList() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getStringList("bookmark_id") ?? [];
  }
}
