class TaskDetailsModel {
  TaskDetailsData? data;
  TaskDetailsModel.fromJson(Map<String, dynamic> json) {
    data = TaskDetailsData.fromJson(json["data"]);
  }
}

class TaskDetailsData {
  String? id;
  String? customerId;
  String? staffId;
  String? serviceId;
  String? serviceName;
  String? serviceAmount;
  String? taskFees;
  String? title;
  String? couponCode;
  String? coupon;
  String? description;
  String? long;
  String? lat;
  String? distance;
  String? vat;
  String? items;
  String? total;
  String? appFees;
  String? status;
  String? finishedAt;
  String? createdAt;
  TaskDetailsData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    customerId = json["customer_id"];
    staffId = json["staff_id"];
    serviceId = json["service_id"];
    serviceName = json["service_name"];
    serviceAmount = json["service_amount"];
    title = json["title"];
    description = json["description"];
    appFees = json["id"];
    taskFees = json["task_fees"];
    vat = json["vat"];
    items = json["items"];
    distance = json["distance"];
    total = json["total"];
    long = json["longitude"];
    lat = json["latitude"];
    couponCode = json["coupon_code"];
    coupon = json["coupon"];
    status = json["status"];
    finishedAt = json["finished_at"];
    createdAt = json["created_at"];
  }
}
