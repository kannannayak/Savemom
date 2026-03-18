class Usersmodel {
  bool? status;
  String? message;
  List<Datum1>? data;

  Usersmodel({
    this.status,
    this.message,
    this.data,
  });

  factory Usersmodel.fromJson(Map<String, dynamic> json) => Usersmodel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum1>.from(json["data"]!.map((x) => Datum1.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'Usersmodel(status: $status, message: $message, data: $data)';
  }
}

class Datum1 {
  int? pId;
  String? pName;
  String? pJimbleId;
  int? rId;
  String? rJimbleId;
  String? familymembername;
  String? profileImg;

  Datum1({
    this.pId,
    this.pName,
    this.pJimbleId,
    this.rId,
    this.rJimbleId,
    this.familymembername,
    this.profileImg,
  });

  factory Datum1.fromJson(Map<String, dynamic> json) => Datum1(
        pId: json["p_id"],
        pName: json["p_name"],
        pJimbleId: json["p_jimble_id"],
        rId: json["r_id"],
        rJimbleId: json["r_jimble_id"],
        familymembername: json["familymembername"],
        profileImg: json["profile_img"],
      );

  Map<String, dynamic> toJson() => {
        "p_id": pId,
        "p_name": pName,
        "p_jimble_id": pJimbleId,
        "r_id": rId,
        "r_jimble_id": rJimbleId,
        "familymembername": familymembername,
        "profile_img": profileImg,
      };

  @override
  String toString() {
    return 'Datum(pId: $pId, pName: $pName, pJimbleId: $pJimbleId, rId: $rId, rJimbleId: $rJimbleId, familymembername: $familymembername, profileImg: $profileImg)';
  }
}
