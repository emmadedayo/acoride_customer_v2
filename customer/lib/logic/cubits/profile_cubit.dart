import 'package:acoride/logic/states/profile_state.dart';
import 'package:bloc/bloc.dart';

import '../../data/repositories/user_repository.dart';

class ProfileCubit extends Cubit<ProfileState>{
  UserRepository userRepository = UserRepository();
  ProfileCubit(ProfileState initialState) : super(initialState);

  editProfile() async {
    emit(state.copy());
    state.isLoading = true;
    emit(state.copy());
    var result = await userRepository.updateProfile({
      'phone_number': state.phoneController.text,
      'email': state.emailController.text,
      'name': state.nameController.text,
    }, await userRepository.getToken());
    if (result.errorCode! >= 400) {
      if(result.message == '0000') {
        state.hasError = true;
        state.isLoading = false;
        state.user = null;
        state.verifyEmail = true;
        state.message = 'Please verify your email';
      }else{
        state.message = result.message;
        state.hasError = true;
        state.isLoading = false;
      }
    } else {
      state.message = result.message;
      state.hasError = false;
      state.isLoading = false;
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