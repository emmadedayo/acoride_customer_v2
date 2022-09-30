import 'package:bloc/bloc.dart';
import '../../data/repositories/user_repository.dart';
import '../states/forgot_password_state.dart';


class ForgotPasswordCubit extends Cubit<ForgotPasswordState>{
  UserRepository userRepository = UserRepository();

  ForgotPasswordCubit(ForgotPasswordState initialState) : super(initialState);

  verifyResetAccount() async {
    state.isLoading = true;
    emit(state.copy());
    var result = await userRepository.resetAccount({
      'phone_number': state.phoneController.text,
    });
    if ((result?.errorCode ?? 0) >= 400) {
      state.message = result?.message;
      state.hasError = true;
      state.isLoading = false;
    } else {
      state.hasError = false;
      state.isLoading = false;
    }
    state.isLoading = false;
    emit(state.copy());
  }


  verifyResetAccountOtp(phoneNumber) async {
    state.isLoading = true;
    emit(state.copy());
    var result = await userRepository.resetAccount({
      'phone_number': phoneNumber,
      'otp': state.otpController.text,
    });
    if ((result?.errorCode ?? 0) >= 400) {
      state.message = result?.message;
      state.hasError = true;
      state.isLoading = false;
    } else {
      state.hasError = false;
      state.isLoading = false;
    }
    state.isLoading = false;
    emit(state.copy());
  }


  resetAccount(phoneNumber) async {
    state.isLoading = true;
    emit(state.copy());
    var result = await userRepository.resetAccount({
      "phone_number":phoneNumber,
      "password": state.passwordController.text,
      "password_confirmation": state.confirmPasswordController.text,
    });
    if ((result?.errorCode ?? 0) >= 400) {
      state.message = result?.message;
      state.hasError = true;
      state.isLoading = false;
    } else {
      state.hasError = false;
      state.isLoading = false;
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