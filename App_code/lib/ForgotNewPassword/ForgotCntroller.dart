import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:savemom/ForgotNewPassword/ForgotModel.dart';

import 'package:savemom/Network_Api/Apiend_points.dart';


import '../../ForgotNewPassword/ForgotNewPassword.dart';

class ForgotPinController extends GetxController {
  Future<void> forgotPinApi(String action, String userId, VoidCallback onOtpDialog) async {
    print("Forgot Pin API calling");
    print("Action: $action");
    print("UserID: $userId");

    try {
       final apiUrl = ApiendPoints.maniurl + ApiendPoints.forgotpinapi;
      var requestData = {
        "action": action,
        "mobile": userId,
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        print("Response: ${response.body}");
        final responseDecode = jsonDecode(response.body);
        final modelTest = Forgotmodel.fromJson(responseDecode);

        if (modelTest.status == true) {
          onOtpDialog();
        } else {
          Get.snackbar("Error", modelTest.message ?? "Something went wrong");
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
        Get.snackbar("Error", "Server error: ${response.statusCode}");
      }

    } on SocketException {
      print("No Internet connection or failed host lookup");
      Get.snackbar("Network Error", "Please check your internet connection.");
    } on FormatException catch (e) {
      print("Bad response format: $e");
      Get.snackbar("Error", "Bad server response. Try again later.");
    } catch (e) {
      print("Unexpected error: $e");
      Get.snackbar("Error", "Something went wrong. Please try again.");
    }
  }

  ///otpVerify
  Future<void> forgotPinApi1(String action, String userId, String otp) async {
    print("Forgot Pin API calling");
    print("Action: $action");
    print("UserID: $userId");
    print("OTP: $otp");

    try {
      final apiUrl = ApiendPoints.maniurl + ApiendPoints.forgotpinapi;
      var requestData = {
        "action": action,
        "mobile": userId,
        "otp":otp
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        print("Response: ${response.body}");
        final responseDecode = jsonDecode(response.body);
        final modelTest = Forgotmodel.fromJson(responseDecode);

        if (modelTest.status == true) {
          Get.to(() => Forgotnewpassword(userId,otp),transition: Transition.fade);
        } else {
          Get.snackbar("Error", modelTest.message ?? "Something went wrong");
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
        Get.snackbar("Error", "Server error: ${response.statusCode}");
      }

    } on SocketException {
      print("No Internet connection or failed host lookup");
      Get.snackbar("Network Error", "Please check your internet connection.");
    } on FormatException catch (e) {
      print("Bad response format: $e");
      Get.snackbar("Error", "Bad server response. Try again later.");
    } catch (e) {
      print("Unexpected error: $e");
      Get.snackbar("Error", "Something went wrong. Please try again.");
    }
  }

  ///otp Success
  Future<bool> forgotPinApi2(String action, String userId, String otp, String newPin, String confirmPin) async {
    print("Forgot Pin API calling");
    print("Action: $action");
    print("UserID: $userId");
    print("OTP: $otp");
    print("New Pin: $newPin");
    print("New Confirm Pin: $confirmPin");

    try {
       final apiUrl = ApiendPoints.maniurl + ApiendPoints.forgotpinapi;
      var requestData = {
        "action": action,
        "mobile": userId,
        "otp":otp,
        "new_password" :newPin,
        "confirm_password" :confirmPin
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        print("Response: ${response.body}");
        final responseDecode = jsonDecode(response.body);
        final modelTest = Forgotmodel.fromJson(responseDecode);

        if (modelTest.status == true) {
         print("Verified OTP Success");
         return true;
        } else {
          Get.snackbar("Error", modelTest.message ?? "Something went wrong");
          return false;
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
        Get.snackbar("Error", "Server error: ${response.statusCode}");
        return false;
      }

    } on SocketException {
      print("No Internet connection or failed host lookup");
      Get.snackbar("Network Error", "Please check your internet connection.");
      return false;
    } on FormatException catch (e) {
      print("Bad response format: $e");
      Get.snackbar("Error", "Bad server response. Try again later.");
      return false;
    } catch (e) {
      print("Unexpected error: $e");
      Get.snackbar("Error", "Something went wrong. Please try again.");
      return false;
    }
  }

  ///OTP Resend
  Future<void> resendOtp(String action, String userId,) async {
    print("Forgot Pin API calling");
    print("Action: $action");
    print("UserID: $userId");

    try {
      final apiUrl = ApiendPoints.maniurl + ApiendPoints.forgotpinapi;
      var requestData = {
        "action": action,
        "mobile": userId,
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        print("Response: ${response.body}");
        final responseDecode = jsonDecode(response.body);
        final modelTest = Forgotmodel.fromJson(responseDecode);

        if (modelTest.status == true) {
        } else {
          Get.snackbar("Error", modelTest.message ?? "Something went wrong");
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
        Get.snackbar("Error", "Server error: ${response.statusCode}");
      }

    } on SocketException {
      print("No Internet connection or failed host lookup");
      Get.snackbar("Network Error", "Please check your internet connection.");
    } on FormatException catch (e) {
      print("Bad response format: $e");
      Get.snackbar("Error", "Bad server response. Try again later.");
    } catch (e) {
      print("Unexpected error: $e");
      Get.snackbar("Error", "Something went wrong. Please try again.");
    }
  }
}
