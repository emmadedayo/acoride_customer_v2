import 'package:acoride/presentation/auth/base_auth_screen.dart';
import 'package:acoride/presentation/auth/change_password_screen.dart';
import 'package:acoride/presentation/auth/registration_screen.dart';
import 'package:acoride/presentation/auth/verify_forgot_password.dart';
import 'package:acoride/presentation/auth/verify_phone_screen.dart';
import 'package:acoride/presentation/bills/Cable/cable_screen.dart';
import 'package:acoride/presentation/bills/Data/data_screen.dart';
import 'package:acoride/presentation/debit_card/debit_card_screen.dart';
import 'package:acoride/presentation/onboarding/onboardingscreen.dart';
import 'package:acoride/presentation/order/order_rate_driver.dart';
import 'package:acoride/presentation/order/order_trip_screen.dart';
import 'package:acoride/presentation/profile/emergency/emergency_screen.dart';
import 'package:acoride/presentation/profile/security/change_password.dart';
import 'package:acoride/presentation/profile/user_profile.dart';
import 'package:acoride/presentation/router/router_constant.dart';
import 'package:acoride/presentation/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';

import '../auth/login_screen.dart';
import '../auth/reset_account_screen.dart';
import '../bills/Airtime/airtime_screen.dart';
import '../bills/Electricity/electricity_screen.dart';
import '../home/bottom_screen.dart';
import '../profile/edit_profile/edit_user_profile.dart';
import '../profile/edit_profile/verify_email_screen.dart';
import '../success/ride_delete_screen.dart';
import '../success/success_full_screen.dart';
import '../wallet/add_to_wallet.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {

    Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case pageHome:
        return MaterialPageRoute(
            builder: (_) => const RootBottom()
        );
      case onBoardingPage:
        return MaterialPageRoute(
            maintainState: false,
            builder: (_) => const OnBoardingPage()
        );
      case baseAuthScreen:
        return MaterialPageRoute(
            builder: (_) => const BaseAuthScreen()
        );
      case loginScreenController:
        return MaterialPageRoute(
            builder: (_) => const LoginScreenController()
        );
      case changePasswordScreen:
        return MaterialPageRoute(
            builder: (_) => ChangePasswordScreen(phone: arguments!['phone'],)
        );
      case registrationScreenController:
        return MaterialPageRoute(
            builder: (_) => const RegistrationScreenController()
        );
      case resetAccountScreen:
        return MaterialPageRoute(
            builder: (_) => const ResetAccountScreen()
        );
      case verifyResetPassword:
        return MaterialPageRoute(
            builder: (_) => VerifyForgotPassword(phone: arguments!['phone'],)
        );
      case verifyAccountScreen:
        return MaterialPageRoute(
            builder: (_) => VerifyAccountScreen(phone: arguments!['phone'])
        );
      case walletScreen:
        return MaterialPageRoute(
            builder: (_) => const WalletScreen()
        );
      case addToWalletScreen:
        return MaterialPageRoute(
            builder: (_) => const AddToWalletScreen()
        );
      case airtimeScreen:
        return MaterialPageRoute(
            builder: (_) => const AirtimeScreenIndex()
        );
      case successScreen:
        return MaterialPageRoute(
            builder: (_) => SuccessFullScreen(message: arguments!['message'],)
        );
      case dataScreen:
        return MaterialPageRoute(
            builder: (_) => const DataScreenIndex()
        );
      case cableScreen:
        return MaterialPageRoute(
            builder: (_) => const CableScreenIndex()
        );
      case electricityScreen:
        return MaterialPageRoute(
            builder: (_) => const ElectricityScreen()
        );
      case profilePage:
        return MaterialPageRoute(
            builder: (_) => const ProfileSettingsScreen()
        );
      case emergencyContact:
        return MaterialPageRoute(
            builder: (_) => const EmergencyContactScreen()
        );
      case card:
        return MaterialPageRoute(
            builder: (_) => const CardScreenIndex()
        );
      case changePassword:
        return MaterialPageRoute(
            builder: (_) => const ChangePasswordScreenTwo()
        );
      case editProfile:
        return MaterialPageRoute(builder: (_) => EditProfileScreen(user: arguments!['user']));
      case startTrip:
        return MaterialPageRoute(builder: (_) => OrderTripScreen(rideRequestModel: arguments!['user']));
      case endTrip:
        return MaterialPageRoute(builder: (_) => OrderRateDriver(rideRequestModel: arguments!['user'],amountToPay: arguments['amount'],));
      case verifyEmail:
        return MaterialPageRoute(builder: (_) => VerifyEmailAccountScreen(user: arguments!['user'], email: arguments['email'],));
    /// Trip router
      case tripDeleteScreen:
        return MaterialPageRoute(
            builder: (_) => const TripDeleteScreen()
        );
      default:
        return null;
    }
  }
}