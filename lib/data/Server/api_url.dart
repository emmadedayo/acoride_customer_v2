import 'package:acoride/core/constant/constants.dart';
class ApiUrl {
  ApiUrl._();


  static const String userRegistration = '${BASE_URL}api/customer/v1/registration';
  static const String verifyRegistration = '${BASE_URL}api/verify_phone';
  static const String resetAccount = '${BASE_URL}api/reset_account';
  static const String verifyResetAccount = '${BASE_URL}api/verify_reset_account';
  static const String changePassword = '${BASE_URL}api/change_password';
  static const String login = '${BASE_URL}api/v1/customer/login';

  static const String updateProfile = '${BASE_URL}api/v1/updateProfile';
  static const String verifyEmail = '${BASE_URL}api/v1/verifyEmail';
  static const String getMe = '${BASE_URL}api/v1/getMe';

  //////////////// Card ////////////////
  static const String saveCard = '${BASE_URL}api/v1/saveCard';
  static const String deleteCard = '${BASE_URL}api/v1/deleteCard';
  static const String getCard = '${BASE_URL}api/v1/getCard';

  //////////////// Transaction ////////////////
  static const String getTransaction = '${BASE_URL}api/v1/getMyTransaction';
  static const String topUpWithCard = '${BASE_URL}api/v1/topUpWithCard';
  static const String paystackTopUp = '${BASE_URL}api/v1/paystackTopUp';

  //////////////// Emergency ////////////////
  static const String getEmergency = '${BASE_URL}api/v1/getEmergencyContact';
  static const String deleteEmergency = '${BASE_URL}api/v1/deleteEmergencyContact';
  static const String updateEmergency = '${BASE_URL}api/v1/updateEmergencyContact';
  static const String addEmergency = '${BASE_URL}api/v1/saveEmergencyContact';

}