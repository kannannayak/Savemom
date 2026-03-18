import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import 'package:savemom/HomeJimble/HomeJimble.dart';
import 'package:savemom/Network_Api/Apiend_points.dart';
import 'package:savemom/Profile/ProflieModel/Deleterelationshipmodel.dart';

class Deleterelationshipcontrollre extends GetxController {
  var deleterale = Deleterelationshipmodel().obs;
  Future<void> Deleteapi(String rid) async {
    try {
      final apiUrl = ApiendPoints.maniurl + ApiendPoints.Deleterelationship;
      print("enter1");
      var reqData = {"r_id": rid};
      print("enter2");
      var respones =
          await http.post(Uri.parse(apiUrl), body: jsonEncode(reqData));
      print("enter3");
      print(respones);
      if (respones.statusCode == 200) {
        print("enter4");
        final rdelete = jsonDecode(respones.body);
        var rdelete2 = Deleterelationshipmodel.fromJson(rdelete);
        if (rdelete2.status == true) {
          deleterale.value = rdelete2;
          Get.offAll(HomeJimble(familyMemberName: "",pId: "",pName:"" ,rId: "",),transition: Transition.fade);
          print(rdelete2.status);
          print(rdelete2.message);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
