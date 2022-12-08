import 'package:acoride/core/helper/helper_config.dart';
class ApiUrl {
  ApiUrl._();


  static  String userRegistration = '${HelperConfig.getUrlEnvironment()}api/v1/customer/registration';
  static  String verifyRegistration = '${HelperConfig.getUrlEnvironment()}api/verify_phone';
  static  String resetAccount = '${HelperConfig.getUrlEnvironment()}api/reset_account';
  static  String resendOtp = '${HelperConfig.getUrlEnvironment()}api/reset_account';
  static  String verifyResetAccount = '${HelperConfig.getUrlEnvironment()}api/verify_reset_account';
  static  String changePassword = '${HelperConfig.getUrlEnvironment()}api/change_password';
  static  String login = '${HelperConfig.getUrlEnvironment()}api/v1/customer/login';

  static  String changePasswordAuth = '${HelperConfig.getUrlEnvironment()}api/v1/changePassword';
  static  String updateProfile = '${HelperConfig.getUrlEnvironment()}api/v1/updateProfile';
  static  String verifyEmail = '${HelperConfig.getUrlEnvironment()}api/v1/verifyEmail';
  static  String getMe = '${HelperConfig.getUrlEnvironment()}api/v1/getMe';
  static  String getDashboard = '${HelperConfig.getUrlEnvironment()}api/v1/getDashboard';

  //////////////// Card ////////////////
  static  String saveCard = '${HelperConfig.getUrlEnvironment()}api/v1/saveCard';
  static  String deleteCard = '${HelperConfig.getUrlEnvironment()}api/v1/deleteCard';
  static  String getCard = '${HelperConfig.getUrlEnvironment()}api/v1/getCard';

  //////////////// Transaction ////////////////
  static  String getTransaction = '${HelperConfig.getUrlEnvironment()}api/v1/getMyTransaction';
  static  String topUpWithCard = '${HelperConfig.getUrlEnvironment()}api/v1/topUpWithCard';
  static  String paystackTopUp = '${HelperConfig.getUrlEnvironment()}api/v1/paystackTopUp';

  //////////////// Emergency ////////////////
  static  String getEmergency = '${HelperConfig.getUrlEnvironment()}api/v1/getEmergencyContact';
  static  String deleteEmergency = '${HelperConfig.getUrlEnvironment()}api/v1/deleteEmergencyContact';
  static  String updateEmergency = '${HelperConfig.getUrlEnvironment()}api/v1/updateEmergencyContact';
  static  String addEmergency = '${HelperConfig.getUrlEnvironment()}api/v1/saveEmergencyContact';

  ////////////////// Ride Request ////////////////
  static  String requestRide = '${HelperConfig.getUrlEnvironment()}api/v1/customer/requestRide';
  static  String createTrip = '${HelperConfig.getUrlEnvironment()}api/v1/customer/createTrip';
  static  String getTrip = '${HelperConfig.getUrlEnvironment()}api/v1/getTrip';
  static  String getTripAmount = '${HelperConfig.getUrlEnvironment()}api/v1/customer/getTripAmount';


  //////////////// Cancellation ////////////////
  static  String getCancellation = '${HelperConfig.getUrlEnvironment()}api/v1/getCancellationReasons';
  static  String cancelTrip = '${HelperConfig.getUrlEnvironment()}api/v1/cancelRide';

  //////////////// Rating ////////////////
  static  String rate = '${HelperConfig.getUrlEnvironment()}api/v1/rateRide';

  //////////////// Emergency ////////////////
  static  String emergencyAlert = '${HelperConfig.getUrlEnvironment()}api/v1/panicService';

  //////////////////// Ride History //////////////////
  static  String getPassengerHistory = '${HelperConfig.getUrlEnvironment()}api/v1/customer/passengerHistory';


  //////////////// Mics ////////////////
  static  String getState = '${HelperConfig.getUrlEnvironment()}api/get_state';


  ////////////////////// Get Billing ////////////////////////
  static  String getBill = '${HelperConfig.getUrlEnvironment()}api/v1/getBill';
  static  String getVariation = '${HelperConfig.getUrlEnvironment()}api/v1/getVariation';
  static  String getSmartName = '${HelperConfig.getUrlEnvironment()}api/v1/getSmartCardDetails';
  static  String payBills = '${HelperConfig.getUrlEnvironment()}api/v1/createTransaction';


  ////////////////////// Delivery Billing ////////////////////////
  static  String getUserDelivery = '${HelperConfig.getUrlEnvironment()}api/v1/customer/getUserDeliveryAmount';

  ////////////////////// App Settings ////////////////////////
  static  String getVersion = '${HelperConfig.getUrlEnvironment()}api/get_version';
}