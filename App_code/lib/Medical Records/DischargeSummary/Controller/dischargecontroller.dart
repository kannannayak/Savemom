import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:savemom/Cache/Cache_helper.dart';
import 'package:savemom/Color.dart';
import 'package:savemom/Medical%20Records/Medical%20Records.dart';
import 'package:savemom/Medical%20Records/Scan%20Images/Model/Scanshowmodel.dart';
import 'package:savemom/Medical%20Records/Scan%20Images/Model/deletefilemodel.dart';
import 'package:savemom/Network_Api/Apiend_points.dart';


class Dischargecontroller extends GetxController {
  var scanData = RxList<Datum1>([]);
  var scanimages = [].obs;
  var imaeList = [].obs;

  @override
  void onInit() {
    super.onInit();
    scanreportapi();
  }

  Future<void> scanreportapi() async {
    // final getsavedspID = await Cachehelper.getSaveddata("p_id") ?? "";
    // final savedRId = await Cachehelper.getSaveddata("rId");
        final storePid1 = await Cachehelper.getSaveddata("pPid") ?? "";
    final storeRid1 = await Cachehelper.getSaveddata("rPid");
    final storePjimble1 = await Cachehelper.getSaveddata("pJimbleId");
    final storeRjimble1 = await Cachehelper.getSaveddata("rJimbleId");
    // var scanData = Scanreportsmodel().obs;

    var apiUrl = ApiendPoints.maniurl + ApiendPoints.dischargefileshowapi;
    print("Base link pass : ${apiUrl}");
    try {
      var requesData = {"p_id":storePid1 , "r_id": storeRid1 ?? ""};
      print("reques pass : ${requesData}");
      var responseData =
          await http.post(Uri.parse(apiUrl), body: jsonEncode(requesData));
      if (responseData.statusCode == 200) {
        final mm = jsonDecode(responseData.body);
        final scanreport = Scanreportsmodel.fromJson(mm);
        if (scanreport.status == true) {
          scanData.value = scanreport.data ?? [];
          print("scanReports pass : ${scanData}");

          // Correct way to extract fileUrls
          imaeList.value = scanreport.data ??
              []
                  .map((e) => e.fileUrl)
                  .where((url) => url != null && url.isNotEmpty)
                  .toList();

          print("Images list : ${imaeList}");
        } else {
          print("status False");
        }
      }
    } on http.ClientException catch (e) {
      print("Network error: $e");
      Get.snackbar(
        "Network Error",
        "Please check your internet connection.",
        backgroundColor: Color(0xff0D98BA),
      );
    } catch (E) {
      print(E);
    }
  }

  Future<void> deletescan(String reportId) async {
    //   final getsavedspID = await Cachehelper.getSaveddata("p_id") ?? "";
    // final savedRId = await Cachehelper.getSaveddata("rId");
        final storePid1 = await Cachehelper.getSaveddata("pPid") ?? "";
    final storeRid1 = await Cachehelper.getSaveddata("rPid");
    final storePjimble1 = await Cachehelper.getSaveddata("pJimbleId");
    final storeRjimble1 = await Cachehelper.getSaveddata("rJimbleId");
    print("id passing : ${reportId}");
    var apiUrl = ApiendPoints.maniurl + ApiendPoints.scandeleteapi;
    try {
      var requesData = {"p_id": storePid1, "r_id": storeRid1 ?? "", "folder_name": reportId};
      print("reques pass : ${requesData}");
      var responseData =
          await http.post(Uri.parse(apiUrl), body: jsonEncode(requesData));
      if (responseData.statusCode == 200) {
        final scandelete =
            Scanfiledeletemodel.fromJson(jsonDecode(responseData.body));
        if (scandelete.status == true) {
          Get.dialog
          (
            AlertDialog(
            backgroundColor: Dialogbox,
            content: Container(
              // width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/AnimationDelete.gif",
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Your Jimble folder is deleted.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'InterBold',
                      color: Dialogtext,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Thank You".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'InterBold',
                      color: Dialogtext,
                    ),
                  ),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ));
          Future.delayed(const Duration(milliseconds: 2500), () async {
            Get.back();
            Get.off(MedicalRecords());
          });
        } else {
          Get.snackbar(
            messageText: Text(
              scandelete.message.toString(),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            "Alert",
            "",
            colorText: Colors.black,
            backgroundColor: Top,
          );
          print("enter6");
          print(scandelete.message.toString());
        }
      }
    } on http.ClientException catch (e) {
      print("Network error: $e");
      Get.snackbar(
        "Network Error",
        "Please check your internet connection.",
        backgroundColor: Color(0xff0D98BA),
      );
    } catch (E) {
      print(E);
    }
  }
}
