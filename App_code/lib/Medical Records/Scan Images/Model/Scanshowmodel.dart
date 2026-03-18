class Scanreportsmodel {
  bool? status;
  List<Datum1>? data;

  Scanreportsmodel({
    this.status,
    this.data,
  });

  factory Scanreportsmodel.fromJson(Map<String, dynamic> json) =>
      Scanreportsmodel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum1>.from(json["data"]!.map((x) => Datum1.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'Scanreportsmodel{status: $status, data: $data}';
  }
}

class Datum1 {
  String? folderName;
  List<FileElement>? files;

  Datum1({
    this.folderName,
    this.files,
  });

  factory Datum1.fromJson(Map<String, dynamic> json) => Datum1(
        folderName: json["folder_name"],
        files: json["files"] == null
            ? []
            : List<FileElement>.from(
                json["files"]!.map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "folder_name": folderName,
        "files": files == null
            ? []
            : List<dynamic>.from(files!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'Datum1{folderName: $folderName, files: $files}';
  }
}

class FileElement {
  int? id;
  int? sno;
  int? reportId;
  int? pId;
  int? rId;
  DateTime? pDate;
  String? type;
  String? fileName;
  List<String>? fileUrl;

  FileElement({
    this.id,
    this.sno,
    this.reportId,
    this.pId,
    this.rId,
    this.pDate,
    this.type,
    this.fileName,
    this.fileUrl,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        sno: json["sno"],
        reportId: json["report_id"],
        pId: json["p_id"],
        rId: json["r_id"],
        pDate: json["p_date"] == null ? null : DateTime.parse(json["p_date"]),
        type: json["type"],
        fileName: json["file_name"],
        fileUrl: json["file_url"] == null
            ? []
            : List<String>.from(json["file_url"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sno": sno,
        "report_id": reportId,
        "p_id": pId,
        "r_id": rId,
        "p_date":
            "${pDate!.year.toString().padLeft(4, '0')}-${pDate!.month.toString().padLeft(2, '0')}-${pDate!.day.toString().padLeft(2, '0')}",
        "type": type,
        "file_name": fileName,
        "file_url":
            fileUrl == null ? [] : List<dynamic>.from(fileUrl!.map((x) => x)),
      };

  @override
  String toString() {
    return 'FileElement{id: $id, sno: $sno, reportId: $reportId, pId: $pId, rId: $rId, pDate: $pDate, type: $type, fileName: $fileName, fileUrl: $fileUrl}';
  }
}
