import 'dart:convert';

import 'package:barcode_scan2/gen/protos/protos.pbenum.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:savemom/Color.dart';
import 'package:savemom/QR/qr_controller.dart';

class Qrview extends StatefulWidget {
  const Qrview({super.key});

  @override
  State<Qrview> createState() => _GpQrScannerState();
}

class _GpQrScannerState extends State<Qrview> {
  final qrCon = Get.put(QrController());

  var scanResult = 'Scan result will appear here'.obs;
  Future<void> scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      if (result.type == ResultType.Barcode) {
        scanResult.value = result.rawContent;
        print("scanResult : $scanResult");
        // Decode the JSON string
        Map<String, dynamic> scannedData = json.decode(scanResult.value);

        // Access individual values
        String pid = scannedData['Pid'];
        String pjimble = scannedData['Pjimble'];
        String rid = scannedData['Rid'];
        String rjimble = scannedData['Rjimble'];
        print("Pid: $pid");
        print("Pjimble: $pjimble");
        print("Rid : $rid");
        print("RJimble : $rjimble");
   qrCon.pageroute.value == 1;
        qrCon.qrScannerApi(
          pJimbleId: pjimble,
          pID: pid,
          rID: rid,
          rJimble: rjimble,
        );
     
      } else if (result.type == ResultType.Cancelled) {
        scanResult.value = 'Scan cancelled';
      } else {
        scanResult.value = 'Scan failed or no data';
      }
    } catch (e) {
      scanResult.value = 'Error: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        leading: IconButton(
          color: Top,
          onPressed: () {
            Get.back();
            //  Get.offAll(Bottomnavview(), arguments: {"index": 0});
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        toolbarHeight: height * 0.1,
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: Text(
          "Scan QR",
          style: TextStyle(color: Top, fontSize: 30, fontFamily: 'JaldiBold'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Container(
            color: Colors.grey,
            width: width,
            height: height / 1.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/Scan.png",
                  width: width * 0.80,
                  height: height * 0.40,
                ),
                InkWell(
                  onTap: () {
                    scanBarcode();
                  },
                  child: Container(
                    width: width * 0.60,
                    height: height * 0.070,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(offset: Offset(0, 4), blurRadius: 3),
                      ],
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fit_screen_rounded,
                          color: Color(0xff0D98BA),
                          size: 40,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Scan QR Code",
                          style: TextStyle(
                            color: Color(0xff0D98BA),
                            fontFamily: 'InterRegular',
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
