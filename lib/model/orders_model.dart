class OrdersModel {
  List<OrdersModelData>? data;
  OrdersModel.fromJson(Map<String, dynamic> json) {
    data =
        (json['data'] as List).map((e) => OrdersModelData.fromJson(e)).toList();
  }
}

class OrdersModelData {
  String? id;
  String? staffId;
  String? staffName;
  String? staffNumber;
  String? createdAt;
  String? totalAmount;
  String? items;
  String? vat;

  String? title;
  String? long;
  String? lat;

  OrdersModelData.fromJson(Map<String, dynamic> json) {
    id ??= json['id'];
    staffId ??= json['staff_id'];
    staffName ??= json['staff_name'];
    staffNumber ??= json['staff_number'];
    title ??= json['title'];
    totalAmount ??= json['total'];
    items ??= json['items'];
    vat ??= json['vat'];
    long ??= json['longitude'];
    lat ??= json['latitude'];
    createdAt ??= json['created_at'];
  }
}
