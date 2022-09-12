import 'package:acoride/data/entities/settings_item.dart';
import 'package:acoride/data/repositories/settings_repository.dart';
import 'package:acoride/data/repositories/user_repository.dart';
import 'package:acoride/logic/states/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SettingsCubit extends Cubit<SettingsState> {

  UserRepository userRepository = UserRepository();

  SettingsCubit(SettingsState initialState) : super(initialState);

  getSettings() async {
    SettingsItem settings = await SettingsRepository().getSettings();
    emit(SettingsState(settings,));
  }

  setSettings(SettingsItem settingsItem) async {
    await SettingsRepository().setSettings(settingsItem);
    emit(SettingsState(settingsItem,));
  }

  toggleNotifications() async {
    state.settings.notifications = !state.settings.notifications;
    setSettings(state.settings);
  }


  //called once user logging out
  removeToken() async {
    state.settings.tokenPushed = false;
    setSettings(state.settings);
  }

}