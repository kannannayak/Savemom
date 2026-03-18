// To parse this JSON data, do
//
//     final forgotmodel = forgotmodelFromJson(jsonString);

import 'dart:convert';

Forgotmodel forgotmodelFromJson(String str) => Forgotmodel.fromJson(json.decode(str));

String forgotmodelToJson(Forgotmodel data) => json.encode(data.toJson());

class Forgotmodel {
    bool? status;
    String? message;

    Forgotmodel({
        this.status,
        this.message,
    });

    factory Forgotmodel.fromJson(Map<String, dynamic> json) => Forgotmodel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
