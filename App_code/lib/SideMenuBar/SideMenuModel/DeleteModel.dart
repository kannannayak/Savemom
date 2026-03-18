// To parse this JSON data, do
//
//     final deleteModel = deleteModelFromJson(jsonString);

import 'dart:convert';

DeleteModel deleteModelFromJson(String str) =>
    DeleteModel.fromJson(json.decode(str));

String deleteModelToJson(DeleteModel data) => json.encode(data.toJson());

class DeleteModel {
  bool? status;
  String? message;

  DeleteModel({
    this.status,
    this.message,
  });

  factory DeleteModel.fromJson(Map<String, dynamic> json) => DeleteModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
