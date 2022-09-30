import 'package:bloc/bloc.dart';
import '../../data/repositories/user_repository.dart';
import '../states/verifiy_phone_state.dart';


class VerifyPhoneCubit extends Cubit<VerifyPhoneState>{
  UserRepository userRepository = UserRepository();

  VerifyPhoneCubit(VerifyPhoneState initialState) : super(initialState);

  verifyAccount(phone) async {
    state.isLoading = true;
    emit(state.copy());
    var result = await userRepository.verifyAccount({
      'phone_number': phone,
      'otp': state.otpController.text
    });
    if (result.errorCode! >= 400) {
      state.message = result.message;
      state.hasError = true;
      state.isLoading = false;
    } else {
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