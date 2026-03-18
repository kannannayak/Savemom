// ignore_for_file: unused_import, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:savemom/ForgotNewPassword/ForgotCntroller.dart';
import 'package:savemom/Login/login.dart';

import '../Color.dart';

class Forgotnewpassword extends StatefulWidget {
  final String userId;
  final String otp;
  const Forgotnewpassword(this.userId, this.otp, {super.key});
  @override
  State<Forgotnewpassword> createState() => _ForgotnewpasswordState();
}

class _ForgotnewpasswordState extends State<Forgotnewpassword> {
  final forgotcontroller = Get.put(ForgotPinController());
  bool _obscurePassword = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

//
  void _validateAndSubmit() async {
    if (_passwordController.text.length != 4 ||
        _confirmPasswordController.text.length != 4) {
      _showAlertDialog("Error", "Password must be exactly 4 digits.", false);
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      _showAlertDialog("Error", "Pin do not match.", false);
      return;
    }
    bool result = await forgotcontroller.forgotPinApi2(
      "reset_password",
      widget.userId,
      widget.otp,
      _passwordController.text,
      _confirmPasswordController.text,
    );
    if (result) {
      _showAlertDialog("Success", "Pin changed successfully.".tr, true);
    } else {
      _showAlertDialog(
          "Error", "Failed to change pin. Please try again.".tr, false);
    }
  }

  void _showAlertDialog(String title, String content, bool isSuccess) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Patent_Black),
        ),
        backgroundColor: Colors.white,
        title: isSuccess
            ? Image.asset(
                "assets/images/check.png",
                height: 40,
              )
            : Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'JaldiBold', fontSize: 25),
              ),
        content: Text(
          content,
          style: TextStyle(fontFamily: 'JaldiBold', fontSize: 25),
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: InkWell(
              onTap: () {
                Navigator.pop(context); // Close the dialog first
                if (isSuccess) {
                  Get.to(() => Login(),
                      transition: Transition.fade); // Navigate only if success
                }
              },
              child: Container(
                width: 58,
                height: 32,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(offset: Offset(0, 4), blurRadius: 3)],
                  color: Top,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Patent_Black, width: 1),
                ),
                child: Center(
                  child: Text(
                    "OK".tr,
                    style: TextStyle(color: Patent_secondory, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//
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
              Positioned(
                top: height * 0.020,
                // right: width * 0.28,
                left: 50,
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
                  "New".tr,
                  style: TextStyle(
                    fontFamily: "Jaldi",
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
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
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Top,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Patent_Black)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Enter 4 digit pin".tr, //Enter New SetPin
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _passwordController,
                  // keyboardType: TextInputType.,
                  maxLength: 4,
                  decoration: InputDecoration(
                    hintText: "****",
                    hintStyle: TextStyle(color: Patent_HintColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Patent_Black)),
                    filled: true,
                    fillColor: Patent_secondory,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      "Confirm pin".tr, //Confirm New Pin
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _confirmPasswordController,
                  // keyboardType: TextInputType.number,
                  maxLength: 4,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: "****", //Enter 4 digit Pin
                    hintStyle: TextStyle(color: Patent_HintColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Patent_Black)),
                    filled: true,
                    fillColor: Patent_secondory,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    _validateAndSubmit();
                  },
                  child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Patent_secondory,
                        border: Border.all(color: Patent_Black, width: 1),
                        boxShadow: [
                          BoxShadow(offset: Offset(0, 5), blurRadius: 3),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Text(
                        "Submit".tr,
                        style: TextStyle(
                            fontFamily: 'JaldiBold', fontSize: 25, color: Top),
                      ))),
                ),
              ],
            ),
          ),
        ),
      ],
    )));
  }
}
