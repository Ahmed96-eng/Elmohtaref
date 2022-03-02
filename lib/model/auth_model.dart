class AuthModelModel {
  UserData? data;
  AuthModelModel.fromJson(Map<String, dynamic> json) {
    data = UserData.fromJson(json['data']);
  }
}

class UserData {
  String? id;
  String? username;
  String? email;
  String? password;
  String? mobile;
  String? nationality;
  String? long;
  String? lat;
  String? location;
  String? deviceToken;
  String? token;
  String? wallet;
  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    mobile = json['mobile'];
    nationality = json['nationality'];
    long = json['long'];
    lat = json['lat'];
    location = json['location'];
    deviceToken = json['deviceToken'];
    token = json['token'];
    wallet = json['wallet'];
  }
}
