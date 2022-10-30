class HistoryModel {
  const HistoryModel({this.image,this.text,this.latitude,this.longitude});
  final String? image;
  final double? latitude;
  final double? longitude;
  final String? text;
}

const List<HistoryModel> historyModel = <HistoryModel>[
  HistoryModel(text:"Elebu Fish Depot, 20993, Ibadan",latitude: 37.4219983,longitude: -122.084),
  HistoryModel(text:"Elebu Fish Depot, 20993, Ibadan",latitude: 37.4219983,longitude: -122.084),
  HistoryModel(text:"Elebu Fish Depot, 20993, Ibadan",latitude: 37.4219983,longitude: -122.084),
  HistoryModel(text:"Elebu Fish Depot, 20993, Ibadan",latitude: 37.4219983,longitude: -122.084),
  HistoryModel(text:"Elebu Fish Depot, 20993, Ibadan",latitude: 37.4219983,longitude: -122.084),
  HistoryModel(text:"Elebu Fish Depot, 20993, Ibadan",latitude: 37.4219983,longitude: -122.084),
  HistoryModel(text:"Elebu Fish Depot, 20993, Ibadan",latitude: 37.4219983,longitude: -122.084),
  HistoryModel(text:"Elebu Fish Depot, 20993, Ibadan",latitude: 37.4219983,longitude: -122.084),
  HistoryModel(text:"Elebu Fish Depot, 20993, Ibadan",latitude: 37.4219983,longitude: -122.084),
  HistoryModel(text:"Elebu Fish Depot, 20993, Ibadan",latitude: 37.4219983,longitude: -122.084),
];


class AirtimeModel {
  const AirtimeModel({this.text});
  final String? text;
}

const List<AirtimeModel> billModel = <AirtimeModel>[
  AirtimeModel(text:'Airtime',),
  AirtimeModel(text:"Data",),
];

class DataModel {
  const DataModel({this.text});
  final String? text;
}

const List<DataModel> dataModel = <DataModel>[
  DataModel(text:'Cable Tv',),
  DataModel(text:"Power",),
];