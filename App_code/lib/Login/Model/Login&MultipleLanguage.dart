

import 'dart:convert';

Loginmodel loginmodelFromJson(String str) =>
    Loginmodel.fromJson(json.decode(str));

String loginmodelToJson(Loginmodel data) => json.encode(data.toJson());

class Loginmodel {
  bool? status;
  String? message;
  Data? data;

  Loginmodel({
    this.status,
    this.message,
    this.data,
  });

  factory Loginmodel.fromJson(Map<String, dynamic> json) => Loginmodel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? pId;
  String? pJimbleId;
  String? patientProfile;
  String? pName;
  String? mobileNo;
  String? emil;
  DateTime? dob;
  int? age;
  String? gender;
  String? aadharNo;
  String? address;
  String? location;
  String? pincode;
  String? city;
  String? district;
  String? state;
  String? pass;
  String? confirmPss;
  String? preferredLanguage;
  int? deleteStatus;
  String? createdAt;

  Data({
    this.pId,
    this.pJimbleId,
    this.patientProfile,
    this.pName,
    this.mobileNo,
    this.emil,
    this.dob,
    this.age,
    this.gender,
    this.aadharNo,
    this.address,
    this.location,
    this.pincode,
    this.city,
    this.district,
    this.state,
    this.pass,
    this.confirmPss,
    this.preferredLanguage,
    this.deleteStatus,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pId: json["p_id"],
        pJimbleId: json["p_jimble_id"],
        patientProfile: json["patient_profile"],
        pName: json["p_name"],
        mobileNo: json["mobile_no"],
        emil: json["emil"],
        dob: json["dob"] != "0000-00-00" && json["dob"] != null
            ? DateTime.tryParse(json["dob"])
            : null,
        age: json["age"] != null ? int.tryParse(json["age"].toString()) : null,
        gender: json["gender"],
        aadharNo: json["aadhar_no"],
        address: json["address"],
        location: json["location"],
        pincode: json["pincode"],
        city: json["city"],
        district: json["district"],
        state: json["state"],
        pass: json["pass"],
        confirmPss: json["confirm_pss"],
        preferredLanguage: json["preferred_language"],
        deleteStatus: json["delete_status"] != null
            ? int.tryParse(json["delete_status"].toString())
            : null,
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "p_id": pId,
        "p_jimble_id": pJimbleId,
        "patient_profile": patientProfile,
        "p_name": pName,
        "mobile_no": mobileNo,
        "emil": emil,
        "dob": dob != null
            ? "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}"
            : "0000-00-00",
        "age": age,
        "gender": gender,
        "aadhar_no": aadharNo,
        "address": address,
        "location": location,
        "pincode": pincode,
        "city": city,
        "district": district,
        "state": state,
        "pass": pass,
        "confirm_pss": confirmPss,
        "preferred_language": preferredLanguage,
        "delete_status": deleteStatus,
        "created_at": createdAt,
      };
}
