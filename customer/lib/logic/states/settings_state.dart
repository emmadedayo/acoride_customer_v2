
import 'package:acoride/core/constant/enum.dart';
import 'package:acoride/data/entities/settings_item.dart';

class SettingsState {

  SettingsItem settings;
  SettingsResponse? response;
  bool isLoading;

  SettingsState(this.settings, {this.response, this.isLoading: false});

  SettingsState copy() {
    SettingsState copy = SettingsState(settings, isLoading: isLoading, response: response);
    return copy;
  }

}