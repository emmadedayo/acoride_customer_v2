import 'dart:io';

import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/Service/place_bloc_service.dart';
import 'package:acoride/data/model/placeItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../order/order_confirmation_screen.dart';

class MapSearchAddress extends StatefulWidget {
  final String nameAddressFrom;
  final CameraPosition addressFrom;

  const MapSearchAddress(this.nameAddressFrom, this.addressFrom, {Key? key}) : super(key: key);

  @override
  MapSearchAddressState createState() => MapSearchAddressState();
}

class MapSearchAddressState extends State<MapSearchAddress> {
  var addressFrom, addressTo;
  var placeBloc = PlaceBlocService();
  String valueFrom = '', valueTos = '';
  bool checkAutoFocus = false, inputFrom = false, inputTos = false;
  FocusNode nodeFrom = FocusNode();
  FocusNode nodeTos = FocusNode();
  List<Map<String, dynamic>> dataFrom = [];
  List<Map<String, dynamic>> dataTo = [];

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      iosContentBottomPadding: true,
      iosContentPadding: true,
      appBar: PlatformAppBar(
        title: Text("Request Ride",style: HelperStyle.textStyle(
            context,
            HelperColor.black,
            14,
            FontWeight.w400),),
        material: (_, __) => MaterialAppBarData(
          elevation: 0,
          iconTheme: const IconThemeData(
            color: HelperColor.black, //change your color here
          ),
          //automaticallyImplyLeading: true,
        ),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        top: Platform.isIOS? false : true,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                 // color: HelperColor.primaryLightColor,
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0),)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Form(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 20,
                                  child: TextField(
                                    style: HelperStyle.textStyle(context,HelperColor.black,14,FontWeight.normal),
                                    decoration:  InputDecoration(
                                      filled: true,
                                      prefixIcon: const Icon(Iconsax.global_search,color: HelperColor.black,),
                                      fillColor: HelperColor.freyColor.withOpacity(0.1),
                                      hintText: "Your pickup location",
                                      hintStyle: HelperStyle.textStyle(context,HelperColor.black,14,FontWeight.normal),
                                      contentPadding: const EdgeInsets.all(10.0),
                                      border: const OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: HelperColor.primaryLightColor, width: 1.0),
                                      ),
                                      // contentPadding: const EdgeInsets.all(5),
                                    ),
                                    autofocus: true,
                                    focusNode: nodeFrom,
                                    controller: addressFrom,
                                    onChanged: (String value) {
                                      placeBloc.searchPlace(value);
                                    },
                                    onTap: () {
                                      setState(() {
                                        inputFrom = true;
                                        inputTos = false;
                                        //priint("inputTos"+inputTos.toString());
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextField(
                                    style: HelperStyle.textStyle(context,HelperColor.black,14,FontWeight.normal),
                                    decoration:  InputDecoration(
                                      filled: true,
                                      prefixIcon: const Icon(Iconsax.global_search,color: HelperColor.black,),
                                      fillColor:HelperColor.freyColor.withOpacity(0.1),
                                      hintText: "Your destination",
                                      hintStyle: HelperStyle.textStyle(context,HelperColor.black,14,FontWeight.normal),
                                      border: const OutlineInputBorder(),
                                      contentPadding: const EdgeInsets.all(10.0),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: HelperColor.primaryLightColor, width: 1.0),
                                      ),
                                      // contentPadding: const EdgeInsets.all(5),
                                    ),
                                    focusNode: nodeTos,
                                    //autofocus: true,
                                    controller: addressTo,
                                    onChanged: (String value) {
                                      placeBloc.searchPlace(value);
                                    },
                                    onTap: () {
                                      setState(() {
                                        inputTos = true;
                                        inputFrom = false;
                                        //priint("inputTos"+inputTos.toString());
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              inputTos != true
                  ? Container(
                      color: HelperColor.lightGreyColor,
                      child: StreamBuilder(
                          stream: placeBloc.placeStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data == "start") {
                                return const Center(
                                    child: SpinKitPulse(
                                      color: HelperColor.primaryColor,
                                      size: 25.0,
                                    )
                                );
                              }
                              Object? placess = snapshot.data;
                              List<PlaceItemRes> places = placess as List<PlaceItemRes>;
                              return ListView.separated(
                                shrinkWrap: true,
                                itemCount: places.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(places.elementAt(index).name,style: HelperStyle.textStyle(context,HelperColor.black,14,FontWeight.w600),),
                                    subtitle:
                                    Text(places.elementAt(index).address ,style: HelperStyle.textStyle(context,HelperColor.black,14,FontWeight.normal),),
                                    onTap: () {
                                      dataFrom.clear();
                                      Map<String, dynamic> value = {
                                        "name": places.elementAt(index).name,
                                        "address": places.elementAt(index).address,
                                        "lat": places.elementAt(index).lat,
                                        "long": places.elementAt(index).lng
                                      };
                                      setState(() {
                                        valueFrom = places
                                            .elementAt(index)
                                            .name
                                            .toString();
                                        addressFrom = TextEditingController(
                                            text: valueFrom);
                                        inputTos = true;
                                        FocusScope.of(context)
                                            .requestFocus(nodeTos);
                                        //new address from
                                        dataFrom.add(value);
                                        //priint(dataFrom);
                                      });
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) => const Divider(
                                  height: 1,
                                  color: Color(0xfff5f5f5),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
              )
                  : Container(
                      color: HelperColor.fillColor,
                      child: StreamBuilder(
                        stream: placeBloc.placeStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data == "start") {
                              return const Center(
                                  child: SpinKitPulse(
                                    color: HelperColor.primaryColor,
                                    size: 25.0,
                                  )
                              );
                            }
                            Object? placess = snapshot.data;
                            List<PlaceItemRes> places = placess as List<PlaceItemRes>;
                            return ListView.separated(
                              shrinkWrap: true,
                              itemCount: places.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 15,right: 15).r,
                                  child: ListTile(
                                    title: Text(places.elementAt(index).name,style: HelperStyle.textStyle(context,HelperColor.black,14,FontWeight.w600)),
                                    subtitle: Text(places.elementAt(index).address,style: HelperStyle.textStyle(context,HelperColor.black,14,FontWeight.normal)),
                                    onTap: () {
                                      dataTo.clear();
                                      Map<String, dynamic> value = {
                                        "name": places.elementAt(index).name,
                                        "address": places.elementAt(index).address,
                                        "lat": places.elementAt(index).lat,
                                        "long": places.elementAt(index).lng
                                      };
                                      setState(() {
                                        valueTos = places
                                            .elementAt(index)
                                            .name
                                            .toString();
                                        addressTo = TextEditingController(
                                            text: places
                                                .elementAt(index)
                                                .name
                                                .toString());
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        dataTo.add(value);
                                        //priint(dataTo);
                                        //directions
                                        navigator();
                                      });
                                    },
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => const Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    placeBloc.dispose();
    super.dispose();
  }

  getCurrentAddFrom() {
    Map<String, dynamic> value = {
      "name": widget.nameAddressFrom,
      "address": "",
      "lat": widget.addressFrom.target.latitude,
      "long": widget.addressFrom.target.longitude,
    };
    setState(() {
      // getAddress(widget.nameAddressFrom);
      dataFrom.add(value);
      //priint(dataFrom);
    });
  }

  @override
  void initState() {
    addressFrom = TextEditingController(text: widget.nameAddressFrom);
    getCurrentAddFrom();
    super.initState();
  }

  navigator() {

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ConfirmRideDetails(
        dataFrom: dataFrom,
        dataTo: dataTo,
      ),
    ),
    );
  }
}
