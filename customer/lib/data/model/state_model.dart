class StateModel {
  int? id;
  String? name;

  StateModel({this.id, this.name});

  StateModel.fromJson(json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
