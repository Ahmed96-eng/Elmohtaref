class ProfilModel {
  ProfileData? data;
  ProfilModel.fromJson(Map<String, dynamic> json) {
    data = ProfileData.fromJson(json['data']);
  }
}

class ProfileData {
  String? id;
  String? username;
  String? email;
  String? password;
  String? mobile;
  String? secondMobile;
  String? profile;
  String? passport;
  String? service;
  String? wallet;
  String? due;
  String? job;
  String? nationality;
  String? long;
  String? lat;
  String? location;
  String? deviceToken;
  String? token;
  String? languages;
  String? rate;
  String? numberTasks;
  ProfileData({
    this.id = "",
    this.username = "",
    this.email = "",
    this.password = "",
    this.mobile = "",
    this.secondMobile = "",
    this.profile = "",
    this.passport = "",
    this.service = "",
    this.wallet = "",
    this.due = "",
    this.job = "",
    this.nationality = "",
    this.long = "",
    this.lat = "",
    this.location = "",
    this.deviceToken = "",
    this.token = "",
    this.languages = "",
    this.rate = "",
    this.numberTasks = "",
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    mobile = json['mobile'];
    secondMobile = json['mobile2'];
    profile = json['profile'];
    passport = json['passport'];
    service = json['service'];
    wallet = json['wallet'];
    due = json['due'];
    job = json['job'];
    nationality = json['nationality'];
    long = json['long'];
    lat = json['lat'];
    location = json['location'];
    deviceToken = json['deviceToken'];
    token = json['token'];
    languages = json['languages'];
    rate = json['rate'];
    numberTasks = json['no_orders'];
  }
}
