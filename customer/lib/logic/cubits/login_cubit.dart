import 'package:acoride/core/helper/helper_config.dart';
import 'package:acoride/logic/states/login_state.dart';
import 'package:bloc/bloc.dart';

import '../../data/repositories/user_repository.dart';

class LoginCubit extends Cubit<LoginState>{
  UserRepository userRepository = UserRepository();
  LoginCubit(LoginState initialState) : super(initialState);

  loginIn() async {
    emit(state.copy());
    state.isLoading = true;
    emit(state.copy());
    var result = await userRepository.auth({
      'phone_number': state.phoneController.text,
      'password': state.passwordController.text,
      "device_token": await HelperConfig.saveDeviceToken(),
    });
    if (result.errorCode! >= 400) {
      state.message = result.message;
      state.hasError = true;
      state.isLoading = false;
    } else {
      userRepository.setCurrentUser(result.result!);
      state.user = result.result;
    }
    state.isLoading = false;
    emit(state.copy());
  }

  clearError() {
    state.hasError = false;
    state.isLoading = false;
    state.message = '';
    emit(state.copy());
  }

}