
import 'dart:convert';

ResentModel resentModelFromJson(String str) => ResentModel.fromJson(json.decode(str));

String resentModelToJson(ResentModel data) => json.encode(data.toJson());

class ResentModel {
    bool? status;
    String? message;

    ResentModel({
        this.status,
        this.message,
    });

    factory ResentModel.fromJson(Map<String, dynamic> json) => ResentModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
