// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:savemom/Color.dart';

import 'package:savemom/Login/Controller/LoginController.dart';

import '../ForgotNewPassword/ForgotPassword.dart';
import '../Members/Members.dart';
import '../Register/Register.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscurePassword = true;

  // String selectedLanguage = 'en_US';
  final Logincontroller logincontroller = Get.put(Logincontroller());
  @override
  void initState() {
    super.initState();
    // logincontroller.languageApi();
  }

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
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Top,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(screenWidth * 0.4),
                        bottomRight: Radius.circular(screenWidth * 0.9),
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.25,
                    left: 35,
                    child: Text(
                      "Login".tr,
                      style: TextStyle(
                        fontFamily: "Jaldi",
                        fontSize: 30,
                        // Get.locale?.languageCode == 'ta' ? width40 : width*0.40,
                        // fontSize:width*0.40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 50,
                    child: Container(
                      child: Image.asset(
                        "assets/images/Savemom.png",
                        width: screenWidth * 0.6,
                        height: screenHeight / 5,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 180,
                    right: 50,
                    child: Container(
                      child: Image.asset(
                        "assets/images/Doctor.png",
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(right: 25),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       shbox10,
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           Container(
            //             height: 50,
            //             width: 170,
            //             padding: EdgeInsets.symmetric(horizontal: 10),
            //             decoration: BoxDecoration(
            //               color: Color(0xffD9D9D9),
            //               borderRadius: BorderRadius.all(Radius.circular(30)),
            //             ),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //               children: [
            //                 Image.asset(
            //                   "assets/images/translate.png",
            //                   width: 55,
            //                   height: 100,
            //                 ),
            //                 Expanded(
            //                   child: DropdownButtonHideUnderline(
            //                     child: DropdownButton<String>(
            //                       value: logincontroller.selectedLanguage.value,
            //                       isExpanded: true,
            //                       dropdownColor: Color(0xffD9D9D9),
            //                       icon: Icon(
            //                         Icons.keyboard_arrow_down_rounded,
            //                         color: Colors.black,
            //                       ),
            //                       style: TextStyle(
            //                         color: Color(0xff02AEB5),
            //                         fontSize: 16,
            //                       ),
            //                       items: [
            //                         DropdownMenuItem(
            //                           value: "en_US",
            //                           child: Text('English'),
            //                         ),
            //                         DropdownMenuItem(
            //                           value: "ta_IN",
            //                           child: Text('தமிழ்'),
            //                         ),
            //                         DropdownMenuItem(
            //                           value: "ml_IN",
            //                           child: Text('മലയാളം'),
            //                         ),
            //                         DropdownMenuItem(
            //                           value: "te_IN",
            //                           child: Text('తెలుగు'),
            //                         ),
            //                         DropdownMenuItem(
            //                           value: "kn_IN",
            //                           child: Text('ಕನ್ನಡ'),
            //                         ),
            //                         DropdownMenuItem(
            //                           value: "hi_IN",
            //                           child: Text('हिंदी'),
            //                         ),
            //                         DropdownMenuItem(
            //                           value: "bn_IN",
            //                           child: Text('বাংলা'),
            //                         ),
            //                       ],
            //                       onChanged: (String? newValue) {
            //                         if (newValue != null) {
            //                           setState(() {
            //                             logincontroller.selectedLanguage.value =
            //                                 newValue;
            //                           });
            //                           List<String> localeParts = newValue.split(
            //                             '_',
            //                           );
            //                           if (localeParts.length == 2) {
            //                             Get.updateLocale(
            //                               Locale(
            //                                 localeParts[0],
            //                                 localeParts[1],
            //                               ),
            //                             );
            //                           } else {
            //                             Get.updateLocale(
            //                               Locale(localeParts[0]),
            //                             );
            //                           }
            //                         }
            //                       },
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            shbox10,
            // Login Form Container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Color(0xff02AEB5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User ID".tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    shbox5,
                    TextField(
                      controller: logincontroller.userid.value,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Ensures only numbers can be entered
                      ],
                      decoration: InputDecoration(
                        hintText: "Enter Mobile Number".tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    shbox15,
                    Text(
                      "Enter 4 digit pin".tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: logincontroller.passw.value,
                      obscureText: _obscurePassword,
                      maxLength: 4,
                      decoration: InputDecoration(
                        hintText: "****".tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    shbox8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(
                              ForgotPassword(),
                              transition: Transition.fade,
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero, // Remove default padding
                          ),
                          child: Text(
                            "Forgot Pin".tr, // Password
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    shbox10,
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          elevation: 10,
                          shadowColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 18,
                          ),
                        ),
                        onPressed: () async {
                          await logincontroller.languageApi(
                            logincontroller.userid.value.text,
                            logincontroller.passw.value.text,
                          );
                        },
                        child: Text(
                          "Login".tr,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff02AEB5),
                          ),
                        ),
                      ),
                    ),
                    shbox15,
                    Center(
                      child: SizedBox(
                        // Constrain width
                        width: 250, // Adjust as needed
                        child: RichText(
                          textAlign: TextAlign.center, // Center-align text
                          text: TextSpan(
                            children: [
                              TextSpan(text: "Don't have an account? ".tr),
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () => Get.to(
                                    Register(),
                                    transition: Transition.fade,
                                  ),
                                  child: Text(
                                    "Register".tr,
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.05),
            shbox20,
          ],
        ),
      ),
    );
  }
}
