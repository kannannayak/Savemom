// ignore_for_file: unused_local_variable, use_super_parameters, unused_import, file_names, non_constant_identifier_names, unused_element, depend_on_referenced_packages, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:savemom/Color.dart';
import 'package:savemom/Medical%20Records/Medical%20Records.dart';
import 'package:savemom/Medical%20Records/MedicalController.dart';
import 'package:savemom/Medical%20Records/Scan%20Images/Controller/Scanshowcontroller.dart';


import '../../language.dart';
import '../View_Folder.dart';
import 'Scan_Images.dart';

class ScanReports extends StatefulWidget {
  const ScanReports({Key? key}) : super(key: key);

  @override
  State<ScanReports> createState() => _ScanReportsState();
}

class _ScanReportsState extends State<ScanReports> {
  final scanlistdata = Get.put(Scanshowcontroller());

  final scandeletehit = Get.put(Scanshowcontroller());
  final scandatecontroller = Get.put(Medicalcontroller());
  TextEditingController Labfrom = TextEditingController();
  TextEditingController LabTo = TextEditingController();
  TextEditingController ddmmyyyy = TextEditingController();
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: now,
    );

    if (pickedDate != null) {
        String displayFormat = DateFormat('dd-MM-yyyy').format(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        controller.text = displayFormat;
        scandatecontroller.scandate.value = formattedDate;
        print(scandatecontroller.scandate.value.toString());
      });
    }
  }

  void Folder1(String reportId) {
    print("delete id pass : ${reportId}");
    Get.dialog(
      AlertDialog(
        backgroundColor: Dialogbox,
        content: SizedBox(
          width: screenWidth * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min, // Prevents unnecessary height usage
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/DeleteClose.png"),
              shbox10,
              Text(
                "Confirm to delete your".tr,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Dialogtext),
              ),
              shbox10,
              Text(
                "folder ?".tr,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Dialogtext),
              ),
              // shbox5,
              // Text(
              //   "Do you still wish to continue deleting your account?",
              //   overflow: TextOverflow.ellipsis,
              //   maxLines: 3,
              //   style: GoogleFonts.inter(
              //       fontSize: 16, fontWeight: FontWeight.normal, color: Dialogtext),
              // ),
              shbox10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      scandeletehit.deletescan(reportId);
                      print("Yes button tapped!");
                      // Add your desired action here
                    },
                    child: Container(
                      width: screenWidth * 0.2,
                      height: 50, // Ensures a perfect circle
                      decoration: BoxDecoration(
                          color: Patent_Black,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      alignment: Alignment
                          .center, // Centers the text inside the container
                      child: Text(
                        "Yes".tr,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Adjust text color if needed
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      print("Yes button tapped!");
                      // Add your desired action here
                    },
                    child: Container(
                      width: screenWidth * 0.2,
                      height: 50, // Ensures a perfect circle
                      decoration: BoxDecoration(
                          color: DialogDelete1,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      alignment: Alignment
                          .center, // Centers the text inside the container
                      child: Text(
                        "No".tr,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Adjust text color if needed
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    scanlistdata.scanreportapi();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void showLabReportDialog() {
      Get.dialog(AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: Center(
          child: Container(
              width: screenWidth * 1,
              height: screenHeight * 0.38,
              decoration: BoxDecoration(
                color: Top,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  shbox40,
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Please Uplodad document".tr,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Patent_Black,
                          ),
                        ),
                        Text(
                          "as per the report date".tr,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Patent_Black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  shbox10,
                  SizedBox(
                    width: screenWidth * 0.7,
                    child: TextField(
                      controller: ddmmyyyy,
                      readOnly: true,
                      onTap: () => _selectDate(context, ddmmyyyy),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        fillColor: Dialogbox,
                        filled: true,
                        hintText: "Enter dd-mm-yyyy".tr,
                        hintStyle: GoogleFonts.jaldi(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: FeedbackText,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                    ),
                  ),
                  shbox20,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Patent_secondory,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: const BorderSide(color: Colors.black, width: 2),
                      ),
                      elevation: 10,
                      shadowColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      // Date validation check
                      if (ddmmyyyy.text.isEmpty) {
                        Get.snackbar(
                          'Error'.tr,
                          'Please select a date'.tr,
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      } else {
                        Get.back();
                        Get.snackbar(
                          'Success'.tr,
                          'Proceeding to upload'.tr,
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          duration: Duration(seconds: 1),
                        );
                        Get.to(ScanImages(), transition: Transition.fade);
                      }
                    },
                    child: Text(
                      "Submit".tr,
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Top,
                      ),
                    ),
                  ),
                  shbox5,
                  Text(
                    "Take help of your doctor if required".tr,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: Patent_Black,
                        fontSize: 15),
                  ),
                  shbox5,
                ],
              )),
        ),
      ));
    }

    setScreenSize(context);

    return Scaffold(
        backgroundColor: Patent_secondory,
        appBar: AppBar(
          toolbarHeight: screenHeight * 0.1,
          backgroundColor: Top,
          centerTitle: true,
          title: Text(
            "Scan images",
            style: TextStyle(
                // textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize:
                    Appbar[Get.locale?.languageCode] ?? screenWidth * 0.07,
                fontFamily: "JaldiBold",
                color: Patent_secondory),
            // style:TextStyle(color: Patent_secondory,fontFamily: )
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          leading: IconButton(
            // icon: Image.asset("assets/images/Arrows.png", scale: screenWidth * 0.08,
            // height: screenWidth * 0.08,
            // fit: BoxFit.contain),
            onPressed: () {
              Get.to(MedicalRecords());
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Patent_secondory,
            ),
          ),
        ),
        body: Column(
          children: [
            shbox20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth * 0.4,
                  height: 50,
                  child: TextField(
                    controller: Labfrom,
                    readOnly: true,
                    onTap: () => _selectDate(context, Labfrom),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                          padding: EdgeInsets.all(10), // Adjust icon spacing
                          child: Icon(Icons.date_range_rounded)),
                      suffixIcon: Labfrom.text
                              .isNotEmpty // ✅ show Cancel button only if date selected
                          ? IconButton(
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                setState(() {
                                  Labfrom.clear(); // remove selected date
                                });
                              },
                            )
                          : null,
                      fillColor: Dialogbox,
                      filled: true,
                      hintText: "From".tr,
                      hintStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Patent_Black.withOpacity(0.21),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                ),
                swbox10,
                SizedBox(
                  width: screenWidth * 0.4,
                  height: 50,
                  child: TextField(
                    controller: LabTo,
                    readOnly: true,
                    onTap: () => _selectDate(context, LabTo),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.date_range_rounded)),
                      suffixIcon: LabTo.text
                              .isNotEmpty // ✅ show Cancel button only if date selected
                          ? IconButton(
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                setState(() {
                                  LabTo.clear(); // remove selected date
                                });
                              },
                            )
                          : null,
                      fillColor: Dialogbox,
                      filled: true,
                      hintText: "To".tr,
                      hintStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Patent_Black.withOpacity(0.21),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                ),
                swbox10,
                SizedBox(
                  width: screenWidth * 0.1,
                  height: 35,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Patent_Black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    onPressed: () {
                      showLabReportDialog();
                    },
                    child: Image.asset("assets/images/plus.png",
                        width: 30, height: 30),
                  ),
                ),
              ],
            ),
            shbox20,
            Obx(() {
              if (scanlistdata.scanData.isEmpty) {
                return Text("No data found");
              }

              int snoCounter = 1; // Serial number counter
              final seenFileIds = <int>{};
              // Parse selected range
              DateTime? fromDate = Labfrom.text.isNotEmpty
                  ? DateTime.tryParse(Labfrom.text)
                  : null;
              DateTime? toDate =
                  LabTo.text.isNotEmpty ? DateTime.tryParse(LabTo.text) : null;

              List<TableRow> rows = [
                TableRow(children: [
                  headerCell('S.No'),
                  headerCell('Date'),
                  headerCell('Images'),
                ]),
              ];

              for (var report in scanlistdata.scanData) {
                for (var file in report.files ?? []) {
                  if (!seenFileIds.contains(file.id)) {
                    DateTime fileDate = file.pDate is String
                        ? DateTime.parse(file.pDate)
                        : file.pDate;

                    // ✅ Apply date filter
                    bool withinRange = true;
                    if (fromDate != null && fileDate.isBefore(fromDate)) {
                      withinRange = false;
                    }
                    if (toDate != null && fileDate.isAfter(toDate)) {
                      withinRange = false;
                    }

                    if (!withinRange) continue;
                    seenFileIds.add(file.id); // Add before TableRow creation

                    rows.add(
                      TableRow(children: [
                        tableCell((snoCounter++).toString()),
                        tableCell(DateFormat('dd-MM-yyyy').format(
                            file.pDate is String
                                ? DateTime.parse(file.pDate)
                                : file.pDate)),
                        Container(
                          height: 45,
                          color: Paymentsbttom,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    file.fileName ?? '',
                                    style: GoogleFonts.jaldi(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Patent_Black),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                swbox10,
                                InkWell(
                                  // onTap: () {
                                  //   Get.to(
                                  //     ViewFolder(
                                  //       title: "View Lab Reports",
                                  //       fileUrl:
                                  //           (file.fileUrl.toString() ?? ""),
                                  //     ),
                                  //     transition: Transition.fade,
                                  //   );
                                  // },
                                  onTap: () {
                                    if (file.fileUrl != null &&
                                        file.fileUrl!.isNotEmpty) {
                                      Get.to(
                                        () => ViewFolder(
                                          title: "View ScanReports",
                                          fileUrl: file.fileUrl! ??
                                              [], // pass the full list here
                                        ),
                                        transition: Transition.fade,
                                      );
                                    } else {
                                      Get.snackbar("Error", "No files found");
                                    }
                                  },
                                  child: Image.asset("assets/images/Foldr.png"),
                                ),
                                swbox10,
                                InkWell(
                                  onTap: () {
                                    Folder1(report.folderName.toString());
                                  },
                                  child: Icon(Icons.delete, color: Colors.red),
                                )
                              ],
                            ),
                          ),
                        ),
                      ]),
                    );
                  }
                }
              }

              return Table(
                columnWidths: {
                  0: FixedColumnWidth(85.0),
                  1: FixedColumnWidth(115.0),
                  2: FixedColumnWidth(145.0),
                },
                border: TableBorder.all(
                    color: Patent_Black, style: BorderStyle.solid, width: 2),
                children: rows,
              );
            }),
          ],
        ));
  }

  Widget headerCell(String text) => Container(
        height: 45,
        color: Paymentsback,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.jaldi(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Patent_Black,
            ),
          ),
        ),
      );

  Widget tableCell(String text) => Container(
        height: 45,
        color: Paymentsbttom,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.jaldi(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Patent_Black,
            ),
          ),
        ),
      );
}
