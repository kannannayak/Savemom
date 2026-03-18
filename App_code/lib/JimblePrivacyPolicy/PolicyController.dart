import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:savemom/JimblePrivacyPolicy/PolicyModel.dart';


class Policycontroller extends GetxController {
  var policyandterms = Rx<Policymodel?>(null);
  Future<void> policyadnterms() async {
    print("enter1");
    final apiurl =
        "https://jimble.traitsolutions.in/Restapi/adminapi/fetch_privacy_policy.php";
    try {
      print("enter2");

      var responseData = await http.post(
        Uri.parse(apiurl),
      );
      print("enter3");
      if (responseData.statusCode == 200) {
        print("enter4");
        print(responseData.body);
        final responsedecode = json.decode(responseData.body);

        var modelpolicyData = await Policymodel.fromJson(responsedecode);
        if (modelpolicyData.status == true) {
          policyandterms.value = modelpolicyData;
          //   print(policyandterms.value!.data!.privacyPolicy);
          print("enter5");

          print(modelpolicyData.data);
        } else {
          Get.snackbar(
            messageText: Text(
              modelpolicyData.message.toString(),
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
          print(modelpolicyData.message);
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
