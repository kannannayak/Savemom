// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:savemom/Cache/Cache_helper.dart';
import 'package:savemom/Color.dart';
import 'package:savemom/Medical%20Records/Medicalmodel.dart';
import 'package:savemom/Network_Api/Apiend_points.dart';

class Medicalcontroller extends GetxController {
  RxString date = "".obs;
  RxString labdate = "".obs;
  RxString predate = "".obs;
  RxString othdate = "".obs;
  RxString scandate = "".obs;
  RxString medicalrid = "".obs;
  var isLoading = false.obs;

  Future<bool> Medicalrecordsapi(
    String Datepass,
    String scanImage,
    List<File> scanGallery,
    List<File> scanPdf,
    String labImages,
    List<File> labGallery,
    List<File> labPdf,
    String prescriptionImage,
    List<File> prescriptionGallery,
    List<File> prescriptionPdf,
    String dischargeImage,
    List<File> dischargeGallery,
    List<File> dischargePdf,
    String otherImage,
    List<File> otherGallery,
    List<File> otherPdf,
  ) async {
    final storePid1 = await Cachehelper.getSaveddata("pPid") ?? "";
    final storeRid1 = await Cachehelper.getSaveddata("rPid");
    final storePjimble1 = await Cachehelper.getSaveddata("pJimbleId");
    final storeRjimble1 = await Cachehelper.getSaveddata("rJimbleId");
    // final getsavedspID = await Cachehelper.getSaveddata("p_id") ?? "";
    // final savedRId = await Cachehelper.getSaveddata("rId");

    try {
      print("path>>>>>>>>>>>>>=====>>$labPdf");
      print("Date>>>>>>>>>>>>>=====>>$Datepass");
      const apiUrl = ApiendPoints.maniurl + ApiendPoints.MedicalReports;
      print("link pass : ${apiUrl}");
      var reqData = http.MultipartRequest("POST", Uri.parse(apiUrl))
        ..fields["p_id"] = storePid1
        ..fields["r_id"] = storeRid1 ?? ""
        ..fields["p_date"] = Datepass;
      print("r_id pass : ${storeRid1}");
      print("Date Selete : ${Datepass}");
      if (scanImage != "[]" && scanImage.isNotEmpty) {
        print("enterrer");
        reqData.files.add(
          await http.MultipartFile.fromPath('scan_cam_image[]', scanImage),
        );
      }
      // for (var file in scanImage) {
      //   Uint8List bytes = await file.readAsBytes();
      //   reqData.files.add(http.MultipartFile.fromBytes(
      //     "scan_cam_image[]",
      //     bytes,
      //     filename: file.path.split('/').last,
      //   ));
      // }

      for (var file in scanGallery) {
        Uint8List bytes = await file.readAsBytes();
        reqData.files.add(
          http.MultipartFile.fromBytes(
            "scan_gallery_image[]",
            bytes,
            filename: file.path.split('/').last,
          ),
        );
      }

      for (var file in scanPdf) {
        Uint8List bytes = await file.readAsBytes();
        reqData.files.add(
          http.MultipartFile.fromBytes(
            "scan_pdf_upload[]",
            bytes,
            filename: file.path.split('/').last,
          ),
        );
      }
      print("lab imagses======================>$labImages");
      if (labImages != "[]" && labImages.isNotEmpty) {
        print("enterrer");
        reqData.files.add(
          await http.MultipartFile.fromPath('lab_cam_image[]', labImages),
        );
      }
      for (var file in labPdf) {
        Uint8List bytes = await file.readAsBytes();
        reqData.files.add(
          http.MultipartFile.fromBytes(
            "lab_pdf_upload[]",
            bytes,
            filename: file.path.split('/').last,
          ),
        );
      }
      for (var file in labGallery) {
        Uint8List bytes = await file.readAsBytes();
        reqData.files.add(
          http.MultipartFile.fromBytes(
            "lab_gallery_image[]",
            bytes,
            filename: file.path.split('/').last,
          ),
        );
      }
      if (prescriptionImage != "[]" && prescriptionImage.isNotEmpty) {
        print("enterrer");
        reqData.files.add(
          await http.MultipartFile.fromPath(
            "prescription_cam_image[]",
            prescriptionImage,
          ),
        );
      }

      for (var file in prescriptionGallery) {
        Uint8List bytes = await file.readAsBytes();
        reqData.files.add(
          http.MultipartFile.fromBytes(
            "prescription_gallery_image[]",
            bytes,
            filename: file.path.split('/').last,
          ),
        );
      }

      for (var file in prescriptionPdf) {
        Uint8List bytes = await file.readAsBytes();
        reqData.files.add(
          http.MultipartFile.fromBytes(
            "prescription_pdf_upload[]",
            bytes,
            filename: file.path.split('/').last,
          ),
        );
      }
      if (dischargeImage != "[]" && dischargeImage.isNotEmpty) {
        print("enterrer");
        reqData.files.add(
          await http.MultipartFile.fromPath(
            "discharge_cam_image[]",
            dischargeImage,
          ),
        );
      }

      for (var file in dischargeGallery) {
        Uint8List bytes = await file.readAsBytes();
        reqData.files.add(
          http.MultipartFile.fromBytes(
            "discharge_gallery_image[]",
            bytes,
            filename: file.path.split('/').last,
          ),
        );
      }

      for (var file in dischargePdf) {
        Uint8List bytes = await file.readAsBytes();
        reqData.files.add(
          http.MultipartFile.fromBytes(
            "discharge_pdf_upload[]",
            bytes,
            filename: file.path.split('/').last,
          ),
        );
      }
      if (otherImage != "[]" && otherImage.isNotEmpty) {
        print("enterrer");
        reqData.files.add(
          await http.MultipartFile.fromPath("other_cam_image[]", otherImage),
        );
      }

      for (var file in otherGallery) {
        Uint8List bytes = await file.readAsBytes();
        reqData.files.add(
          http.MultipartFile.fromBytes(
            "other_gallery_image[]",
            bytes,
            filename: file.path.split('/').last,
          ),
        );
      }

      for (var file in otherPdf) {
        Uint8List bytes = await file.readAsBytes();
        reqData.files.add(
          http.MultipartFile.fromBytes(
            "other_pdf_upload[]",
            bytes,
            filename: file.path.split('/').last,
          ),
        );
      }

      var response = await reqData.send();

      var responseData = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        print(storePid1);

        print("pass images: ${labImages}");

        var deceoderesponse = json.decode(responseData);
        final Medicaldata = Medicalrecordmodel.fromJson(deceoderesponse);
        print("message pass : ${Medicaldata.message}");
        Get.snackbar(
          messageText: Text(
            Medicaldata.message.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          "Alert",
          "",
        );
        if (Medicaldata.status == true) {
          print("Statu value :  ${Medicaldata.status}");
          print("chet : ${Medicaldata.message}");
          print("reportId : ${Medicaldata.reportId}");
          print("scanCamImage : ${Medicaldata.uploadedFiles}");
          // print(
          //     "scanGalleryImage : ${Medicaldata.uploadedFiles!.scanGalleryImage}");
          // print("scanPdfUpload : ${Medicaldata.uploadedFiles!.scanPdfUpload}");
          // print("labCamImage : ${Medicaldata.uploadedFiles!.labCamImage}");
          // print("labCamImage : ${Medicaldata.uploadedFiles!.labGalleryImage}");
          // print("labCamImage : ${Medicaldata.uploadedFiles!.labPdfUpload}");
          // print(
          //     "prescriptionCamImage : ${Medicaldata.uploadedFiles!.prescriptionCamImage}");
          // print(
          //     "prescriptionGalleryImage : ${Medicaldata.uploadedFiles!.prescriptionGalleryImage}");
          // print(
          //     "prescriptionPdfUpload : ${Medicaldata.uploadedFiles!.prescriptionPdfUpload}");
          // print(
          //     "dischargeCamImage : ${Medicaldata.uploadedFiles!.dischargeCamImage}");
          // print(
          //     "dischargeGalleryImage : ${Medicaldata.uploadedFiles!.dischargeGalleryImage}");
          // print(
          //     "dischargePdfUpload : ${Medicaldata.uploadedFiles!.dischargePdfUpload}");
          // print("otherCamImage : ${Medicaldata.uploadedFiles!.otherCamImage}");
          // print(
          //     "otherGalleryImage : ${Medicaldata.uploadedFiles!.otherGalleryImage}");
          // print(
          //     "otherPdfUpload : ${Medicaldata.uploadedFiles!.otherPdfUpload}");
          return true;
        }
      }
    } on http.ClientException catch (e) {
      Get.snackbar(
        "Network Error",
        "Please check your internet connection.",
        backgroundColor: Top,
      );
      print("error this $e");
      return false;
    } catch (E) {
      print(E);
    }
    return false;
  }
}
