import 'package:acoride/data/repositories/misc_repository.dart';
import 'package:bloc/bloc.dart';
import '../../data/model/state_model.dart';
import '../../data/repositories/user_repository.dart';
import '../states/registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState>{
  UserRepository userRepository = UserRepository();
  MiscRepository miscRepository = MiscRepository();

  RegistrationCubit(RegistrationState initialState) : super(initialState) {
    initData();
  }

  Future initData() async {
    await initState();
  }

  initState() async {
    state.stateLoading = true;
    emit(state.copy());
    state.stateModel = await miscRepository.getState();
    state.stateLoading = false;
    emit(state.copy());
  }

  signUp() async {
    state.isLoading = true;
    emit(state.copy());
    var result = await userRepository.signUp({
      'name': state.nameController.text,
      'email': state.emailController.text,
      'phone_number': state.phoneController.text,
      'state_id':state.selectedState?.id.toString(),
      'password': state.passwordController.text,
      'confirm_password': state.passwordController.text
    });
    if ((result.errorCode ?? 0) >= 400) {
      state.message = result.message;
      state.hasError = true;
      state.isLoading = false;
    } else {
      state.message = result.message;
      state.success = true;
      state.hasError = false;
      state.isLoading = false;
    }
    emit(state.copy());
  }

  clearError() {
    state.hasError = false;
    state.isLoading = false;
    state.message = '';
    emit(state.copy());
  }

  filterName(String name){
    state.name = name;
    emit(state.copy());
    filterState();
  }

  void filterState() {
    if(state.name.isNotEmpty && state.name.length > 2) {
      state.stateModel = [];
      state.stateModel.addAll(state.stateModel);
      state.stateModel.removeWhere((element) => !element.name!.toLowerCase().contains(state.name.toLowerCase()));
    }else{
      state.stateModel = [];
      state.stateModel.addAll(state.stateModel);
    }
    emit(state.copy());
  }

  setStateName(StateModel stateModel){
    state.selectedState = stateModel;
    state.stateController.text = stateModel.name!;
    emit(state.copy());
  }

}