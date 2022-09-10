import 'package:acoride/data/entities/settings_item.dart';
import 'package:acoride/data/provider/settings_provider.dart';

class SettingsRepository {

  SettingsProvider provider = SettingsProvider();

  Future<SettingsItem> getSettings() async {
    Map<String, dynamic> map = await provider.getSettings();
    SettingsItem settings = SettingsItem.fromMap(map);
    return settings;
  }

  Future setSettings(SettingsItem settingsItem) async {
    await provider.setSettings(settingsItem);
  }

}