class DashBoardModel {
  const DashBoardModel({this.image,this.text});
  final String? image;
  final String? text;
}

const List<DashBoardModel> dashboardNotification = <DashBoardModel>[
  DashBoardModel(image: 'assets/images/van.png',text:'Deliver a package',),
  DashBoardModel(image: 'assets/images/star.png',text:"Choose a safe place",),
];


class BillsModel {
  const BillsModel({this.image,this.text});
  final String? image;
  final String? text;
}

const List<BillsModel> billModel = <BillsModel>[
  BillsModel(image: 'assets/images/no-conexion.png',text:'Airtime',),
  BillsModel(image: 'assets/images/smartphone.png',text:"Data",),
  BillsModel(image: 'assets/images/tv.png',text:'Cable Tv',),
  BillsModel(image: 'assets/images/electrical-energy.png',text:"Power",),
];