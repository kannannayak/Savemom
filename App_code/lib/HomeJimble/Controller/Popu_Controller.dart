// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:jimbel_patent/Color.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:jimbel_patent/Cache/Cache_helper.dart';
// import 'package:jimbel_patent/HomeJimble/Model/Popu_model.dart';
// import 'package:jimbel_patent/Network_Api/Apiend_points.dart';

// class CancellationPopupAlertController extends GetxController {
//   var isLoading = false.obs;

//   Timer? _popupTimer;

//   @override
//   void onInit() {
//     super.onInit();

//     _popupTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       completeCancellationPopUpApi();
//     });
//   }

//   final Set<String> _shownPopups = {};

//   @override
//   void onClose() {
//     _popupTimer?.cancel(); // Stop timer when the page/controller is closed
//     super.onClose();
//   }

//   /// complte cancellatiojn pop-up
//   var completeCancellationPopUpData = RxList<Popudata?>([]);
//   Future<void> completeCancellationPopUpApi() async {
//     try {
//       print("complete cancellationPopUp appointment api calling...");
//       final getsavedspID = await Cachehelper.getSaveddata("p_id") ?? "";
//       final savedRId = await Cachehelper.getSaveddata("rId") ?? "";

//       final baseUrl = ApiendPoints.maniurl + ApiendPoints.Popup;

//       var apiUrl = Uri.parse(baseUrl);
//       print("api url : $apiUrl");

//       final response = await http.post(
//         apiUrl,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({"p_id": getsavedspID, "r_id": savedRId ?? ""}),
//       );

//       if (response.statusCode == 200) {
//         print("response code: ${response.statusCode}");
//         var result =
//             Patient_CancellationPopUpModel.fromJson(jsonDecode(response.body));

//         if (result.status == true && result.data != null) {
//           completeCancellationPopUpData.value = result.data!;
//           if (result.count == 1) {
//             showAlertCancellationSuccess();
//           }
//         } else {
//           print("complete cancellationPopUp appointment error.");
//         }
//       } else {
//         print("Error response");
//         print("response code: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("complete cancellation complete PopUp appointment exception $e");
//     }
//   }

//   /// ✅ Dialog Function
//   Future<void> showAlertCancellationSuccess() async {
//     Get.dialog(
//       barrierDismissible: false,
//       AlertDialog(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         "You have missed the consultation. Your appointment is cancelled.",
//                         softWrap: true,
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontFamily: 'InterBold',
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Container(
//                         width: 58,
//                         height: 32,
//                         decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(offset: Offset(0, 4), blurRadius: 3),
//                           ],
//                           color: Top,
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(
//                             color: Colors.black,
//                             width: 1,
//                           ),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "OK",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
