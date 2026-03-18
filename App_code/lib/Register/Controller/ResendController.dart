// import 'dart:convert';

// import 'package:get/get.dart';

// import 'package:jimbel_patent/Network_Api/Apiend_points.dart';
// import 'package:http/http.dart' as http;
// import 'package:jimbel_patent/Register/Model/ResendModel.dart';

// class Resendcontroller extends GetxController {
//   var resend = ResentModel().obs;
//   Future<void> verifiedapi() async {
//     try {
//       final apiUrl = ApiendPoints.maniurl + ApiendPoints.register;
//       print("enter1 resend ");
//       var reqData = {
//         {"api_key": "Jimble@123", "resend_otp": true, "p_id": "242"}
//       };
//       print("enter2 resend ");
//       var respones =
//           await http.post(Uri.parse(apiUrl), body: jsonEncode(reqData));
//       print("enter3 resend ");
//       print(respones);
//       if (respones.statusCode == 200) {
//         print("enter4 resend ");
//         final rdelete = jsonDecode(respones.body);
//         var rdelete2 = ResentModel.fromJson(rdelete);
//         if (rdelete2.status == true) {
//           resend.value = rdelete2;

//           print(rdelete2.status);
//           print(rdelete2.message);
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
