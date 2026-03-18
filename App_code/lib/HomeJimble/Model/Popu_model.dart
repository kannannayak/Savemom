import 'dart:convert';

Patient_CancellationPopUpModel spCancellationPopUpModelFromJson(String str) =>
    Patient_CancellationPopUpModel.fromJson(json.decode(str));

String Patient_CancellationPopUpModelToJson(
        Patient_CancellationPopUpModel data) =>
    json.encode(data.toJson());

class Patient_CancellationPopUpModel {
  bool? status;
  bool? popup;
  int? count;
  List<Popudata>? data;

  Patient_CancellationPopUpModel({
    this.status,
    this.popup,
    this.count,
    this.data,
  });

  factory Patient_CancellationPopUpModel.fromJson(Map<String, dynamic> json) =>
      Patient_CancellationPopUpModel(
        status: json["status"],
        popup: json["popup"],
        count: json["count"],
        data: json["data"] == null
            ? []
            : List<Popudata>.from(
                json["data"]!.map((x) => Popudata.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "popup": popup,
        "count": count,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  @override
  String toString() =>
      'SpCancellationPopUpModel(status: $status, popup: $popup,count: $count, data: $data)';
}

class Popudata {
  String? apptNo;
  dynamic fees;
  int? feesStatus;
  int? slotId;

  Popudata({
    this.apptNo,
    this.fees,
    this.feesStatus,
    this.slotId,
  });

  factory Popudata.fromJson(Map<String, dynamic> json) => Popudata(
        apptNo: json["appt_no"],
        fees: json["fees"],
        feesStatus: json["fees_status"],
        slotId: json["slot_id"],
      );

  Map<String, dynamic> toJson() => {
        "appt_no": apptNo,
        "fees": fees,
        "fees_status": feesStatus,
        "slot_id": slotId,
      };

  @override
  String toString() =>
      'Datum(apptNo: $apptNo, fees: $fees, feesStatus: $feesStatus, slotId: $slotId)';
}
