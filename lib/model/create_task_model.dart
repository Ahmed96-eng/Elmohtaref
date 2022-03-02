class CreateTaskModel {
  CreateTaskData? data;
  CreateTaskModel.fromJson(Map<String, dynamic> json) {
    data = CreateTaskData.fromJson(json['data']);
  }
}

class CreateTaskData {
  String? id;
  String? customerId;
  String? staffId;
  String? serviceId;
  String? title;
  String? description;
  String? long;
  String? lat;
  String? status;
  String? coupon;
  String? createAt;

  CreateTaskData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    staffId = json['staff_id'];
    serviceId = json['service_id'];
    title = json['title'];
    description = json['description'];
    long = json['longitude'];
    lat = json['latitude'];
    status = json['status'];
    coupon = json['coupon'];
    createAt = json['created_at'];
  }
}
