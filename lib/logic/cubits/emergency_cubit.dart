import 'package:acoride/data/repositories/emergency_repository.dart';
import 'package:acoride/logic/states/emergency_state.dart';
import 'package:bloc/bloc.dart';

class EmergencyCubit extends Cubit<EmergencyState>{
  EmergencyRepository emergencyRepository = EmergencyRepository();

  EmergencyCubit(EmergencyState initialState) : super(initialState) {
    initState();
  }

  initState() async {
    state.isLoading = true;
    emit(state.copy());

    state.emergency = await emergencyRepository.get();

    state.isLoading = false;
    emit(state.copy());
  }

  edit() async {
    emit(state.copy());
    state.isLoading = true;
    state.isUpdated = false;
    var result = await emergencyRepository.updateEmergency({
      'emergency_name': state.nameController.text,
      'emergency_address': state.addressController.text,
      'emergency_phone': state.phoneController.text,
      'id': state.emergencyModel!.id
    });
    if (result?.errorCode == 400) {
      state.message = result?.message;
      state.hasError = true;
      state.isLoading = false;
      state.isUpdated = false;
    }else{
      state.message = result?.message;
      state.isUpdated = true;
    }
    state.isLoading = false;
    emit(state.copy());
  }

  save() async {
    state.addEmergency = true;
    emit(state.copy());
    var result = await emergencyRepository.addEmergency({
      'emergency_name': state.nameController.text,
      'emergency_address': state.addressController.text,
      'emergency_phone': state.phoneController.text,
    });
    if (result.errorCode == 400) {
      state.message = result.message;
      state.hasError = true;
      state.addEmergency = false;
    } else {
      state.addEmergency = false;
      state.message = result.message;
      state.emergencyModel = result.result;
      state.emergency.add(result.result!);
    }
    state.addEmergency = false;
    emit(state.copy());
  }

  delete(id) async {
    state.isLoading = true;
    emit(state.copy());
    var result = await emergencyRepository.deleteEmergency({
      'id': id,
    });
    if (result?.errorCode == 400) {
      state.message = result?.message;
      state.hasError = true;
      state.isLoading = false;
    }
    state.emergency.removeWhere((element) => element.id == id);
    state.isLoading = false;
    emit(state.copy());
  }


  clearError() {
    state.isLoading = true;
    state.message = '';
    emit(state.copy());
  }
}