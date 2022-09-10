import 'package:acoride/logic/states/verify_email_state.dart';
import 'package:bloc/bloc.dart';
import '../../data/repositories/user_repository.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState>{
  UserRepository userRepository = UserRepository();
  VerifyEmailCubit(VerifyEmailState initialState) : super(initialState);

  verifyEditProfile() async {
    emit(state.copy());
    state.isLoading = true;
    emit(state.copy());
    var result = await userRepository.verifyEmail({
      'phone_number': state.phoneController.text,
      'email': state.emailController.text,
      'name': state.nameController.text,
      'otp': state.otpController.text
    }, await userRepository.getToken());
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