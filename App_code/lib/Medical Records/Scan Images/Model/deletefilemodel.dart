import 'dart:convert';

Scanfiledeletemodel scanfiledeletemodelFromJson(String str) =>
    Scanfiledeletemodel.fromJson(json.decode(str));

String scanfiledeletemodelToJson(Scanfiledeletemodel data) =>
    json.encode(data.toJson());

class Scanfiledeletemodel {
  bool? status;
  String? message;

  Scanfiledeletemodel({
    this.status,
    this.message,
  });

  factory Scanfiledeletemodel.fromJson(Map<String, dynamic> json) =>
      Scanfiledeletemodel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };

  @override
  String toString() {
    return 'Scanfiledeletemodel{status: $status, message: $message}';
  }
}
