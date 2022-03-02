class ServicesModel {
  List<ServicesModelData>? data;
  ServicesModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] as List)
        .map((e) => ServicesModelData.fromJson(e))
        .toList();
  }
}

class ServicesModelData {
  String? id;
  String? seviceName;
  String? serviceImg;
  String? serviceAmount;
  String? status;

  ServicesModelData.fromJson(Map<String, dynamic> json) {
    id ??= json['id'];
    seviceName ??= json['service_name'];
    serviceImg ??= json['service_img'];
    serviceAmount ??= json['service_amount'];
    status ??= json['status'];
  }
}
