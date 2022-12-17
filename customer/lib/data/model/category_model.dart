class CategoryModel {
  int? id;
  String? category;

  CategoryModel({this.id, this.category});

  CategoryModel.fromJson(json) {
    id = json['id'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    return data;
  }
}