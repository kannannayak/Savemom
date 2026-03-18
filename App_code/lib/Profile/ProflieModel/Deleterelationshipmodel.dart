import 'dart:convert';

Deleterelationshipmodel deleterelationshipmodelFromJson(String str) =>
    Deleterelationshipmodel.fromJson(json.decode(str));

String deleterelationshipmodelToJson(Deleterelationshipmodel data) =>
    json.encode(data.toJson());

class Deleterelationshipmodel {
  bool? status;
  String? message;

  Deleterelationshipmodel({
    this.status,
    this.message,
  });

  factory Deleterelationshipmodel.fromJson(Map<String, dynamic> json) =>
      Deleterelationshipmodel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };

  @override
  String toString() {
    return 'Deleterelationshipmodel(status: $status, message: $message)';
  }
}
