// import 'dart:convert';

// import 'package:get/get.dart';

// import 'package:jimbel_patent/Network_Api/Apiend_points.dart';
// import 'package:http/http.dart' as http;
// import 'package:jimbel_patent/Register/Model/VerifiedModel.dart';

// class Verifiedcontroller extends GetxController {
//   var verified = Verifiedmodel().obs;
//   Future<void> verifiedapi() async {
//     try {
//       final apiUrl = ApiendPoints.maniurl + ApiendPoints.register;
//       print("enter1 verified");
//       var reqData = {
//         "api_key": "Jimble@123",
//         "verify_otp": true,
//         "p_id": "242",
//         "otp": "6159"
//       };
//       print("enter2 verified");
//       var respones =
//           await http.post(Uri.parse(apiUrl), body: jsonEncode(reqData));
//       print("enter3 verified");
//       print(respones);
//       if (respones.statusCode == 200) {
//         print("enter4 verified");
//         final rdelete = jsonDecode(respones.body);
//         var rdelete2 = Verifiedmodel.fromJson(rdelete);
//         if (rdelete2.status == true) {
//           verified.value = rdelete2;

//           print(rdelete2.status);
//           print(rdelete2.message);
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
