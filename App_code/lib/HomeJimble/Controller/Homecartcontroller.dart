import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import 'package:savemom/Cache/Cache_helper.dart';
import 'package:savemom/HomeJimble/Model/Homecart_model.dart';
import 'package:savemom/Network_Api/Apiend_points.dart';

class Homecartcontroller extends GetxController {
  var alldata = RxList<HomecartModel>([]);
  var Appoin = RxList<Appointment>([]);
  var s_cart = RxList<SpDetails>([]);
  var gp_cart = RxList<GpDetails>([]);
  var isLoading = false.obs;
  Future homecartshowapi() async {
    Appoin.clear();
    print("appoiuntment value from list =============>$Appoin");
    final getsavedspID = await Cachehelper.getSaveddata("p_id") ?? "";
    final savedRId = await Cachehelper.getSaveddata("rId");
    var apiUrl = ApiendPoints.maniurl + ApiendPoints.homecart_details;
    print("gpsolt pass url : ${apiUrl}");

    try {
      isLoading.value = true;
      var requestData = {"p_id": getsavedspID, "r_id": savedRId ?? ""};
      print("gpsolt reqdata passing :${requestData}");
      var responseData =
          await http.post(Uri.parse(apiUrl), body: jsonEncode(requestData));

      print("response : ${responseData.body}");
      if (responseData.statusCode == 200) {
        print("statusCode 200 pass");
        print("appoiuntment value from list =============>$Appoin");
        final doctorsold =
            HomecartModel.fromJson(jsonDecode(responseData.body));
        print("appoiuntment value from list =============>$Appoin");
        if (doctorsold.status == true) {
          if (doctorsold.appointments != null &&
              doctorsold.appointments!.isNotEmpty) {
            print("GP Details: ${doctorsold.appointments![0].gpDetails}");
          } else {
            print("No appointments available.");
          }
          print(
              "gp ssss ,s kkkkkkkkkkkkk: ${doctorsold.appointments![0].spDetails}");

          Appoin.value = doctorsold.appointments ?? [];
          print("appoiuntment value from list =============>$Appoin");

          Appoin.value = [];
          // Appoin.value = doctorsold.appointments ?? [];
          Appoin.assignAll(doctorsold.appointments!);

          s_cart.value = List<SpDetails>.from(doctorsold.appointments ?? []);
          gp_cart.value = List<GpDetails>.from(doctorsold.appointments ?? []);
          print("gp_QQQQQQQQQQQQQQQQQQQQQQQQ :${gp_cart.iterator.toString()}");
          print("doctor model pass : ${doctorsold.status}");

          print(
              "S kkkkkk : ${doctorsold.appointments!.iterator.current.spDetails}");
        } else {
          // Get.snackbar(
          //   messageText: Text(
          //     doctorsold.message.toString(),
          //     style: TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white),
          //   ),
          //   "Alert",
          //   "",
          // );
        }
      }
    } on http.ClientException catch (e) {
      print("Network error: $e");
      // Get.snackbar(
      //   "Network Error",
      //   "Please check your internet connection.",
      //   backgroundColor: Top,
      // );
    } catch (E) {
      print(E);
    } finally {
      isLoading.value = false;
    }
  }
}
