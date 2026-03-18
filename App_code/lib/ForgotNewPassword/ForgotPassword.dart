// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pinput/pinput.dart';
import 'package:savemom/ForgotNewPassword/ForgotCntroller.dart';

import '../Color.dart';
import 'ForgotNewPassword.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final forgotcontroller = Get.put(ForgotPinController());

  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  void _showOtpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Enter OTP".tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: 'Jaldi', fontSize: 25),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Pinput(
                controller: _otpController,
                length: 4,
                keyboardType: TextInputType.number,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  decoration: BoxDecoration(
                    color: Patent_PinInput,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Patent_Black),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                   forgotcontroller.resendOtp(
                      "request_otp",_userIdController.text);

                }, // Resend OTP logic
                child: Text(
                  "Resend?".tr,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Patent_Black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: InkWell(
                onTap: () 
                {
                  // Get.to(() => Forgotnewpassword());
                    if (_otpController.text.isEmpty ||
                      _otpController.text.length < 4) {
                    Get.snackbar(
                      messageText: Text(
                        "please enter OTP",
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
                  } else {
                    forgotcontroller.forgotPinApi1(
                        "verify_otp",_userIdController.text, _otpController.text);
                  }
                },
                child: Container(
                  width: 166.14,
                  height: 48.73,
                  decoration: BoxDecoration(
                    boxShadow: [
                      const BoxShadow(offset: Offset(0, 4), blurRadius: 3)
                    ],
                    color: Top,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Patent_Black, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      "Verify".tr,
                      style: TextStyle(color: Patent_secondory, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Patent_Black),
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }

  late double screenWidth;
  late double screenHeight;
  late double height;
  late double width;

  void setScreenSize(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    width = screenWidth;
    height = screenHeight;
  }

  final Widget shbox10 = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    setScreenSize(context);
    return Scaffold(
        backgroundColor: Patent_secondory,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.4,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    height: screenHeight / 2.9,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Top,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(screenWidth * 0.9),
                        bottomLeft: Radius.circular(screenWidth * 0.4),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: height * 0.05,
                  //   left: 20,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Navigator.pop(context);
                  //     },

                  //   ),
                  // ),
                  Positioned(
                    top: height * 0.020,
                    right: width * 0.28,
                    child: Image.asset(
                      "assets/images/Savemom.png",
                      width: screenWidth * 0.6,
                      height: screenHeight / 5,
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.22,
                    left: 35,
                    child: Text(
                      "Forgot".tr,
                      style: TextStyle(
                        fontFamily: "Jaldi",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.26,
                    left: 35,
                    child: Text(
                      "Pin".tr,
                      style: TextStyle(
                        fontFamily: "Jaldi",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.090),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Top,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Patent_Black),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "User ID".tr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: _userIdController,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        hintText: "Enter Mobile Number".tr,
                        hintStyle: TextStyle(color: Patent_HintColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Patent_Black),
                        ),
                        filled: true,
                        fillColor: Patent_secondory,
                      ),
                    ),
                    shbox10,
                    Text(
                      "Otp will be sent to your registered mobile number".tr,
                      style: const TextStyle(
                          fontFamily: 'JaldiBold', fontSize: 15),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {

                        if  (_userIdController.text.length != 10) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Invalid User ID",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'JaldiBold', fontSize: 25)),
                              content: const Text(
                                "Please enter a 10-digit mobile number.",
                                style: TextStyle(
                                    fontFamily: 'JaldiBold', fontSize: 16),
                              ),
                              actions: [
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      width: 58,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(0, 4),
                                              blurRadius: 3)
                                        ],
                                        color: Top,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Patent_Black, width: 1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "OK".tr,
                                          style: TextStyle(
                                              color: Patent_secondory,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // _showOtpDialog();
                           showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => const Center(child: CircularProgressIndicator()),
                                );
                          forgotcontroller.forgotPinApi(
                                  "request_otp",
                                  _userIdController.text,
                                      () {
                                    _showOtpDialog();
                                  },
                                );
                         
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xffFFFFFF),
                          border: Border.all(color: Top, width: 1),
                          boxShadow: const [
                            BoxShadow(offset: Offset(0, 5), blurRadius: 3),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Send OTP".tr,
                            style: TextStyle(
                                fontFamily: 'JaldiBold',
                                fontSize: 25,
                                color: Top),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
