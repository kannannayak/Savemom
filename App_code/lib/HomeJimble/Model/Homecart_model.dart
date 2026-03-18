// To parse this JSON data, do
//
//     final homecartModel = homecartModelFromJson(jsonString);

import 'dart:convert';

HomecartModel homecartModelFromJson(String str) => HomecartModel.fromJson(json.decode(str));

String homecartModelToJson(HomecartModel data) => json.encode(data.toJson());

class HomecartModel {
    bool? status;
    List<Appointment>? appointments;

    HomecartModel({
        this.status,
        this.appointments,
    });

    factory HomecartModel.fromJson(Map<String, dynamic> json) => HomecartModel(
        status: json["status"],
        appointments: json["appointments"] == null ? [] : List<Appointment>.from(json["appointments"]!.map((x) => Appointment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "appointments": appointments == null ? [] : List<dynamic>.from(appointments!.map((x) => x.toJson())),
    };

    @override
    String toString() {
        return 'HomecartModel{status: $status, appointments: $appointments}';
    }
}

class Appointment {
    String? name;
    int? totalFee;
    String? apptNo;
    SpDetails? spDetails;
    GpDetails? gpDetails;

    Appointment({
        this.name,
        this.totalFee,
        this.apptNo,
        this.spDetails,
        this.gpDetails,
    });

    factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        name: json["name"],
        totalFee: json["total_fee"],
        apptNo: json["appt_no"],
        spDetails: json["sp_details"] == null ? null : SpDetails.fromJson(json["sp_details"]),
        gpDetails: json["gp_details"] == null ? null : GpDetails.fromJson(json["gp_details"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "total_fee": totalFee,
        "appt_no": apptNo,
        "sp_details": spDetails?.toJson(),
        "gp_details": gpDetails?.toJson(),
    };

    @override
    String toString() {
        return 'Appointment{name: $name, totalFee: $totalFee, apptNo: $apptNo, spDetails: $spDetails, gpDetails: $gpDetails}';
    }
}

class GpDetails {
    int? slotId;
    String? apptNo;
    String? clinicName;
    String? day;
    int? gpAppointmentId;
    DateTime? gpAppointmentDate;
    String? gpAppointmentTime;
    int? gpBookingSlot;
    String? pId;
    String? rId;
    String? gpJimblrId;
    int? gId;
    String? gpJimbleId;
    String? gProfile;
    String? gName;
    String? mobileNo;
    String? email;
    String? dateOfBirth;
    String? age;
    String? gender;
    String? aadhar;
    String? medicalCouncil;
    String? councilRegNo;
    String? councilCertificate;
    String? qualificatin;
    String? language;
    String? signature;
    String? accName;
    String? bankName;
    String? accNo;
    String? accType;
    String? ifscCode;
    String? panNo;
    String? pass;
    String? confirmPass;
    String? activeStatus;
    int? deleteStatus;
    String? reason;
    DateTime? createdAt;
    int? help;
    String? otp;
    DateTime? otpExpiry;
    String? status;
    int? approvalStatus;
    int? sessionStatus;
    String? appointmentType;
    String? clinicPhoneno;
    String? clinicAddress;
    String? location;
    String? pincode;
    String? city;
    String? district;
    String? state;

    GpDetails({
        this.slotId,
        this.apptNo,
        this.clinicName,
        this.day,
        this.gpAppointmentId,
        this.gpAppointmentDate,
        this.gpAppointmentTime,
        this.gpBookingSlot,
        this.pId,
        this.rId,
        this.gpJimblrId,
        this.gId,
        this.gpJimbleId,
        this.gProfile,
        this.gName,
        this.mobileNo,
        this.email,
        this.dateOfBirth,
        this.age,
        this.gender,
        this.aadhar,
        this.medicalCouncil,
        this.councilRegNo,
        this.councilCertificate,
        this.qualificatin,
        this.language,
        this.signature,
        this.accName,
        this.bankName,
        this.accNo,
        this.accType,
        this.ifscCode,
        this.panNo,
        this.pass,
        this.confirmPass,
        this.activeStatus,
        this.deleteStatus,
        this.reason,
        this.createdAt,
        this.help,
        this.otp,
        this.otpExpiry,
        this.status,
        this.approvalStatus,
        this.sessionStatus,
        this.appointmentType,
        this.clinicPhoneno,
        this.clinicAddress,
        this.location,
        this.pincode,
        this.city,
        this.district,
        this.state,
    });

    factory GpDetails.fromJson(Map<String, dynamic> json) => GpDetails(
        slotId: json["slot_id"],
        apptNo: json["appt_no"],
        clinicName: json["clinic_name"],
        day: json["day"],
        gpAppointmentId: json["gp_appointment_id"],
        gpAppointmentDate: json["gp_appointment_date"] == null ? null : DateTime.parse(json["gp_appointment_date"]),
        gpAppointmentTime: json["gp_appointment_time"],
        gpBookingSlot: json["gp_booking_slot"],
        pId: json["p_id"],
        rId: json["r_id"],
        gpJimblrId: json["gp_jimblr_id"],
        gId: json["g_id"],
        gpJimbleId: json["gp_jimble_id"],
        gProfile: json["g_profile"],
        gName: json["g_name"],
        mobileNo: json["mobile_no"],
        email: json["email"],
        dateOfBirth: json["date_of_birth"],
        age: json["age"],
        gender: json["gender"],
        aadhar: json["aadhar"],
        medicalCouncil: json["medical_council"],
        councilRegNo: json["council_reg_no"],
        councilCertificate: json["council_certificate"],
        qualificatin: json["qualificatin"],
        language: json["language"],
        signature: json["signature"],
        accName: json["acc_name"],
        bankName: json["bank_name"],
        accNo: json["acc_no"],
        accType: json["acc_type"],
        ifscCode: json["ifsc_code"],
        panNo: json["pan_no"],
        pass: json["pass"],
        confirmPass: json["confirm_pass"],
        activeStatus: json["active_status"],
        deleteStatus: json["delete_status"],
        reason: json["reason"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        help: json["help"],
        otp: json["otp"],
        otpExpiry: json["otp_expiry"] == null ? null : DateTime.parse(json["otp_expiry"]),
        status: json["status"],
        approvalStatus: json["approval_status"],
        sessionStatus: json["session_status"],
        appointmentType: json["appointment_type"],
        clinicPhoneno: json["clinic_phoneno"],
        clinicAddress: json["clinic_address"],
        location: json["location"],
        pincode: json["pincode"],
        city: json["city"],
        district: json["district"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "slot_id": slotId,
        "appt_no": apptNo,
        "clinic_name": clinicName,
        "day": day,
        "gp_appointment_id": gpAppointmentId,
        "gp_appointment_date": "${gpAppointmentDate!.year.toString().padLeft(4, '0')}-${gpAppointmentDate!.month.toString().padLeft(2, '0')}-${gpAppointmentDate!.day.toString().padLeft(2, '0')}",
        "gp_appointment_time": gpAppointmentTime,
        "gp_booking_slot": gpBookingSlot,
        "p_id": pId,
        "r_id": rId,
        "gp_jimblr_id": gpJimblrId,
        "g_id": gId,
        "gp_jimble_id": gpJimbleId,
        "g_profile": gProfile,
        "g_name": gName,
        "mobile_no": mobileNo,
        "email": email,
        "date_of_birth": dateOfBirth,
        "age": age,
        "gender": gender,
        "aadhar": aadhar,
        "medical_council": medicalCouncil,
        "council_reg_no": councilRegNo,
        "council_certificate": councilCertificate,
        "qualificatin": qualificatin,
        "language": language,
        "signature": signature,
        "acc_name": accName,
        "bank_name": bankName,
        "acc_no": accNo,
        "acc_type": accType,
        "ifsc_code": ifscCode,
        "pan_no": panNo,
        "pass": pass,
        "confirm_pass": confirmPass,
        "active_status": activeStatus,
        "delete_status": deleteStatus,
        "reason": reason,
        "created_at": createdAt?.toIso8601String(),
        "help": help,
        "otp": otp,
        "otp_expiry": otpExpiry?.toIso8601String(),
        "status": status,
        "approval_status": approvalStatus,
        "session_status": sessionStatus,
        "appointment_type": appointmentType,
        "clinic_phoneno": clinicPhoneno,
        "clinic_address": clinicAddress,
        "location": location,
        "pincode": pincode,
        "city": city,
        "district": district,
        "state": state,
    };

    @override
    String toString() {
        return 'GpDetails{slotId: $slotId, apptNo: $apptNo, clinicName: $clinicName, day: $day, gpAppointmentId: $gpAppointmentId, gpAppointmentDate: $gpAppointmentDate, gpAppointmentTime: $gpAppointmentTime, gpBookingSlot: $gpBookingSlot, pId: $pId, rId: $rId, gpJimblrId: $gpJimblrId, gId: $gId, gpJimbleId: $gpJimbleId, gProfile: $gProfile, gName: $gName, mobileNo: $mobileNo, email: $email, dateOfBirth: $dateOfBirth, age: $age, gender: $gender, aadhar: $aadhar, medicalCouncil: $medicalCouncil, councilRegNo: $councilRegNo, councilCertificate: $councilCertificate, qualificatin: $qualificatin, language: $language, signature: $signature, accName: $accName, bankName: $bankName, accNo: $accNo, accType: $accType, ifscCode: $ifscCode, panNo: $panNo, pass: $pass, confirmPass: $confirmPass, activeStatus: $activeStatus, deleteStatus: $deleteStatus, reason: $reason, createdAt: $createdAt, help: $help, otp: $otp, otpExpiry: $otpExpiry, status: $status, approvalStatus: $approvalStatus, sessionStatus: $sessionStatus, appointmentType: $appointmentType, clinicPhoneno: $clinicPhoneno, clinicAddress: $clinicAddress, location: $location, pincode: $pincode, city: $city, district: $district, state: $state}';
    }
}

class SpDetails {
    int? slotId;
    String? apptNo;
    int? spAppointmentId;
    DateTime? spAppointmentDate;
    String? day;
    String? spAppointmentTime;
    int? bookigSlot;
    String? pId;
    int? rId;
    String? sJimbleId;
    int? sId;
    String? sProfile;
    String? sName;
    String? contactNo;
    String? email;
    DateTime? dateOfBirth;
    String? age;
    String? gender;
    String? aadharNo;
    String? medicalCouncil;
    String? councilRegNo;
    String? councilCertificate;
    String? qualificatin;
    String? speciality;
    String? language;
    String? clinicName;
    String? clinicAddress;
    String? lacation;
    String? pincode;
    String? city;
    String? district;
    String? state;
    String? signature;
    String? conFee;
    String? accName;
    String? bankName;
    String? accNo;
    String? accType;
    String? ifscCode;
    String? panNo;
    String? pass;
    String? confirmPass;
    int? activeStatus;
    int? deleteStatus;
    dynamic reason;
    DateTime? createdAt;
    int? help;
    String? otp;
    DateTime? otpGeneratedAt;
    String? status;
    int? approvalStatus;
    int? sessionStatus;
    String? appointmentType;

    SpDetails({
        this.slotId,
        this.apptNo,
        this.spAppointmentId,
        this.spAppointmentDate,
        this.day,
        this.spAppointmentTime,
        this.bookigSlot,
        this.pId,
        this.rId,
        this.sJimbleId,
        this.sId,
        this.sProfile,
        this.sName,
        this.contactNo,
        this.email,
        this.dateOfBirth,
        this.age,
        this.gender,
        this.aadharNo,
        this.medicalCouncil,
        this.councilRegNo,
        this.councilCertificate,
        this.qualificatin,
        this.speciality,
        this.language,
        this.clinicName,
        this.clinicAddress,
        this.lacation,
        this.pincode,
        this.city,
        this.district,
        this.state,
        this.signature,
        this.conFee,
        this.accName,
        this.bankName,
        this.accNo,
        this.accType,
        this.ifscCode,
        this.panNo,
        this.pass,
        this.confirmPass,
        this.activeStatus,
        this.deleteStatus,
        this.reason,
        this.createdAt,
        this.help,
        this.otp,
        this.otpGeneratedAt,
        this.status,
        this.approvalStatus,
        this.sessionStatus,
        this.appointmentType,
    });

    factory SpDetails.fromJson(Map<String, dynamic> json) => SpDetails(
        slotId: json["slot_id"],
        apptNo: json["appt_no"],
        spAppointmentId: json["sp_appointment_id"],
        spAppointmentDate: json["sp_appointment_date"] == null ? null : DateTime.parse(json["sp_appointment_date"]),
        day: json["day"],
        spAppointmentTime: json["sp_appointment_time"],
        bookigSlot: json["bookig_slot"],
        pId: json["p_id"],
        rId: json["r_id"],
        sJimbleId: json["s_jimble_id"],
        sId: json["s_id"],
        sProfile: json["s_profile"],
        sName: json["s_name"],
        contactNo: json["Contact_no"],
        email: json["email"],
        dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
        age: json["age"],
        gender: json["gender"],
        aadharNo: json["aadhar_no"],
        medicalCouncil: json["medical_council"],
        councilRegNo: json["council_reg_no"],
        councilCertificate: json["council_certificate"],
        qualificatin: json["qualificatin"],
        speciality: json["speciality"],
        language: json["language"],
        clinicName: json["clinic_name"],
        clinicAddress: json["clinic_address"],
        lacation: json["lacation"],
        pincode: json["pincode"],
        city: json["city"],
        district: json["district"],
        state: json["state"],
        signature: json["signature"],
        conFee: json["con_fee"],
        accName: json["acc_name"],
        bankName: json["bank_name"],
        accNo: json["acc_no"],
        accType: json["acc_type"],
        ifscCode: json["ifsc_code"],
        panNo: json["pan_no"],
        pass: json["pass"],
        confirmPass: json["confirm_pass"],
        activeStatus: json["active_status"],
        deleteStatus: json["delete_status"],
        reason: json["reason"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        help: json["help"],
        otp: json["otp"],
        otpGeneratedAt: json["otp_generated_at"] == null ? null : DateTime.parse(json["otp_generated_at"]),
        status: json["status"],
        approvalStatus: json["approval_status"],
        sessionStatus: json["session_status"],
        appointmentType: json["appointment_type"],
    );

    Map<String, dynamic> toJson() => {
        "slot_id": slotId,
        "appt_no": apptNo,
        "sp_appointment_id": spAppointmentId,
        "sp_appointment_date": "${spAppointmentDate!.year.toString().padLeft(4, '0')}-${spAppointmentDate!.month.toString().padLeft(2, '0')}-${spAppointmentDate!.day.toString().padLeft(2, '0')}",
        "day": day,
        "sp_appointment_time": spAppointmentTime,
        "bookig_slot": bookigSlot,
        "p_id": pId,
        "r_id": rId,
        "s_jimble_id": sJimbleId,
        "s_id": sId,
        "s_profile": sProfile,
        "s_name": sName,
        "Contact_no": contactNo,
        "email": email,
        "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "age": age,
        "gender": gender,
        "aadhar_no": aadharNo,
        "medical_council": medicalCouncil,
        "council_reg_no": councilRegNo,
        "council_certificate": councilCertificate,
        "qualificatin": qualificatin,
        "speciality": speciality,
        "language": language,
        "clinic_name": clinicName,
        "clinic_address": clinicAddress,
        "lacation": lacation,
        "pincode": pincode,
        "city": city,
        "district": district,
        "state": state,
        "signature": signature,
        "con_fee": conFee,
        "acc_name": accName,
        "bank_name": bankName,
        "acc_no": accNo,
        "acc_type": accType,
        "ifsc_code": ifscCode,
        "pan_no": panNo,
        "pass": pass,
        "confirm_pass": confirmPass,
        "active_status": activeStatus,
        "delete_status": deleteStatus,
        "reason": reason,
        "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "help": help,
        "otp": otp,
        "otp_generated_at": otpGeneratedAt?.toIso8601String(),
        "status": status,
        "approval_status": approvalStatus,
        "session_status": sessionStatus,
        "appointment_type": appointmentType,
    };

    @override
    String toString() {
        return 'SpDetails{slotId: $slotId, apptNo: $apptNo, spAppointmentId: $spAppointmentId, spAppointmentDate: $spAppointmentDate, day: $day, spAppointmentTime: $spAppointmentTime, bookigSlot: $bookigSlot, pId: $pId, rId: $rId, sJimbleId: $sJimbleId, sId: $sId, sProfile: $sProfile, sName: $sName, contactNo: $contactNo, email: $email, dateOfBirth: $dateOfBirth, age: $age, gender: $gender, aadharNo: $aadharNo, medicalCouncil: $medicalCouncil, councilRegNo: $councilRegNo, councilCertificate: $councilCertificate, qualificatin: $qualificatin, speciality: $speciality, language: $language, clinicName: $clinicName, clinicAddress: $clinicAddress, lacation: $lacation, pincode: $pincode, city: $city, district: $district, state: $state, signature: $signature, conFee: $conFee, accName: $accName, bankName: $bankName, accNo: $accNo, accType: $accType, ifscCode: $ifscCode, panNo: $panNo, pass: $pass, confirmPass: $confirmPass, activeStatus: $activeStatus, deleteStatus: $deleteStatus, reason: $reason, createdAt: $createdAt, help: $help, otp: $otp, otpGeneratedAt: $otpGeneratedAt, status: $status, approvalStatus: $approvalStatus, sessionStatus: $sessionStatus, appointmentType: $appointmentType}';
    }
}