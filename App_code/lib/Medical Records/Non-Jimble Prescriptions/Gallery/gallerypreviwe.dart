// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:jimbel_patent/Color.dart';
// import 'package:jimbel_patent/Medical%20Records/MedicalController.dart';
// import 'package:jimbel_patent/Medical%20Records/Non-Jimble%20Prescriptions/Prescriptions.dart';
// import 'package:jimbel_patent/language.dart';

// class Prepreview extends StatefulWidget {
//   const Prepreview({super.key});

//   @override
//   State<Prepreview> createState() => _PrepreviewState();
// }

// class _PrepreviewState extends State<Prepreview> {
//   bool isLoading = false;
//   final pic = Get.put(Medicalcontroller());

//   List<File> scanImage = [];
//   List<File> scanGallery = [];
//   List<File> scanPdf = [];
//   List<File> labImages = [];
//   List<File> labGallery = [];
//   List<File> labPdf = [];

//   List<File> prescriptionImage = [];
//   List<File> _images = [];
//   List<File> prescriptionPdf = [];

//   List<File> dischargeImage = [];
//   List<File> dischargeGallery = [];
//   List<File> dischargePdf = [];

//   List<File> otherImage = [];
//   List<File> otherGallery = [];
//   List<File> otherPdf = [];
//   void Alert() {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//             backgroundColor: Colors.transparent,
//             content: Container(
//               // height: mediaHeight * 0.15,
//               decoration: BoxDecoration(
//                 color: Color(0xff0D98BA),
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(
//                     height: 25,
//                   ),
//                   Center(
//                       child: Text(
//                     "Images added ",
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   )),
//                   Center(
//                       child: Text(
//                     " Successfully",
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   )),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Get.off(PrescriptionsReports());
//                     },
//                     child: Center(
//                       child: Container(
//                         height: 30,
//                         width: MediaQuery.sizeOf(context).width / 7,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black),
//                           color: Colors.white,
//                           boxShadow: [BoxShadow(offset: Offset(0, 5))],
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Center(
//                           child: Text(
//                             textAlign: TextAlign.center,
//                             "OK",
//                             style: TextStyle(
//                                 color: Color(0xff0D98BA),
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   )
//                 ],
//               ),
//             ));
//       },
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     final List<XFile> xImages = Get.arguments ?? [];
//     _images = xImages.map((xFile) => File(xFile.path)).toList();
//   }

//   void _removeImage(int index) {
//     setState(() {
//       _images.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: screenHeight * 0.1,
//         backgroundColor: Top,
//         centerTitle: true,
//         title: Text(
//           "Preview Images",
//           style: TextStyle(
//               // textStyle: Theme.of(context).textTheme.displayLarge,
//               fontSize: Appbar[Get.locale?.languageCode] ?? screenWidth * 0.07,
//               fontFamily: "JaldiBold",
//               color: Patent_secondory),
//           // style:TextStyle(color: Patent_secondory,fontFamily: )

//           // style:TextStyle(color: Patent_secondory,fontFamily: )
//         ),
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30))),
//         leading: IconButton(
//           // icon: Image.asset("assets/images/Arrows.png", scale: screenWidth * 0.08,
//           //       height: screenWidth * 0.08,
//           //       fit: BoxFit.contain),
//           onPressed: () {
//             Get.back();
//           },
//           icon: Icon(
//             Icons.arrow_back_ios_new_outlined,
//             color: Patent_secondory,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           _images.isNotEmpty
//               ? Expanded(
//                   child: GridView.builder(
//                     padding: EdgeInsets.all(10),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3, // 3 images per row
//                       crossAxisSpacing: 8,
//                       mainAxisSpacing: 8,
//                     ),
//                     itemCount: _images.length,
//                     itemBuilder: (context, index) {
//                       return Stack(
//                         alignment: Alignment.topRight,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.file(
//                               _images[index],
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                               height: double.infinity,
//                             ),
//                           ),
//                           Positioned(
//                             top: 5,
//                             right: 5,
//                             child: GestureDetector(
//                               onTap: () => _removeImage(index),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.red,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 padding: EdgeInsets.all(5),
//                                 child: Icon(Icons.close,
//                                     color: Colors.white, size: 20),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 )
//               : Center(
//                   child: Text("No images to display",
//                       style: TextStyle(fontSize: 18)),
//                 ),
//           SizedBox(
//             height: 20,
//           ),
//           // Center(
//           //   child: InkWell(
//           //     onTap: () async {
//           //             bool retuenvalue = await pic.Medicalrecordsapi(
//           //             pic.predate.toString(),
//           //                 scanImage,
//           //                 scanGallery,
//           //                 scanPdf,
//           //                 labImages,
//           //                 labGallery,
//           //                 labPdf,
//           //                 prescriptionImage,
//           //                 _images,
//           //                 prescriptionPdf,
//           //                 dischargeImage,
//           //                 dischargeGallery,
//           //                 dischargePdf,
//           //                 otherImage,
//           //                 otherGallery,
//           //                 otherPdf); if (retuenvalue == true) {
//           //         Alert();
//           //       } else {
//           //         print('error');
//           //       }
//           //           },
//           //     child: Container(
//           //       height: 30,
//           //       width: MediaQuery.sizeOf(context).width / 3,
//           //       decoration: BoxDecoration(
//           //         border: Border.all(color: Colors.black),
//           //         color: Color(0xff0D98BA),
//           //         boxShadow: [BoxShadow(offset: Offset(0, 5))],
//           //         borderRadius: BorderRadius.circular(20),
//           //       ),
//           //       child: Center(
//           //         child: Text(
//           //           textAlign: TextAlign.center,
//           //           "Upload",
//           //           style: TextStyle(
//           //               color: Colors.white,
//           //               fontSize: 14,
//           //               fontWeight: FontWeight.bold),
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // ),

//           Center(
//             child: InkWell(
//               onTap: () async {
//                 if (isLoading) return; // Prevent multiple taps

//                 setState(() {
//                   isLoading = true;
//                 });

//                 try {
//                   bool retuenvalue = await pic.Medicalrecordsapi(
//                       pic.predate.toString(),
//                       scanImage,
//                       scanGallery,
//                       scanPdf,
//                       labImages,
//                       labGallery,
//                       labPdf,
//                       prescriptionImage,
//                       _images,
//                       prescriptionPdf,
//                       dischargeImage,
//                       dischargeGallery,
//                       dischargePdf,
//                       otherImage,
//                       otherGallery,
//                       otherPdf);
//                   setState(() {
//                     isLoading = false;
//                   });

//                   if (retuenvalue == true) {
//                     Alert();
//                   } else {
//                     print('error');
//                   }
//                 } catch (e) {
//                   setState(() {
//                     isLoading = false;
//                   });
//                   print('Error: $e');
//                 }
//               },
//               child: Container(
//                 height: 30,
//                 width: MediaQuery.sizeOf(context).width / 3,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   color: Top,
//                   boxShadow: [BoxShadow(offset: Offset(0, 5))],
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Center(
//                   child: isLoading
//                       ? SizedBox(
//                           width: 20,
//                           height: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor:
//                                 AlwaysStoppedAnimation<Color>(Colors.white),
//                           ),
//                         )
//                       : Text(
//                           textAlign: TextAlign.center,
//                           "Upload",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(
//             height: 20,
//           )
//         ],
//       ),
//     );
//   }
// }
