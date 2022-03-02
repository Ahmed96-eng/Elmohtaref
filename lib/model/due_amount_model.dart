class DueAmountModel {
  String? dueAmount;

  DueAmountModel.fromJson(Map<String, dynamic> json) {
    dueAmount = json['due'];
  }
}
