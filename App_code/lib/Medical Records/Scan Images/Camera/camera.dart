// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:camera/camera.dart';




// class ScancameraScreen extends StatefulWidget {
//   @override
//   _ScancameraScreenState createState() => _ScancameraScreenState();
// }

// class _ScancameraScreenState extends State<ScancameraScreen> {
//   List<CameraDescription>? cameras;
//   CameraController? controller;
//   List<XFile> capturedImages = [];
//   FlashMode flashMode = FlashMode.off;

//   @override
//   void initState() {
//     super.initState();
//     initializeCamera();
//   }

//   Future<void> initializeCamera() async {
//     cameras = await availableCameras();
//     controller = CameraController(cameras![0], ResolutionPreset.high);
//     await controller!.initialize();
//     setState(() {});
//   }

//   Future<void> disposeCamera() async {
//     await controller?.dispose();
//     controller = null;
//   }

//   @override
//   void dispose() {
//     disposeCamera();
//     super.dispose();
//   }

//   Future<void> captureImage() async {
//     try {
//       await controller!.setFlashMode(flashMode);
//       final image = await controller!.takePicture();

//       setState(() {
//         capturedImages.add(image);
//       });
//     } catch (e) {
//       print('Error capturing image: $e');
//     }
//   }

//   void toggleFlash() {
//     setState(() {
//       flashMode =
//           (flashMode == FlashMode.off) ? FlashMode.torch : FlashMode.off;
//     });
//     controller!.setFlashMode(flashMode);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (controller == null || !controller!.value.isInitialized) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         children: [
//           Expanded(
//               flex: 3,
//               child: SizedBox(
//                   width: double.infinity, child: CameraPreview(controller!))),
//           Expanded(
//             flex: 1,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     IconButton(
//                         onPressed: toggleFlash,
//                         icon: Icon(
//                           flashMode == FlashMode.off
//                               ? Icons.flash_off_outlined
//                               : Icons.flash_on,
//                           color: Colors.white,
//                         )),
//                     InkWell(
//                       splashColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                       onTap: () {
//                         captureImage();
//                         Get.snackbar("", "",
//                             messageText: const Text(
//                               "IMAGE CAPTURED",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             duration: const Duration(milliseconds: 450),
//                             backgroundColor: const Color(0xFF67C5DF));
//                       },
//                       child: const CircleAvatar(
//                         radius: 50,
//                         backgroundColor: Colors.white,
//                       ),
//                     ),
//                     Stack(
//                       clipBehavior: Clip.none,
//                       children: [
//                         InkWell(
//                           splashColor: Colors.transparent,
//                           highlightColor: Colors.transparent,
//                           onTap: () async {
//                             await disposeCamera();

//                         //    Get.to(ScanImageview(), arguments: capturedImages);
//                           },
//                           child: const CircleAvatar(
//                             radius: 25,
//                             backgroundColor: Color(0xFF007C9E),
//                             child: Icon(Icons.arrow_forward),
//                           ),
//                         ),
//                         Positioned(
//                             top: -12,
//                             right: -5,
//                             child: CircleAvatar(
//                                 backgroundColor: Colors.amber,
//                                 radius: 15,
//                                 child: Center(
//                                   child: Text(capturedImages.length.toString()),
//                                 )))
//                       ],
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:camera/camera.dart';

// // ✅ Added for PDF
// import 'package:pdf/widgets.dart' as pw;
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';

// class ScancameraScreen extends StatefulWidget {
//   @override
//   _ScancameraScreenState createState() => _ScancameraScreenState();
// }

// class _ScancameraScreenState extends State<ScancameraScreen> {
//   List<CameraDescription>? cameras;
//   CameraController? controller;
//   List<XFile> capturedImages = [];
//   FlashMode flashMode = FlashMode.off;

//   @override
//   void initState() {
//     super.initState();
//     initializeCamera();
//   }

//   Future<void> initializeCamera() async {
//     cameras = await availableCameras();
//     controller = CameraController(cameras![0], ResolutionPreset.high);
//     await controller!.initialize();
//     setState(() {});
//   }

//   Future<void> disposeCamera() async {
//     await controller?.dispose();
//     controller = null;
//   }

//   @override
//   void dispose() {
//     disposeCamera();
//     super.dispose();
//   }

//   Future<void> captureImage() async {
//     try {
//       await controller!.setFlashMode(flashMode);
//       final image = await controller!.takePicture();

//       setState(() {
//         capturedImages.add(image);
//       });
//     } catch (e) {
//       print('Error capturing image: $e');
//     }
//   }

//   void toggleFlash() {
//     setState(() {
//       flashMode =
//           (flashMode == FlashMode.off) ? FlashMode.torch : FlashMode.off;
//     });
//     controller!.setFlashMode(flashMode);
//   }

//   // ✅ NEW: Create & Share PDF (No change to old logic)
//   Future<void> createAndSendPdf() async {
//     final pdf = pw.Document();

//     for (var image in capturedImages) {
//       final imageBytes = await File(image.path).readAsBytes();
//       final pdfImage = pw.MemoryImage(imageBytes);

//       pdf.addPage(
//         pw.Page(
//           build: (pw.Context context) {
//             return pw.Center(
//               child: pw.Image(pdfImage),
//             );
//           },
//         ),
//       );
//     }

//     final outputDir = await getTemporaryDirectory();
//     final file = File("${outputDir.path}/captured_images.pdf");

//     await file.writeAsBytes(await pdf.save());

//     await Share.shareXFiles([XFile(file.path)], text: "Here is your PDF");
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (controller == null || !controller!.value.isInitialized) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         children: [
//           Expanded(
//               flex: 3,
//               child: SizedBox(
//                   width: double.infinity,
//                   child: CameraPreview(controller!))),
//           Expanded(
//             flex: 1,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     IconButton(
//                         onPressed: toggleFlash,
//                         icon: Icon(
//                           flashMode == FlashMode.off
//                               ? Icons.flash_off_outlined
//                               : Icons.flash_on,
//                           color: Colors.white,
//                         )),
//                     InkWell(
//                       splashColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                       onTap: () {
//                         captureImage();
//                         Get.snackbar("",
//                             "",
//                             messageText: const Text(
//                               "IMAGE CAPTURED",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             duration:
//                                 const Duration(milliseconds: 450),
//                             backgroundColor:
//                                 const Color(0xFF67C5DF));
//                       },
//                       child: const CircleAvatar(
//                         radius: 50,
//                         backgroundColor: Colors.white,
//                       ),
//                     ),
//                     Stack(
//                       clipBehavior: Clip.none,
//                       children: [
//                         InkWell(
//                           splashColor: Colors.transparent,
//                           highlightColor: Colors.transparent,
//                           onTap: () async {
//                             await disposeCamera();

//                             // ✅ Added PDF send here
//                             if (capturedImages.isNotEmpty) {
//                               await createAndSendPdf();
//                             } else {
//                               Get.snackbar(
//                                   "Error", "No images captured");
//                             }

//                             // OLD CODE (unchanged)
//                             // Get.to(ScanImageview(), arguments: capturedImages);
//                           },
//                           child: const CircleAvatar(
//                             radius: 25,
//                             backgroundColor: Color(0xFF007C9E),
//                             child: Icon(Icons.arrow_forward),
//                           ),
//                         ),
//                         Positioned(
//                             top: -12,
//                             right: -5,
//                             child: CircleAvatar(
//                                 backgroundColor: Colors.amber,
//                                 radius: 15,
//                                 child: Center(
//                                   child: Text(
//                                       capturedImages.length.toString()),
//                                 )))
//                       ],
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }