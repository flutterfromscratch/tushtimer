import 'package:shared_preferences/shared_preferences.dart';
// import 'package:standtimer/database/database.dart' as database;

class PreferencesService {
  // Preferences._privateConstructor() {
  //   print('dd');
  // }

  // static final Preferences instance = Preferences._privateConstructor();

  static const String FIRST_RUN = "FirstRun";

  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    // await database.init();
  }

  bool get isFirstRun => _sharedPreferences.getBool(FIRST_RUN);
  Future<void> setFirstRun() async {
    await _sharedPreferences.setBool(FIRST_RUN, true);
  }
  // set isFirstRun(bool val) async => _sharedPreferences.setBool(FIRST_RUN, va);

}
