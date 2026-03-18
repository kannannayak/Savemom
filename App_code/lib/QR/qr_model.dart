import 'dart:convert';

QrScannerModel QrScannerModelFromJson(String str) => QrScannerModel.fromJson(json.decode(str));

String QrScannerModelToJson(QrScannerModel data) => json.encode(data.toJson());

class QrScannerModel {
  bool? status;
  String? message;
  QrData? data;

  QrScannerModel({
    this.status,
    this.message,
    this.data,
  });

  factory QrScannerModel.fromJson(Map<String, dynamic> json) => QrScannerModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : QrData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };

  @override
  String toString() {
    return 'QrScannerModel(status: $status, message: $message, data: $data)';
  }
}

class QrData {
  Patient? patient;
  List<Relationship>? relationships;
  Relationship? relationship;

  QrData({
    this.patient,
    this.relationships,
    this.relationship,
  });

  factory QrData.fromJson(Map<String, dynamic> json) => QrData(
    patient: json["patient"] == null ? null : Patient.fromJson(json["patient"]),
    relationships: json["relationships"] == null
        ? []
        : List<Relationship>.from(
        json["relationships"].map((x) => Relationship.fromJson(x))),
    relationship: json["relationship"] == null
        ? null
        : Relationship.fromJson(json["relationship"]),
  );

  Map<String, dynamic> toJson() => {
    "patient": patient?.toJson(),
    "relationships": relationships == null
        ? []
        : List<dynamic>.from(relationships!.map((x) => x.toJson())),
    "relationship": relationship?.toJson(),
  };

  @override
  String toString() {
    return 'QrData(patient: $patient, relationships: $relationships, relationship: $relationship)';
  }
}


class Patient {
  int? pId;
  String? pJimbleId;
  String? patientProfile;
  String? mrms;
  String? pName;
  String? mobileNo;
  String? emil;
  DateTime? dob;
  String? age;
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
  dynamic preferredLanguage;
  int? activeStatus;
  int? deleteStatus;
  String? reason;
  DateTime? createdAt;
  int? help;
  String? otp;
  String? otpGeneratedAt;
  String? status;

  Patient({
    this.pId,
    this.pJimbleId,
    this.patientProfile,
    this.mrms,
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
    this.activeStatus,
    this.deleteStatus,
    this.reason,
    this.createdAt,
    this.help,
    this.otp,
    this.otpGeneratedAt,
    this.status,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    pId: json["p_id"],
    pJimbleId: json["p_jimble_id"],
    patientProfile: json["patient_profile"],
    mrms: json["mrms"],
    pName: json["p_name"],
    mobileNo: json["mobile_no"],
    emil: json["emil"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    age: json["age"],
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
    activeStatus: json["active_status"],
    deleteStatus: json["delete_status"],
    reason: json["reason"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    help: json["help"],
    otp: json["otp"],
    otpGeneratedAt: json["otp_generated_at"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "p_id": pId,
    "p_jimble_id": pJimbleId,
    "patient_profile": patientProfile,
    "mrms": mrms,
    "p_name": pName,
    "mobile_no": mobileNo,
    "emil": emil,
    "dob":
    dob == null ? null : "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
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
    "active_status": activeStatus,
    "delete_status": deleteStatus,
    "reason": reason,
    "created_at": createdAt == null
        ? null
        : "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "help": help,
    "otp": otp,
    "otp_generated_at": otpGeneratedAt,
    "status": status,
  };

  @override
  String toString() {
    return 'Patient(pId: $pId, pJimbleId: $pJimbleId, patientProfile: $patientProfile, mrms: $mrms, '
        'pName: $pName, mobileNo: $mobileNo, emil: $emil, dob: $dob, age: $age, gender: $gender, '
        'aadharNo: $aadharNo, address: $address, location: $location, pincode: $pincode, city: $city, '
        'district: $district, state: $state, pass: $pass, confirmPss: $confirmPss, preferredLanguage: $preferredLanguage, '
        'activeStatus: $activeStatus, deleteStatus: $deleteStatus, reason: $reason, createdAt: $createdAt, '
        'help: $help, otp: $otp, otpGeneratedAt: $otpGeneratedAt, status: $status)';
  }
}

class Relationship {
  int? rId;
  int? pId;
  dynamic rJimbleId;
  String? relationship;
  String? mrms;
  String? familymembername;
  DateTime? dob;
  int? age;
  String? gender;
  String? aadharNo;
  dynamic profileImg;
  int? deleteStatus;

  Relationship({
    this.rId,
    this.pId,
    this.rJimbleId,
    this.relationship,
    this.mrms,
    this.familymembername,
    this.dob,
    this.age,
    this.gender,
    this.aadharNo,
    this.profileImg,
    this.deleteStatus,
  });

  factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
    rId: json["r_id"],
    pId: json["p_id"],
    rJimbleId: json["r_jimble_id"],
    relationship: json["relationship"],
    mrms: json["mrms"],
    familymembername: json["familymembername"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    age: json["age"],
    gender: json["gender"],
    aadharNo: json["aadhar_no"],
    profileImg: json["profile_img"],
    deleteStatus: json["delete_status"],
  );

  Map<String, dynamic> toJson() => {
    "r_id": rId,
    "p_id": pId,
    "r_jimble_id": rJimbleId,
    "relationship": relationship,
    "mrms": mrms,
    "familymembername": familymembername,
    "dob": dob == null ? null : "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "age": age,
    "gender": gender,
    "aadhar_no": aadharNo,
    "profile_img": profileImg,
    "delete_status": deleteStatus,
  };

  @override
  String toString() {
    return 'Relationship(rId: $rId, pId: $pId, rJimbleId: $rJimbleId, relationship: $relationship, mrms: $mrms, '
        'familymembername: $familymembername, dob: $dob, age: $age, gender: $gender, aadharNo: $aadharNo, '
        'profileImg: $profileImg, deleteStatus: $deleteStatus)';
  }
}
