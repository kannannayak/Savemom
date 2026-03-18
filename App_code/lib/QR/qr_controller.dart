import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'package:savemom/Cache/Cache_helper.dart';
import 'package:savemom/Medical%20Records/Medical%20Records.dart';
import 'package:savemom/Network_Api/Apiend_points.dart';
import 'package:savemom/QR/qr_model.dart';


class QrController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
 RxnInt pageroute = RxnInt(); 

  var qrScannerData = Rx<QrData?>(null);

  final String apiUrl = ApiendPoints.baseURL + ApiendPoints.qrScanner;

  void qrScannerApi({
    String? pJimbleId,
    String? pID,
    String? rID,
    String? rJimble,
  }) async {
    print("Qr Api Calling");
    print("Pid: $pJimbleId");
    print("Pjimble: $pID");
    print("Rid : $rID");
    print("RJimble : $rJimble");

    await Cachehelper.savedata("pPid", pID!);
    await Cachehelper.savedata("rPid", rID!);
    await Cachehelper.savedata("pJimbleId", pJimbleId!);
    await Cachehelper.savedata("rJimbleId", rJimble!);

    var storePid1 = await Cachehelper.getSaveddata("pPid");
    var storeRid1 = await Cachehelper.getSaveddata("rPid");
    var storePjimble1 = await Cachehelper.getSaveddata("pJimbleId");
    var storeRjimble1 = await Cachehelper.getSaveddata("rJimbleId");

    print(
      "Store value : $storePjimble1 : $storePid1 : $storeRjimble1 : $storeRid1",
    );

    try {
      isLoading(true);

      var reqData = {
        // "p_jimble_id": pJimbleId
        "r_id": rID,
        "p_id": pID,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(reqData),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var result = QrScannerModel.fromJson(json.decode(response.body));
        if (result.status == true && result.data != null) {
          qrScannerData.value = result.data;
          print('QR Scanner Data: ${qrScannerData.value}');
          Get.to(() => MedicalRecords());
        } else {
          Get.snackbar("Error", result.message ?? "No data found");
          qrScannerData.value = null;
        }
        errorMessage.value = '';
      } else {
        Get.snackbar("Error", "Failed to load Qr data");
      }
    } catch (e) {
      errorMessage.value = 'Failed to parse data: $e';
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
