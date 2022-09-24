import 'dart:async';

import 'package:acoride/data/Service/placeService.dart';

class PlaceBlocService {
  var placeController = StreamController();

  Stream get placeStream => placeController.stream;

  void searchPlace(String keyword) {
    placeController.sink.add("start");
    PlaceService.searchPlace(keyword).then((rs) {
      placeController.sink.add(rs);
    }).catchError((Object error) {
      //_placeController.sink.add("stop");
    });
  }

  void dispose() {
    placeController.close();
  }
}
