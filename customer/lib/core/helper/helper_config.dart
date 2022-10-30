import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:firebase_messaging/firebase_messaging.dart';
import "package:intl/intl.dart";
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class HelperConfig{

  static List<LatLng> convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  static List decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
    // repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negative then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    /*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    // print(lList.toString());

    return lList;
  }

  static int getTimeStampDividedByOneThousand(DateTime dateTime) {
    final double dividedByOneThousand = dateTime.millisecondsSinceEpoch / 1000;
    final int doubleToInt = dividedByOneThousand.round();
    return doubleToInt;
  }

  static const String apiKey = 'AIzaSyCmBgWETLm4Ol9frxnnqXW40G2_lc1B558';

  static const String payStackPublicKey = 'pk_test_0263338ba4246920824bd81ea2315ee3bcadb53a';

  static const String payStackTestKey = 'sk_test_05660c8db9f95d8c3354054d9cebc4bc17de3ed6';

  static String getPngImage(String imageName){
    return 'assets/images/$imageName.png';
  }

  static String splitName(String imageName){
    return imageName.split(' ')[1];
  }

  static Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }

  static Future<bool> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    try {
      return true;
    } catch (e) {
      return false;
    }
  }

  static String uuid() {
    return const Uuid().v4();
  }

  static Future<void> makePhoneCall(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static String shortHistory(String dateTime){
    final DateTime date = DateTime.parse(dateTime).toLocal();
    return DateFormat('MMM d, h:mm a').format(date);
  }

  static currencyFormat(String amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '₦').format(double.parse(amount));
  }

  static paymentReformat(String paymentFor){
    if(paymentFor == "bills"){
      return "Bills Payment";
    }else if(paymentFor == "wallet") {
      return "Wallet Top Up";
    }else if(paymentFor == "bike") {
      return "Ride Payment";
    }else if(paymentFor == "withdrawal") {
      return "Withdrawal Payment";
    }else if(paymentFor == "transfer") {
      return "Transfer Payment";
    }else if(paymentFor == "loan") {
      return "Acoride Loan";
    }else if(paymentFor == "dues") {
      return "Acoride Dues";
    }else{
      return "Acoride Payment";
    }
  }

  static Future<String?> saveDeviceToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final String? fcmToken = await firebaseMessaging.getToken();
    return fcmToken;
  }
}