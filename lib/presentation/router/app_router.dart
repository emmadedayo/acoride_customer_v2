import 'package:acoride/presentation/auth/base_auth_screen.dart';
import 'package:acoride/presentation/auth/change_password_screen.dart';
import 'package:acoride/presentation/auth/registration_screen.dart';
import 'package:acoride/presentation/auth/verify_phone_screen.dart';
import 'package:acoride/presentation/onboarding/onboardingscreen.dart';
import 'package:acoride/presentation/profile/emergency/emergency_screen.dart';
import 'package:acoride/presentation/profile/user_profile.dart';
import 'package:acoride/presentation/router/router_constant.dart';
import 'package:acoride/presentation/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';
import '../auth/login_screen.dart';
import '../auth/reset_account_screen.dart';
import '../home/bottom_screen.dart';
import '../profile/edit_profile/edit_user_profile.dart';
import '../profile/edit_profile/verify_email_screen.dart';
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
            builder: (_) => const ChangePasswordScreen()
        );
      case registrationScreenController:
        return MaterialPageRoute(
            builder: (_) => const RegistrationScreenController()
        );
      case resetAccountScreen:
        return MaterialPageRoute(
            builder: (_) => const ResetAccountScreen()
        );
      case verifyAccountScreen:
        return MaterialPageRoute(
            builder: (_) => const VerifyAccountScreen()
        );
      case walletScreen:
        return MaterialPageRoute(
            builder: (_) => const WalletScreen()
        );
      case addToWalletScreen:
        return MaterialPageRoute(
            builder: (_) => const AddToWalletScreen()
        );
      case profilePage:
        return MaterialPageRoute(
            builder: (_) => const ProfileSettingsScreen()
        );
      case emergencyContact:
        return MaterialPageRoute(
            builder: (_) => const EmergencyContactScreen()
        );

      case editProfile:
        return MaterialPageRoute(builder: (_) => EditProfileScreen(user: arguments!['user'],));
      case verifyEmail:
        return MaterialPageRoute(builder: (_) => VerifyEmailAccountScreen(user: arguments!['user'], email: arguments['email'],));
      default:
        return null;
    }
  }
}