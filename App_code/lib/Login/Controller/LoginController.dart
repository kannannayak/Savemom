import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:http/http.dart' as http;
import 'package:savemom/Cache/Cache_helper.dart';
import 'package:savemom/Color.dart';
import 'package:savemom/Login/Model/Login&MultipleLanguage.dart';
import 'package:savemom/Network_Api/Apiend_points.dart';

import '../../Members/Members.dart';

class Logincontroller extends GetxController {
  var languageModel = Loginmodel().obs;
  // final Rx<TextEditingController> language = TextEditingController().obs;
  final RxString selectedLanguage = 'en_US'.obs;

  final Rx<TextEditingController> passw = TextEditingController().obs;
  final Rx<TextEditingController> userid = TextEditingController().obs;



  
  // @override
  // void Login_Dispose() {
  //   // Dispose controllers when the controller is removed from memory
  //   passw.value.dispose();
  //   userid.value.dispose();
  //   super.onClose();
  // }


  Future<void> languageApi(String user, String password) async {
    print("MultipleLanguage");
    var apiUrl = ApiendPoints.maniurl + ApiendPoints.Loginapi;
    var apiKey = ApiendPoints.apiToken;
    try {
      var requestData = {
        "api_key": "jimble@123",
        "mobile_no": user,
        "pass": password,
        "language": selectedLanguage.value,
      };
      print("okokookokokookokookookokokokokokokokok${selectedLanguage.value}");
      var responseData =
          await http.post(Uri.parse(apiUrl), body: jsonEncode(requestData));
      if (responseData.statusCode == 200) {
        final reponse = jsonDecode(responseData.body);
        // print(responseData);
        print(responseData.statusCode);

        var languageModelres = Loginmodel.fromJson(reponse);
        print(languageModelres.message);
        if (languageModelres.status == true) {
          print("model calling");
          await Cachehelper.savedata(
              "p_id", languageModelres.data!.pId.toString());
          final getsavedID = await Cachehelper.getSaveddata("p_id");
          print("getsavedData$getsavedID");
          // print(languageModelres.data);
          Get.snackbar("Login", "successful", backgroundColor: Colors.green);
          Get.to(Members(), transition: Transition.fade);
        } else {
          Get.snackbar(
            messageText: Text(
              languageModelres.message.toString(),
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
          print(languageModelres.message);
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
