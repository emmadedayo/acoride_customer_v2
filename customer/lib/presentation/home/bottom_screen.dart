import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/presentation/dashbaord/dashboard.dart';
import 'package:acoride/presentation/history/ride_history.dart';
import 'package:acoride/presentation/profile/user_profile.dart';
import 'package:acoride/presentation/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class RootBottom extends StatefulWidget {
  const RootBottom({Key? key}) : super(key: key);

  @override
  RootBottomStates createState() => RootBottomStates();
}

class RootBottomStates extends State<RootBottom>
    with SingleTickerProviderStateMixin {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTabIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          unselectedFontSize: 10,
          selectedFontSize: 15,
          selectedItemColor: HelperColor.primaryColor,
          unselectedIconTheme: const IconThemeData(
              color: Colors.white,
              size: 20.0
          ),
          selectedIconTheme: const IconThemeData(
              color: Colors.white,
              size: 20.0
          ),
          unselectedItemColor: HelperColor.freyColor,
          selectedLabelStyle: HelperStyle.textStyleTwo(context, HelperColor.primaryColor, 12.sp, FontWeight.normal),
          unselectedLabelStyle: HelperStyle.textStyleTwo(context, HelperColor.primaryColor, 12.sp, FontWeight.normal),
          backgroundColor: const Color(0xffF8FAFA),
          onTap: (index) {
            _selectedTabIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Iconsax.home, color: _selectedTabIndex == 0? HelperColor.primaryColor: HelperColor.freyColor,),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.book, color: _selectedTabIndex == 1? HelperColor.primaryColor: HelperColor.freyColor,),
                label: 'Bookings'
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.wallet, color: _selectedTabIndex == 2? HelperColor.primaryColor: HelperColor.freyColor,),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.user, color: _selectedTabIndex == 3? HelperColor.primaryColor: HelperColor.freyColor,),
                label: 'Profile'
            ),
          ]),
      // drawer: new MenuScreens(activeScreenName: screenName),
      body: Center(
        child: getWidget(),
      ),
      // drawer: Menu(),
    );
  }

  getWidget() {
    switch (_selectedTabIndex) {
      case 0:
        return const MainHomePage();
      case 1:
        return const RideHistoryScreen();
      case 2:
        return const WalletScreen();
      case 3:
        return const ProfileSettingsScreen();
    }
  }
}
