class MessageModel {
  String? recevierId;
  String? recevierName;
  String? recevierImage;
  String? senderId;
  String? senderName;
  String? senderImage;
  String? message;

  String? timeDate;

  MessageModel({
    this.recevierId,
    this.recevierName,
    this.recevierImage,
    this.senderId,
    this.senderImage,
    this.senderName,
    this.message,
    this.timeDate,
  });
  MessageModel.fromJson(Map<String, dynamic> json) {
    recevierId = json['recevierId'];
    recevierName = json['recevierName'];
    recevierImage = json['recevierImage'];
    senderId = json['senderId'];
    senderName = json['senderName'];
    senderImage = json['senderImage'];
    message = json['message'];

    timeDate = json['timeDate'];
  }

  Map<String, dynamic> toMap() {
    return {
      "recevierId": recevierId,
      "recevierName": recevierName,
      "recevierImage": recevierImage,
      "senderId": senderId,
      "senderName": senderName,
      "senderImage": senderImage,
      "message": message,
      "timeDate": timeDate,
    };
  }
}
