// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Color.dart';
import '../Login/login.dart';
import '../Register/Controller/Contorller.dart';

class Accountcreated extends StatefulWidget {
  const Accountcreated({super.key, required this.JIDI});

  final String JIDI;

  @override
  State<Accountcreated> createState() => _AccountcreatedState();
}

class _AccountcreatedState extends State<Accountcreated> {
  final Disposereg_page = Get.put(RegisterContorller());
  @override
  Widget build(BuildContext context) {
    setScreenSize(context);
    return Scaffold(
      backgroundColor: Patent_secondory,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Top Section with Logo and Back Button
                Stack(
                  children: [
                    Container(
                      // width: width,
                      // height: height * 0.32,
                      height: height / 2.9,
                      width: width,
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
                    //     child: Icon(
                    //       Icons.arrow_back,
                    //       color: Colors.white,
                    //       size: height * 0.050,
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      top: height * 0.020,
                      right: width * 0.28,
                      child: Image.asset(
                        "assets/images/Savemom.png",
                        // width: width * 0.9,
                        // height: height * 0.3,
                        width: screenWidth * 0.6,
                        height: screenHeight / 5,
                      ),
                    ),
                    Positioned(
                      // top: 200,
                      // left: 35,
                      top: screenHeight * 0.25,
                      left: 35,
                      child: Text(
                        "Congratulations!".tr,
                        style: TextStyle(
                          fontFamily: "Jaldi",
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,

                          // fontFamily: "Jaldi",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.040),
                Center(
                  child: Image.asset(
                    "assets/images/Account Created.png",
                    width: width * 0.9,
                    height: height * 0.2,
                  ),
                ),
                SizedBox(height: height * 0.040),
                Text(
                  // "JITN1234",
                  widget.JIDI,

                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'LimelightRegular',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.020),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        // Ensures text wraps properly inside the row
                        child: Text(
                          "Your Jimble account has been created successfully. User ID and pin have been sent to the registered email ID."
                              .tr, // Your calendar will be activated within 48 hours.
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'FenixRegular',
                          ), // Adjust font size as needed
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.040),
                Center(
                  child: InkWell(
                    onTap: () {
                      Disposereg_page.clearFormFields();
                      Get.to(Login(), transition: Transition.fade);
                    },
                    child: Container(
                      width: 89,
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(offset: Offset(0, 4), blurRadius: 3),
                        ],
                        color: Top,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Patent_Black, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          "OK".tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'JaldiBold',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                shbox20,
              ],
            ),
          );
        },
      ),
    );
  }
}
