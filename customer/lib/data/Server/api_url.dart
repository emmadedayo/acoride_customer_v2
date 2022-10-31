import 'package:acoride/core/constant/constants.dart';
class ApiUrl {
  ApiUrl._();


  static const String userRegistration = '${BASE_URL}api/v1/customer/registration';
  static const String verifyRegistration = '${BASE_URL}api/verify_phone';
  static const String resetAccount = '${BASE_URL}api/reset_account';
  static const String verifyResetAccount = '${BASE_URL}api/verify_reset_account';
  static const String changePassword = '${BASE_URL}api/change_password';
  static const String login = '${BASE_URL}api/v1/customer/login';

  static const String changePasswordAuth = '${BASE_URL}api/v1/changePassword';
  static const String updateProfile = '${BASE_URL}api/v1/updateProfile';
  static const String verifyEmail = '${BASE_URL}api/v1/verifyEmail';
  static const String getMe = '${BASE_URL}api/v1/getMe';
  static const String getDashboard = '${BASE_URL}api/v1/getDashboard';

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

  ////////////////// Ride Request ////////////////
  static const String requestRide = '${BASE_URL}api/v1/customer/requestRide';
  static const String createTrip = '${BASE_URL}api/v1/customer/createTrip';
  static const String getTrip = '${BASE_URL}api/v1/getTrip';
  static const String getTripAmount = '${BASE_URL}api/v1/customer/getTripAmount';


  //////////////// Cancellation ////////////////
  static const String getCancellation = '${BASE_URL}api/v1/getCancellationReasons';
  static const String cancelTrip = '${BASE_URL}api/v1/cancelRide';

  //////////////// Rating ////////////////
  static const String rate = '${BASE_URL}api/v1/rateRide';

  //////////////////// Ride History //////////////////
  static const String getPassengerHistory = '${BASE_URL}api/v1/customer/passengerHistory';


  //////////////// Mics ////////////////
  static const String getState = '${BASE_URL}api/get_state';


  ////////////////////// Get Billing ////////////////////////
  static const String getBill = '${BASE_URL}api/v1/getBill';
  static const String getVariation = '${BASE_URL}api/v1/getVariation';
  static const String getSmartName = '${BASE_URL}api/v1/getSmartCardDetails';
  static const String payBills = '${BASE_URL}api/v1/createTransaction';
}