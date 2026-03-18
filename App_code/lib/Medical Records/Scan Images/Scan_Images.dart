// ignore_for_file: unused_local_variable, use_super_parameters, unused_import, file_names, non_constant_identifier_names, unused_element, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:file_picker/file_picker.dart';
import 'package:savemom/Color.dart';
import 'package:savemom/Medical%20Records/Medical%20Records.dart';
import 'package:savemom/Medical%20Records/MedicalController.dart';

import '../../language.dart';
import 'Camera/camera.dart';
import 'Gallery/gallery.dart';
import 'Pdf/Pdf.dart';

import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';

class ScanImages extends StatefulWidget {
  const ScanImages({Key? key}) : super(key: key);

  @override
  State<ScanImages> createState() => _ScanImagesState();
}

class _ScanImagesState extends State<ScanImages> {
  Future<void> scanDocument() async {
    print("==========================>1");
    try {
      final result = await FlutterDocScanner().getScanDocuments(page: 100);
      if (result != null && result['pdfUri'] != null) {
        final pdfUri = result['pdfUri'].toString().replaceFirst('file://', '');
        print("PDF path: $pdfUri");
        showPleaseWaitDialog(context);

        final pic = Get.put(Medicalcontroller());
        final bool value = await pic.Medicalrecordsapi(
          pic.scandate.value,
          pdfUri,
          [],
          [],
          "",
          [],
          [],
          "",
          [],
          [],
          "",
          [],
          [],
          "",
          [],
          [],
        );

        if (value == true) {
          Navigator.of(context, rootNavigator: true).pop();
          Get.offAll(() => MedicalRecords());
          print("1");
        } else {
          Navigator.of(context, rootNavigator: true).pop();
          print("2");
        }
      }
    } on PlatformException {
      print("errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr+>>>>");
      print("Failed to get scanned documents.");
    }
  }

  void showPleaseWaitDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Please wait"),
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Expanded(child: Text("Processing...")),
            ],
          ),
        );
      },
    );
  }

  File? _selectedImage;
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // This function picks a PDF file
  Future<void> _pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final file = result.files.single;
      print("Picked PDF file: ${file.name}");
      // You can now upload, preview, or use this file
    } else {
      print("User canceled the picker.");
    }
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
          "Scan Images",
          style: TextStyle(
            // textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: Appbar[Get.locale?.languageCode] ?? screenWidth * 0.07,
            fontFamily: "JaldiBold",
            color: Patent_secondory,
          ),
          // style:TextStyle(color: Patent_secondory,fontFamily: )
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        leading: IconButton(
          // icon: Image.asset("assets/images/Arrows.png", scale: screenWidth * 0.08,
          //       height: screenWidth * 0.08,
          //       fit: BoxFit.contain),
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Patent_secondory,
          ),
        ),
      ),
      body: Center(
        child: Center(
          child: Container(
            height: screenHeight * 0.4,
            width: screenWidth * 0.8,
            decoration: BoxDecoration(
              color: Dialogbox,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    scanDocument();
                  },
                  child: Container(
                    height: 70,
                    width: screenWidth * 0.60,
                    decoration: BoxDecoration(
                      color: sidemenutext,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("assets/images/Camera.png"),
                          Text(
                            "Open Camera".tr,
                            style: GoogleFonts.jaldi(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Patent_Black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(ScanPdf());
                  },
                  // _pickPdfFile,
                  child: Container(
                    height: 70,
                    width: screenWidth * 0.60,
                    decoration: BoxDecoration(
                      color: sidemenutext,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("assets/images/Upload_62x56.png"),
                          Text(
                            "Upload PDF".tr,
                            style: GoogleFonts.jaldi(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Patent_Black,
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
      ),
    );
  }
}
