import 'dart:convert';

import 'package:acoride/data/entities/settings_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant/constants.dart';

class SettingsProvider {

  Future<Map<String, dynamic>> getSettings() async {

    Map<String, dynamic> result = SettingsItem().toMap();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? settingsString = prefs.getString(prefSettings);

    if (settingsString != null) {
      try {
        result = json.decode(settingsString);
      }
      catch (e) {

      }
    }

    return result;
  }

  Future setSettings(SettingsItem settings) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefSettings, json.encode(settings.toMap()));
  }

}