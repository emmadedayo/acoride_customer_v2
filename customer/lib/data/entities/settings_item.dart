import 'package:acoride/core/constant/constants.dart';

class SettingsItem {

  String langCode;
  bool isDarkMode, isFirstUse, notifications, tokenPushed;

  SettingsItem({this.langCode: settingsLanguage, this.isDarkMode: false, this.isFirstUse: true, this.notifications: true,
    this.tokenPushed: false});

  Map<String, dynamic> toMap() {
    return {
      settingsLanguage: langCode,
      settingsIsDarkMode: isDarkMode,
      settingsIsFirstUse: isFirstUse,
      settingsNotification: notifications,
      settingsTokenPushed: tokenPushed,
    };
  }

  static SettingsItem fromMap(Map<String, dynamic> map) {
    return SettingsItem(
      isDarkMode: map[settingsIsDarkMode],
      langCode: map[settingsLanguage],
      isFirstUse: map[settingsIsFirstUse]?? true,
      notifications: map[settingsNotification]?? true,
      tokenPushed: map[settingsTokenPushed]?? false,
    );
  }

}