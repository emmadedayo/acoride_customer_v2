import 'package:acoride/core/constant/constants.dart';
import 'package:acoride/core/constant/enum.dart';

class SettingsItem {

  String langCode,rideId;
  RideState rideState;
  bool isDarkMode, isFirstUse, notifications, tokenPushed,hasRide;

  SettingsItem({this.langCode: settingsLanguage, this.isDarkMode: false, this.isFirstUse: true, this.notifications: true,
    this.tokenPushed: false,this.hasRide:false,this.rideId:'',this.rideState:RideState.NONE});

  Map<String, dynamic> toMap() {
    return {
      settingsLanguage: langCode,
      settingsIsDarkMode: isDarkMode,
      settingsIsFirstUse: isFirstUse,
      settingsNotification: notifications,
      settingsTokenPushed: tokenPushed,
      'hasRide':hasRide,
      'rideId':rideId,
      'rideState':rideState
    };
  }

  static SettingsItem fromMap(Map<String, dynamic> map) {
    return SettingsItem(
      isDarkMode: map[settingsIsDarkMode],
      langCode: map[settingsLanguage],
      isFirstUse: map[settingsIsFirstUse]?? true,
      notifications: map[settingsNotification]?? true,
      tokenPushed: map[settingsTokenPushed]?? false,
      hasRide: map['hasRide'],
      rideId: map['rideId'],
      rideState: map['rideState'],
    );
  }

}