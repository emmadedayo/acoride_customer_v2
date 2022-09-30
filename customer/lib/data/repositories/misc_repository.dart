import 'dart:async';
import 'package:acoride/data/model/state_model.dart';
import 'package:acoride/data/provider/misc_provider.dart';

class MiscRepository {

  MiscProvider miscProvider = MiscProvider();
  
  Future<List<StateModel>> getState() async {
    List<StateModel> sites = [];
    List list = await miscProvider.getState();
    for (int i = 0; i < list.length; i++) {
      Map map = list[i];
      if (map.isNotEmpty && map['id'] > 0) {
        StateModel? site = StateModel.fromJson(map);
        if (site != null) {
          sites.add(site);
        }
      }
    }
    return sites;
  }
}