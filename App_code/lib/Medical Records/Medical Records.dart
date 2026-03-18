// ignore_for_file: unused_local_variable, use_super_parameters, unused_import, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savemom/Color.dart';
import 'package:savemom/HomeJimble/HomeJimble.dart';


import '../language.dart';
import 'DischargeSummary/DischargeSummary.dart';
import 'Lab/Lab Reports.dart';
import 'Non-Jimble Prescriptions/Prescriptions.dart';
import 'OtherReports/OtherReports.dart';
import 'Scan Images/ScanReports.dart';

class MedicalRecords extends StatefulWidget {
  const MedicalRecords({
    Key? key,
  }) : super(key: key);

  @override
  State<MedicalRecords> createState() => _MedicalRecordsState();
}

class _MedicalRecordsState extends State<MedicalRecords> {
  @override
  void initState() {
    super.initState();
    // medicalcords.Medicalrecordsapi();
  }

  @override
  Widget build(BuildContext context) {
    setScreenSize(context);

    return Scaffold(
        backgroundColor: Patent_secondory,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        backgroundColor: Top,
        centerTitle: true,
        title: Text(
          "Medical Records",
          style: TextStyle(
              // textStyle: Theme.of(context).textTheme.displayLarge,
              fontSize: Appbar[Get.locale?.languageCode] ?? screenWidth * 0.07,
              fontFamily: "JaldiBold",
              color: Patent_secondory),
          // style:TextStyle(color: Patent_secondory,fontFamily: )
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        leading: IconButton(
          // icon:
          //     Image.asset("assets/images/Arrows.png", scale: screenWidth * 0.08,
          //   height: screenWidth * 0.08,
          //   fit: BoxFit.contain), // Add your image path
          onPressed: () {
            Get.off(HomeJimble(
              familyMemberName: "",
              pId: "",
              pName: "",
              rId: "",
            ));
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Patent_secondory,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            shbox15,
            Center(
              child: InkWell(
                onTap: () {
                  Get.to(LabReports(), transition: Transition.fade);
                },
                child: Container(
                  //height: screenHeight \* 0\.13,
                  width: screenWidth * 0.92,
                  decoration: BoxDecoration(
                    color: Top,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      shbox5,
                      Image.asset("assets/images/LabReports.png"),
                      shbox5,
                      Text(
                        "Lab Reports".tr,
                        style: GoogleFonts.jaldi(
                          fontWeight: FontWeight.bold,
                          color: Patent_secondory,
                          fontSize: Get.locale?.languageCode == 'ta' ? 18 : 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            shbox15,
            Center(
              child: InkWell(
                onTap: () {
                  Get.to(ScanReports(), transition: Transition.fade);
                },
                child: Container(
                  //height: screenHeight \* 0\.13,
                  width: screenWidth * 0.92,
                  decoration: BoxDecoration(
                    color: Top,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      shbox5,
                      Image.asset("assets/images/ScanImages.png"),
                      shbox5,
                      Text(
                        "Scan Images".tr,
                        style: GoogleFonts.jaldi(
                          fontWeight: FontWeight.bold,
                          color: Patent_secondory,
                          fontSize: Get.locale?.languageCode == 'ta' ? 18 : 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            shbox15,
            Center(
              child: InkWell(
                onTap: () {
                  Get.to(PrescriptionsReports(), transition: Transition.fade);
                },
                child: Container(
                  //height: screenHeight \* 0\.13,
                  width: screenWidth * 0.92,
                  decoration: BoxDecoration(
                    color: Top,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      shbox5,
                      Image.asset("assets/images/Non-Jimble Prescriptions.png"),
                      shbox5,
                      Text(
                        "Non-Jimble Prescriptions".tr,
                        style: GoogleFonts.jaldi(
                          fontWeight: FontWeight.bold,
                          color: Patent_secondory,
                          fontSize: Get.locale?.languageCode == 'ta' ? 18 : 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            shbox15,
            Center(
              child: InkWell(
                onTap: () {
                  Get.to(DischargeSummary(), transition: Transition.fade);
                },
                child: Container(
                  //height: screenHeight \* 0\.13,
                  width: screenWidth * 0.92,
                  decoration: BoxDecoration(
                    color: Top,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      shbox5,
                      Image.asset("assets/images/DischargeSummary.png"),
                      shbox5,
                      Text(
                        "Discharge Summary".tr,
                        style: GoogleFonts.jaldi(
                          fontWeight: FontWeight.bold,
                          color: Patent_secondory,
                          fontSize: Get.locale?.languageCode == 'ta' ? 18 : 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            shbox15,
            Center(
              child: InkWell(
                onTap: () {
                  Get.to(OtherReports(), transition: Transition.fade);
                },
                child: Container(
                  //height: screenHeight \* 0\.13,
                  width: screenWidth * 0.92,
                  decoration: BoxDecoration(
                    color: Top,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      shbox5,
                      Image.asset("assets/images/OtherReports.png"),
                      shbox5,
                      Text(
                        "Other Reports".tr,
                        style: GoogleFonts.jaldi(
                          fontWeight: FontWeight.bold,
                          color: Patent_secondory,
                          fontSize: Get.locale?.languageCode == 'ta' ? 18 : 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            shbox15,
          ],
        ),
      ),
    );
  }
}
