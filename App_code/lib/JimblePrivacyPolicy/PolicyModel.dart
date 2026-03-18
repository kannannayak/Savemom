class Policymodel {
  bool? status;
  String? message;
  Data? data;

  Policymodel({
    this.status,
    this.message,
    this.data,
  });

  factory Policymodel.fromJson(Map<String, dynamic> json) => Policymodel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };

  @override
  String toString() {
    return 'Policymodel(status: $status, message: $message, data: $data)';
  }
}

class Data {
  String? privacyPolicy;
  String? fontSize;
  String? textColor;
  String? textAlignment;

  Data({
    this.privacyPolicy,
    this.fontSize,
    this.textColor,
    this.textAlignment,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        privacyPolicy: json["privacy_policy"],
        fontSize: json["font_size"],
        textColor: json["text_color"],
        textAlignment: json["text_alignment"],
      );

  Map<String, dynamic> toJson() => {
        "privacy_policy": privacyPolicy,
        "font_size": fontSize,
        "text_color": textColor,
        "text_alignment": textAlignment,
      };

  @override
  String toString() {
    return 'Data(privacyPolicy: $privacyPolicy, fontSize: $fontSize, textColor: $textColor, textAlignment: $textAlignment)';
  }
}
