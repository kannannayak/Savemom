import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';




import 'package:http/http.dart' as http;
import 'package:savemom/Cache/Cache_helper.dart';
import 'package:savemom/Members/RelationshipsModel.dart';
import 'package:savemom/Network_Api/Apiend_points.dart';

import '../../Members/Members.dart';

class Relationshipscontroller extends GetxController {
  var membersmodeldata = RxList<Datum1>([]);
  var selectedIndex = RxnInt();
  RxString family = ''.obs;
  String vv = "";
  RxList bb = [].obs;

  Future<void> relationshipsapi() async {
    print("rid pass not passing : s${selectedIndex}");
    final getsavedspID = await Cachehelper.getSaveddata("p_id");
    print("RelationshipsNumble");
    var apiUrl = ApiendPoints.maniurl + ApiendPoints.relationshipsapi;
    var apiKey = ApiendPoints.apiToken;
    print(apiUrl);
    try {
      var requestData = {"api_key": "jimble@123", "p_id": getsavedspID};
      var responseData =
          await http.post(Uri.parse(apiUrl), body: jsonEncode(requestData));
      if (responseData.statusCode == 200) {
        final decodeData = jsonDecode(responseData.body);
        print("user kkk : ${decodeData}");
        var relaon1 = await Usersmodel.fromJson(decodeData);
        print(relaon1);
        print(responseData);

        if (relaon1.status == true) {
          membersmodeldata.value = relaon1.data ?? [];
          //  vv = relaon1.data?.familyMembers ?? "";
          //   List<String> kk = vv.split(",");
          ///bb.value = kk;
          print("relationdata$membersmodeldata");
        } else {
          print(relaon1.message);
          // print(languageModelres.message);
        }
      }
    } catch (E) {
      print(E);
    }
  }
}
