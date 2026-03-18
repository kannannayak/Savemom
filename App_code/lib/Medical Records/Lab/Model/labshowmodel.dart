// To parse this JSON data, do
//
//     final labreportsmodel = labreportsmodelFromJson(jsonString);

import 'dart:convert';

Labreportsmodel labreportsmodelFromJson(String str) => Labreportsmodel.fromJson(json.decode(str));

String labreportsmodelToJson(Labreportsmodel data) => json.encode(data.toJson());

class Labreportsmodel {
    bool? status;
    int? count;
    List<LabReport>? labReports;

    Labreportsmodel({
        this.status,
        this.count,
        this.labReports,
    });

    factory Labreportsmodel.fromJson(Map<String, dynamic> json) => Labreportsmodel(
        status: json["status"],
        count: json["count"],
        labReports: json["lab_reports"] == null ? [] : List<LabReport>.from(json["lab_reports"]!.map((x) => LabReport.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
        "lab_reports": labReports == null ? [] : List<dynamic>.from(labReports!.map((x) => x.toJson())),
    };
}

class LabReport {
    int? sno;
    int? id;
    int? reportId;
    int? pId;
    int? rId;
    DateTime? pDate;
    String? type;
    String? fileName;
    String? fileUrl;

    LabReport({
        this.sno,
        this.id,
        this.reportId,
        this.pId,
        this.rId,
        this.pDate,
        this.type,
        this.fileName,
        this.fileUrl,
    });

    factory LabReport.fromJson(Map<String, dynamic> json) => LabReport(
        sno: json["sno"],
        id: json["id"],
        reportId: json["report_id"],
        pId: json["p_id"],
        rId: json["r_id"],
        pDate: json["p_date"] == null ? null : DateTime.parse(json["p_date"]),
        type: json["type"],
        fileName: json["file_name"],
        fileUrl: json["file_url"],
    );

    Map<String, dynamic> toJson() => {
        "sno": sno,
        "id": id,
        "report_id": reportId,
        "p_id": pId,
        "r_id": rId,
        "p_date": "${pDate!.year.toString().padLeft(4, '0')}-${pDate!.month.toString().padLeft(2, '0')}-${pDate!.day.toString().padLeft(2, '0')}",
        "type": type,
        "file_name": fileName,
        "file_url": fileUrl,
    };
}
