import 'package:bloc/bloc.dart';
import '../../data/repositories/user_repository.dart';
import '../states/registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState>{
  UserRepository userRepository = UserRepository();
  RegistrationCubit(RegistrationState initialState) : super(initialState);

  signUp() async {
    emit(state.copy());
    state.isLoading = true;
    emit(state.copy());
    var result = await userRepository.resetAccount({
      'name': state.nameController.text,
      'email': state.emailController.text,
      'phone_number': state.phoneController.text,
      'password': state.passwordController.text,
      'confirm_password': state.confirmPasswordController.text
    });
    print("object  ${result?.result}");
    if (result?.errorCode == 404) {
      state.message = result?.message;
      state.hasError = true;
      state.isLoading = false;
      emit(state.copy());
    } else {
      state.message = result?.message;
      state.hasError = false;
      state.isLoading = false;
      emit(state.copy());
    }
  }

  clearError() {
    state.hasError = false;
    state.isLoading = false;
    state.message = '';
    emit(state.copy());
  }

}