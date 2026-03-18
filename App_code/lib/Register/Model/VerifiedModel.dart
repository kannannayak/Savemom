
class Verifiedmodel {
  bool? status;
  String? message;
  String? jimbleId;

  Verifiedmodel({this.status, this.message, this.jimbleId});

  factory Verifiedmodel.fromJson(Map<String, dynamic> json) => Verifiedmodel(
        status: json["status"],
        message: json["message"],
        jimbleId: json["jimble_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "jimble_id": jimbleId,
      };

  @override
  String toString() {
    return 'Verifiedmodel(status: $status, message: $message, jimbleId: $jimbleId)';
  }
}
