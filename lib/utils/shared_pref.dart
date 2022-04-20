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

  Future removeIdFromBookmark(String id) async {
    final SharedPreferences prefs = await _prefs;
    List bookMarkIds = await this.getBookMarkList();

    List<String> newBookMarkIds =
        bookMarkIds.where((element) => element != id).toList().cast();

    prefs.setStringList("bookmark_id", newBookMarkIds);
  }

  Future<bool> bookMarkHasId(String id) async {
    List bookMarkIds = await this.getBookMarkList();

    List<String> newBookMarkIds =
        bookMarkIds.where((element) => element == id).toList().cast();

    return newBookMarkIds.length > 0;
  }

  Future<bool> isNotFirstTime() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool("is_not_first_time") ?? false;
  }

  Future setIsNotFirstTime() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool("is_not_first_time", true);
  }
}
