class ProvidersModel {
  List<ProvidersModelData>? data;
  ProvidersModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] as List)
        .map((e) => ProvidersModelData.fromJson(e))
        .toList();
  }
}

// class Providers {
//   List<ProvidersModelData>? provider;
//   Providers.fromJson(Map<String, dynamic> json) {
// provider = (json['providers'] as List)
//     .map((e) => ProvidersModelData.fromJson(e))
//     .toList();
//   }
// }

class ProvidersModelData {
  String? id;
  String? userName;
  String? mobile;
  String? profile;
  String? job;
  String? lat;
  String? long;
  String? distance;
  String? time;
  String? rate;
  String? percentage;
  String? numberTasks;
  String? servicesFees;
  String? servicesId;
  String? tripFees;

  ProvidersModelData.fromJson(Map<String, dynamic> json) {
    id ??= json['staff_id'];
    userName ??= json['username'];
    mobile ??= json['mobile'];
    profile ??= json['profile'];
    job ??= json['job_details'];
    lat ??= json['staff_lat'];
    long ??= json['staff_long'];
    distance ??= json['distance'];
    time ??= json['time'];
    rate ??= json['rate'];
    percentage ??= json['percentage'];
    numberTasks ??= json['no_tasks'];
    servicesFees ??= json['service_fees'];
    servicesId ??= json['service_id'];
    tripFees ??= json['trip_fees'];
  }
}
