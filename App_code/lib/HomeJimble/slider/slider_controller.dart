import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;



import 'package:savemom/HomeJimble/slider/slider_model.dart';
import 'package:savemom/Network_Api/Apiend_points.dart';
import 'package:savemom/Profile/ProfileController/Controller_Profile.dart';

class SliderController extends GetxController {
  final profilecontroller = Get.put(Profilecontroller());
  var bannerModel = BannerViewModel().obs;
  var isLoading = false.obs;

  /// Call this method to fetch the banner data from API
  Future<void> sliderApi() async {
    try {
      print("Slider Api Calling...");
      isLoading.value = true;
      final baseUrl = ApiendPoints.adminUrl + ApiendPoints.banner;
      print("API URL: $baseUrl");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'send_to': '1',
          'location':
              profilecontroller.profiledata.value!.patient!.state.toString(),
        }),
      );

      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        var result = BannerViewModel.fromJson(jsonDecode(response.body));

        if (result.status == true) {
          bannerModel.value = result;
          print("Banner Data: ${bannerModel.value}");
        } else {
          // Get.snackbar("Error", result.message ?? "Failed to load banners");
        }
      } else {
        // Get.snackbar("Error", "Failed to load banner data");
      }
    } catch (e) {
      // Get.snackbar("Exception", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
