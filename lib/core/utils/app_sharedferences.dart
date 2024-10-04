import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  Future<void> clearSharedPreferencesData(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('device_token');
    await prefs.remove('access_token');
    await prefs.remove('userId');
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('phone');
    Constants.userToken='';
    Constants.logInUserId='';
    Constants.email='';
    Constants.phone='';
    Constants.deviceToken='';

  }
}