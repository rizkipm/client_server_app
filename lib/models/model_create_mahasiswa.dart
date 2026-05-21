
import 'dart:convert';

ModelCreateData modelCreateDataFromJson(String str) => ModelCreateData.fromJson(json.decode(str));

String modelCreateDataToJson(ModelCreateData data) => json.encode(data.toJson());

class ModelCreateData {
  String status;
  String message;

  ModelCreateData({
    required this.status,
    required this.message,
  });

  factory ModelCreateData.fromJson(Map<String, dynamic> json) => ModelCreateData(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
