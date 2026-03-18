// // class Registermodel {
// //   bool? status;
// //   String? message;
// //   String? pId;

// //   Registermodel({this.status, this.message, this.pId});

// //   factory Registermodel.fromJson(Map<String, dynamic> json) {
// //     print("Parsing JSON: $json"); // Debug raw JSON
// //     return Registermodel(
// //       status: json["status"],
// //       message: json["message"],
// //       pId: json["p_id"] ?? json["pid"], // Try alternate keys
// //     );
// //   }

// //   @override
// //   String toString() => 'Registermodel(status: $status, message: $message, pId: $pId)';
// // }
// // To parse this JSON data, do
// //
// //     final registermodel = registermodelFromJson(jsonString);

// import 'dart:convert';

// Registermodel registermodelFromJson(String str) => Registermodel.fromJson(json.decode(str));

// String registermodelToJson(Registermodel data) => json.encode(data.toJson());

// class Registermodel {
//     bool? status;
//     String? message;
//     String? pId;
//     String? nextStep;

//     Registermodel({
//         this.status,
//         this.message,
//         this.pId,
//         this.nextStep,
//     });

//     factory Registermodel.fromJson(Map<String, dynamic> json) => Registermodel(
//         status: json["status"],
//         message: json["message"],
//         pId: json["p_id"],
//         nextStep: json["next_step"],
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "p_id": pId,
//         "next_step": nextStep,
//     };
// }
class Registermodel {
  bool? status;
  String? message;
  String? pId;
  String? nextStep;

  Registermodel({
    this.status,
    this.message,
    this.pId,
    this.nextStep,
  });

  factory Registermodel.fromJson(Map<String, dynamic> json) => Registermodel(
        status: json["status"],
        message: json["message"]?.toString(),
        pId: json["p_id"]?.toString(),
        nextStep: json["next_step"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "p_id": pId,
        "next_step": nextStep,
      };
}
