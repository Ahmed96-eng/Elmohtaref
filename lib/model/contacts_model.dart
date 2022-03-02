class ContactsModel {
  String? mobile;
  String? facebook;
  String? twitter;
  String? telegram;
  String? instagram;

  ContactsModel.fromJson(Map<String, dynamic> json) {
    mobile ??= json['mobile'];
    facebook ??= json['facebook'];
    twitter ??= json['twitter'];
    telegram ??= json['telegram'];
    instagram ??= json['instagram'];
  }
}
