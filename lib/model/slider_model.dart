class SliderModel {
  List<SliderData>? data;
  SliderModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] as List).map((e) => SliderData.fromJson(e)).toList();
  }
}

class SliderData {
  String? id;
  String? title;
  String? image;
  String? createdAt;
  String? status;

  SliderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    createdAt = json['created_at'];
    status = json['status'];
  }
}
