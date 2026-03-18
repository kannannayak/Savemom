import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:savemom/Cache/Cache_helper.dart';
import 'package:savemom/Color.dart';
import 'package:savemom/Login/login.dart';
import 'package:savemom/Network_Api/Apiend_points.dart';
import 'package:savemom/SideMenuBar/SideMenuModel/DeleteModel.dart';

class Deletecontroller extends GetxController {
  Future<void> deleteapi(String reason) async {
    final getsavedID = await Cachehelper.getSaveddata("p_id");
    print("getif$getsavedID");
    print("enter1");
    final apiurl = ApiendPoints.maniurl + ApiendPoints.deleteapi;
    try {
      print("enter2");
      print("dfkjvk$reason");
      final reqData = {"api_key": "jimble@123", "p_id": 200, "reason": reason};
      var responseData =
          await http.post(Uri.parse(apiurl), body: jsonEncode(reqData));
      print("enter3");
      if (responseData.statusCode == 200) {
        print("enter4");
        final responsedecode = json.decode(responseData.body);

        var modeldeleteData = await DeleteModel.fromJson(responsedecode);
        if (modeldeleteData.status == true) {
          Get.dialog(
            AlertDialog(
              backgroundColor: Dialogbox,
              content: Container(
                // width: MediaQuery.of(context).size.width * 0.9,
                width: Get.width * 0.9,
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
                      "Your Jimble account is deleted.",
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
            ),
            barrierDismissible: false,
          );

          Future.delayed(const Duration(milliseconds: 2500), () async {
            await Cachehelper.deletedata("p_id");
            Get.back(); // close dialog
            Get.offAll(() => Login(),transition: Transition.fade); // navigate to welcome page
          });
          print("enter5");

          print("getsavedData$getsavedID");
          print(modeldeleteData.message);
        } else {
          Get.snackbar(
            messageText: Text(
              modeldeleteData.message.toString(),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            "Alert",
            "",
            colorText: Colors.black,
            backgroundColor: Color(0xff0D98BA),
          );
          print("enter6");
          print(modeldeleteData.message);
        }
      }
    } on http.ClientException catch (e) {
      print("Network error: $e");
      Get.snackbar(
        "Network Error",
        "Please check your internet connection.",
        backgroundColor: Color(0xff0D98BA),
      );
    } catch (e) {
      print(e);
    }
  }
}
