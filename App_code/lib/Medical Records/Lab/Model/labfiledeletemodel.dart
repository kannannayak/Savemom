import 'dart:convert';

labfiledeletemodel scanfiledeletemodelFromJson(String str) =>
    labfiledeletemodel.fromJson(json.decode(str));

String labfiledeletemodelToJson(labfiledeletemodel data) =>
    json.encode(data.toJson());

class labfiledeletemodel {
  bool? status;
  String? message;

  labfiledeletemodel({
    this.status,
    this.message,
  });

  factory labfiledeletemodel.fromJson(Map<String, dynamic> json) =>
      labfiledeletemodel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
