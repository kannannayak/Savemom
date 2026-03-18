import 'dart:convert';

Medicalrecordmodel medicalrecordmodelFromJson(String str) =>
    Medicalrecordmodel.fromJson(json.decode(str));

String medicalrecordmodelToJson(Medicalrecordmodel data) =>
    json.encode(data.toJson());

class Medicalrecordmodel {
  final bool? status;
  final String? message;
  final String? reportId;
  final Map<String, List<String>>? uploadedFiles;

  Medicalrecordmodel({
    this.status,
    this.message,
    this.reportId,
    this.uploadedFiles,
  });

  factory Medicalrecordmodel.fromJson(Map<String, dynamic> json) =>
      Medicalrecordmodel(
        status: json["status"],
        message: json["message"],
        reportId: json["report_id"],
        uploadedFiles: json["uploaded_files"] == null
            ? null
            : Map<String, List<String>>.from(
                json["uploaded_files"].map(
                  (key, value) => MapEntry(
                    key,
                    List<String>.from(value.map((x) => x)),
                  ),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "report_id": reportId,
        "uploaded_files": uploadedFiles == null
            ? null
            : Map<dynamic, dynamic>.from(
                uploadedFiles!.map(
                  (key, value) => MapEntry(
                    key,
                    List<dynamic>.from(value.map((x) => x)),
                  ),
                ),
              )
      };

  @override
  String toString() {
    return 'Medicalrecordmodel(status: $status, message: $message, reportId: $reportId, uploadedFiles: $uploadedFiles)';
  }
}

// import 'dart:convert';

// Medicalrecordmodel medicalrecordmodelFromJson(String str) => Medicalrecordmodel.fromJson(json.decode(str));

// String medicalrecordmodelToJson(Medicalrecordmodel data) => json.encode(data.toJson());

// class Medicalrecordmodel {
//     bool? status;
//     String? message;
//     String? reportId;
//     Map<String, List<String>>? uploadedFiles;

//     Medicalrecordmodel({
//         this.status,
//         this.message,
//         this.reportId,
//         this.uploadedFiles,
//     });

//     factory Medicalrecordmodel.fromJson(Map<String, dynamic> json) => Medicalrecordmodel(
//         status: json["status"],
//         message: json["message"],
//         reportId: json["report_id"],
//         uploadedFiles: Map.from(json["uploaded_files"]!).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "report_id": reportId,
//         "uploaded_files": Map.from(uploadedFiles!).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
//     };
// }
