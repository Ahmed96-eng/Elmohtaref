class SearchModel {
  List<SearchData>? data;
  SearchModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] as List).map((e) => SearchData.fromJson(e)).toList();
  }
}

class SearchData {
  String? id;
  String? serviceName;
  String? serviceAmount;
  String? serviceImage;
  String? status;

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    serviceAmount = json['service_amount'];
    serviceImage = json['service_img'];
    status = json['status'];
  }
}
