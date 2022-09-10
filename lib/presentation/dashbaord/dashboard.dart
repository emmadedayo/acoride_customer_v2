import 'package:acoride/logic/cubits/dashboard_cubit.dart';
import 'package:acoride/presentation/map_search/map_search_screen.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/constant/enum.dart';
import '../../core/helper/helper_style.dart';
import '../../logic/states/dashboard_state.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key, }) : super(key: key);
  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashBoardCubit>(
      create: (context) => DashBoardCubit(DashBoardState()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<DashBoardCubit, DashBoardState>(
            builder: (context, state) {
              return BlurryModalProgressHUD(
                inAsyncCall: state.positionLoading == CustomState.LOADING,
                child: BlocListener<DashBoardCubit, DashBoardState>(
                  listener: (context, state) async {
                    // if (state.isSuccess) {
                    //   Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const BaseAuthController(),
                    //     ),
                    //   );
                    // }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height/1.5,
                            child:state.position == null?
                            const CircularProgressIndicator(
                              color: Colors.red,
                            ):
                            GoogleMap(
                              onMapCreated: (GoogleMapController controller) {
                                context.read<DashBoardCubit>().onMapCreated(controller);
                              },
                              markers: Set<Marker>.of(state.markers.values),
                              zoomControlsEnabled: false,
                              myLocationButtonEnabled: false,
                              myLocationEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    state.position != null ? state.position!.latitude : state.lastKnownPositions!.latitude ?? state.position!.latitude,
                                    state.position != null ? state.position!.longitude : state.lastKnownPositions!.longitude ?? state.position!.longitude),
                                zoom: 17,
                              ),
                              onCameraMove: (CameraPosition position) {
                                context.read<DashBoardCubit>().onCameraMove(position);
                              },
                              onCameraIdle: () => context.read<DashBoardCubit>().getPositionName(
                                  state.cameraPosition?.target.latitude ?? state.position?.latitude,
                                  state.cameraPosition?.target.longitude ?? state.position?.longitude),
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.all(25.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Where would you like to go?",
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MapSearchAddress(
                                                  state.currentAddress,
                                                  state.cameraPosition!,
                                                ),
                                            fullscreenDialog: true));
                                  },
                                  child: Hero(
                                    tag: UniqueKey(),
                                    child: Container(
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(6.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              state.currentAddress,
                                              style: HelperStyle.textStyle(
                                                  context,
                                                  Colors.grey,
                                                  17,
                                                  FontWeight.w400),
                                            ),
                                          ),
                                          const Icon(
                                            Iconsax.search_favorite,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}