import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:savemom/Cache/Cache_helper.dart';
import 'package:savemom/Network_Api/Apiend_points.dart';
import 'package:savemom/Profile/ProflieModel/Profilemodel.dart';

class Profilecontroller extends GetxController {
  var profiledata = Rx<Data?>(null);

  var isLoading = false.obs;
  var ProfileModel = Profilemodel().obs;
  Future<void> profileapi() async {
    final getsavedspID = await Cachehelper.getSaveddata("p_id");
    print("getsave$getsavedspID");
    try {
      isLoading.value = true;
      const apiUrl = ApiendPoints.maniurl + ApiendPoints.profileapi;

      var reqData = {"api_key": "Jimble@123", "p_id": getsavedspID};
      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(reqData),
      );
      print(response);
      if (response.statusCode == 200) {
        final Map<String, dynamic> mm = jsonDecode(response.body);
        print("Response Data: $mm");
        var tt = Profilemodel.fromJson(mm);
        if (tt.status == true) {
          profiledata.value = tt.data!;

          print("dofnvdofn${profiledata}");
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      if (e is ClientException) {
        print("ClientException: Failed to fetch - ${e.message}");
      } else if (e is TimeoutException) {
        print("Request timed out");
      } else {
        print("Error: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

}
