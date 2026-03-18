// class Profilemodel {
//   final bool? status;
//   final String? message;
//   final Data? data;

//   Profilemodel({this.status, this.message, this.data});

//   factory Profilemodel.fromJson(Map<String, dynamic> json) => Profilemodel(
//         status: json["status"],
//         message: json["message"],
//         data: json["data"] != null ? Data.fromJson(json["data"]) : null,
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data?.toJson(),
//       };

//   @override
//   String toString() =>
//       'Profilemodel(status: $status, message: $message, data: $data)';
// }

// class Data {
//   final Patient? patient;
//   final List<Relationship>? relationships;

//   Data({this.patient, this.relationships});

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         patient:
//             json["patient"] != null ? Patient.fromJson(json["patient"]) : null,
//         relationships: json["relationships"] != null
//             ? List<Relationship>.from(
//                 json["relationships"].map((x) => Relationship.fromJson(x)))
//             : null,
//       );

//   Map<String, dynamic> toJson() => {
//         "patient": patient?.toJson(),
//         "relationships": relationships?.map((x) => x.toJson()).toList(),
//       };

//   @override
//   String toString() => 'Data(patient: $patient, relationships: $relationships)';
// }

// class Patient {
//   final String? pId;
//   final String? pJimbleId;
//   final String? patientProfile;
//   final String? pName;
//   final String? mobileNo;
//   final String? email;
//   final DateTime? dob;
//   final String? age;
//   final String? gender;
//   final String? aadharNo;
//   final String? address;
//   final String? location;
//   final String? pincode;
//   final String? city;
//   final String? district;
//   final String? state;
//   final String? pass;
//   final String? confirmPss;
//   final String? preferredLanguage;

//   Patient({
//     this.pId,
//     this.pJimbleId,
//     this.patientProfile,
//     this.pName,
//     this.mobileNo,
//     this.email,
//     this.dob,
//     this.age,
//     this.gender,
//     this.aadharNo,
//     this.address,
//     this.location,
//     this.pincode,
//     this.city,
//     this.district,
//     this.state,
//     this.pass,
//     this.confirmPss,
//     this.preferredLanguage,
//   });
// factory Patient.fromJson(Map<String, dynamic> json) => Patient(
//   pId: json["p_id"]?.toString(),
//   pJimbleId: json["p_jimble_id"],
//   patientProfile: json["patient_profile"],
//   pName: json["p_name"],
//   mobileNo: json["mobile_no"]?.toString(),
//   email: json["emil"], // note: API returns "emil", not "email"
//   dob: json["dob"] != null && json["dob"] != "0000-00-00"
//       ? DateTime.tryParse(json["dob"])
//       : null,
//   age: json["age"]?.toString(),
//   gender: json["gender"],
//   aadharNo: json["aadhar_no"]?.toString(),
//   address: json["address"],
//   location: json["location"],
//   pincode: json["pincode"]?.toString(),
//   city: json["city"],
//   district: json["district"],
//   state: json["state"],
//   pass: json["pass"],
//   confirmPss: json["confirm_pss"],
//   preferredLanguage: json["preferred_language"],
// );

//   Map<String, dynamic> toJson() => {
//         "p_id": pId,
//         "p_jimble_id": pJimbleId,
//         "patient_profile": patientProfile,
//         "p_name": pName,
//         "mobile_no": mobileNo,
//         "email": email,
//         "dob": dob?.toIso8601String(),
//         "age": age,
//         "gender": gender,
//         "aadhar_no": aadharNo,
//         "address": address,
//         "location": location,
//         "pincode": pincode,
//         "city": city,
//         "district": district,
//         "state": state,
//         "pass": pass,
//         "confirm_pss": confirmPss,
//         "preferred_language": preferredLanguage,
//       };

//   @override
//   String toString() => 'Patient($pJimbleId, $pName, $mobileNo)';
// }

// class Relationship {
//   final String? rId;
//   final String? pId;
//   final String? rJimbleId;
//   final String? relationship;
//   final String? familymembername;
//   final String? dob;
//   final String? age;
//   final String? gender;
//   final String? aadharNo;
//   final String? profileImg;

//   Relationship({
//     this.rId,
//     this.pId,
//     this.rJimbleId,
//     this.relationship,
//     this.familymembername,
//     this.dob,
//     this.age,
//     this.gender,
//     this.aadharNo,
//     this.profileImg,
//   });

//  factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
//   rId: json["r_id"]?.toString(),
//   pId: json["p_id"]?.toString(),
//   rJimbleId: json["r_jimble_id"],
//   relationship: json["relationship"],
//   familymembername: json["familymembername"],
//   dob: json["dob"],
//   age: json["age"]?.toString(),
//   gender: json["gender"],
//   aadharNo: json["aadhar_no"]?.toString(),
//   profileImg: json["profile_img"],
// );

//   Map<String, dynamic> toJson() => {
//         "r_id": rId,
//         "p_id": pId,
//         "r_jimble_id": rJimbleId,
//         "relationship": relationship,
//         "familymembername": familymembername,
//         "dob": dob,
//         "age": age,
//         "gender": gender,
//         "aadhar_no": aadharNo,
//         "profile_img": profileImg,
//       };

//   @override
//   String toString() =>
//       'Relationship($rJimbleId, $familymembername, $relationship)';
// }

// To parse this JSON data, do
//
//     final profilemodel = profilemodelFromJson(jsonString);

// import 'dart:convert';

// Profilemodel profilemodelFromJson(String str) => Profilemodel.fromJson(json.decode(str));

// String profilemodelToJson(Profilemodel data) => json.encode(data.toJson());

// class Profilemodel {
//     bool? status;
//     String? message;
//     Data? data;

//     Profilemodel({
//         this.status,
//         this.message,
//         this.data,
//     });

//     factory Profilemodel.fromJson(Map<String, dynamic> json) => Profilemodel(
//         status: json["status"],
//         message: json["message"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data?.toJson(),
//     };
// }

// class Data {
//     Patient? patient;
//     List<Relationship>? relationships;

//     Data({
//         this.patient,
//         this.relationships,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         patient: json["patient"] == null ? null : Patient.fromJson(json["patient"]),
//         relationships: json["relationships"] == null ? [] : List<Relationship>.from(json["relationships"]!.map((x) => Relationship.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "patient": patient?.toJson(),
//         "relationships": relationships == null ? [] : List<dynamic>.from(relationships!.map((x) => x.toJson())),
//     };
// }

// class Patient {
//     int? pId;
//     String? pJimbleId;
//     String? patientProfile;
//     String? mrms;
//     String? pName;
//     String? mobileNo;
//     String? emil;
//     DateTime? dob;
//     String? age;
//     String? gender;
//     String? aadharNo;
//     String? address;
//     String? location;
//     String? pincode;
//     String? city;
//     String? district;
//     String? state;
//     String? pass;
//     String? confirmPss;
//     dynamic preferredLanguage;
//     int? activeStatus;
//     int? deleteStatus;
//     String? reason;
//     DateTime? createdAt;
//     int? help;
//     String? otp;
//     DateTime? otpGeneratedAt;
//     String? status;

//     Patient({
//         this.pId,
//         this.pJimbleId,
//         this.patientProfile,
//         this.mrms,
//         this.pName,
//         this.mobileNo,
//         this.emil,
//         this.dob,
//         this.age,
//         this.gender,
//         this.aadharNo,
//         this.address,
//         this.location,
//         this.pincode,
//         this.city,
//         this.district,
//         this.state,
//         this.pass,
//         this.confirmPss,
//         this.preferredLanguage,
//         this.activeStatus,
//         this.deleteStatus,
//         this.reason,
//         this.createdAt,
//         this.help,
//         this.otp,
//         this.otpGeneratedAt,
//         this.status,
//     });

//     factory Patient.fromJson(Map<String, dynamic> json) => Patient(
//         pId: json["p_id"],
//         pJimbleId: json["p_jimble_id"],
//         patientProfile: json["patient_profile"],
//         mrms: json["mrms"],
//         pName: json["p_name"],
//         mobileNo: json["mobile_no"],
//         emil: json["emil"],
//         dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
//         age: json["age"],
//         gender: json["gender"],
//         aadharNo: json["aadhar_no"],
//         address: json["address"],
//         location: json["location"],
//         pincode: json["pincode"],
//         city: json["city"],
//         district: json["district"],
//         state: json["state"],
//         pass: json["pass"],
//         confirmPss: json["confirm_pss"],
//         preferredLanguage: json["preferred_language"],
//         activeStatus: json["active_status"],
//         deleteStatus: json["delete_status"],
//         reason: json["reason"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         help: json["help"],
//         otp: json["otp"],
//         otpGeneratedAt: json["otp_generated_at"] == null ? null : DateTime.parse(json["otp_generated_at"]),
//         status: json["status"],
//     );

//     Map<String, dynamic> toJson() => {
//         "p_id": pId,
//         "p_jimble_id": pJimbleId,
//         "patient_profile": patientProfile,
//         "mrms": mrms,
//         "p_name": pName,
//         "mobile_no": mobileNo,
//         "emil": emil,
//         "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
//         "age": age,
//         "gender": gender,
//         "aadhar_no": aadharNo,
//         "address": address,
//         "location": location,
//         "pincode": pincode,
//         "city": city,
//         "district": district,
//         "state": state,
//         "pass": pass,
//         "confirm_pss": confirmPss,
//         "preferred_language": preferredLanguage,
//         "active_status": activeStatus,
//         "delete_status": deleteStatus,
//         "reason": reason,
//         "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
//         "help": help,
//         "otp": otp,
//         "otp_generated_at": otpGeneratedAt?.toIso8601String(),
//         "status": status,
//     };
// }

// class Relationship {
//     int? rId;
//     int? pId;
//     String? rJimbleId;
//     dynamic relationship;
//     String? mrms;
//     dynamic familymembername;
//     dynamic dob;
//     dynamic age;
//     dynamic gender;
//     dynamic aadharNo;
//     String? profileImg;

//     Relationship({
//         this.rId,
//         this.pId,
//         this.rJimbleId,
//         this.relationship,
//         this.mrms,
//         this.familymembername,
//         this.dob,
//         this.age,
//         this.gender,
//         this.aadharNo,
//         this.profileImg,
//     });

//     factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
//         rId: json["r_id"],
//         pId: json["p_id"],
//         rJimbleId: json["r_jimble_id"],
//         relationship: json["relationship"],
//         mrms: json["mrms"],
//         familymembername: json["familymembername"],
//         dob: json["dob"],
//         age: json["age"],
//         gender: json["gender"],
//         aadharNo: json["aadhar_no"],
//         profileImg: json["profile_img"],
//     );

//     Map<String, dynamic> toJson() => {
//         "r_id": rId,
//         "p_id": pId,
//         "r_jimble_id": rJimbleId,
//         "relationship": relationship,
//         "mrms": mrms,
//         "familymembername": familymembername,
//         "dob": dob,
//         "age": age,
//         "gender": gender,
//         "aadhar_no": aadharNo,
//         "profile_img": profileImg,
//     };
// }

// To parse this JSON data, do
//
//     final profilemodel = profilemodelFromJson(jsonString);
import 'dart:convert';

Profilemodel profilemodelFromJson(String str) =>
    Profilemodel.fromJson(json.decode(str));

String profilemodelToJson(Profilemodel data) => json.encode(data.toJson());

class Profilemodel {
  bool? status;
  String? message;
  Data? data;

  Profilemodel({
    this.status,
    this.message,
    this.data,
  });

  factory Profilemodel.fromJson(Map<String, dynamic> json) => Profilemodel(
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
    return 'Profilemodel(status: $status, message: $message, data: $data)';
  }
}

class Data {
  Patient? patient;
  List<Relationship>? relationships;

  Data({
    this.patient,
    this.relationships,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        patient:
            json["patient"] == null ? null : Patient.fromJson(json["patient"]),
        relationships: json["relationships"] == null
            ? []
            : List<Relationship>.from(
                json["relationships"]!.map((x) => Relationship.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "patient": patient?.toJson(),
        "relationships": relationships == null
            ? []
            : List<dynamic>.from(relationships!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'Data(patient: $patient, relationships: $relationships)';
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
  DateTime? otpGeneratedAt;
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        help: json["help"],
        otp: json["otp"],
        otpGeneratedAt: json["otp_generated_at"] == null
            ? null
            : DateTime.parse(json["otp_generated_at"]),
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
        "dob": dob == null
            ? null
            : "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
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
        "otp_generated_at": otpGeneratedAt?.toIso8601String(),
        "status": status,
      };

  @override
  String toString() {
    return 'Patient(pId: $pId, pJimbleId: $pJimbleId, patientProfile: $patientProfile, pName: $pName, mobileNo: $mobileNo)';
  }
}

class Relationship {
  int? rId;
  int? pId;
  String? rJimbleId;
  String? relationship;
  String? mrms;
  String? familymembername;
  DateTime? dob;
  int? age;
  String? gender;
  String? aadharNo;
  String? profileImg;
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
        "dob": dob == null
            ? null
            : "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "age": age,
        "gender": gender,
        "aadhar_no": aadharNo,
        "profile_img": profileImg,
        "delete_status": deleteStatus,
      };

  @override
  String toString() {
    return 'Relationship(rId: $rId, familymembername: $familymembername, relationship: $relationship)';
  }
}
