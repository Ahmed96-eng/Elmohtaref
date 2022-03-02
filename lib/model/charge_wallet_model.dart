class ChargeWalletModel {
  String? chargeWalletAmount;
  // String? due;
  ChargeWalletModel.fromJson(Map<String, dynamic> json) {
    chargeWalletAmount = json['wallet'];
    // due = json['due'];
  }
}
