import 'package:acoride/logic/states/change_password_state.dart';
import 'package:bloc/bloc.dart';

import '../../data/repositories/user_repository.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState>{
  UserRepository userRepository = UserRepository();
  ChangePasswordCubit(ChangePasswordState initialState) : super(initialState);

  changePassword() async {
    state.isLoading = true;
    emit(state.copy());
    dynamic result = await userRepository.changePasswordAuth({
      'old_password': state.oldPassword.text,
      'password': state.newPassword.text,
      'password_confirmation': state.confirmPassword.text,
    });
    if (result?.errorCode >= 400) {
      state.message = result?.message;
      state.hasError = true;
      state.isLoading = false;
    }else{
      state.message = result?.message;
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