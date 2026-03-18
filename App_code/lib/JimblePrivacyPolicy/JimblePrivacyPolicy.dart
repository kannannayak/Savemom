// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:savemom/JimblePrivacyPolicy/PolicyController.dart';
import 'package:shimmer/shimmer.dart';

import '../Color.dart';
import '../language.dart';

class JimblePrivacyPolicy extends StatefulWidget {
  const JimblePrivacyPolicy({super.key});

  @override
  State<JimblePrivacyPolicy> createState() => _JimblePrivacyPolicyState();
}

class _JimblePrivacyPolicyState extends State<JimblePrivacyPolicy> {
  final policycontroller = Get.put(Policycontroller());
  @override
  void initState() {
    policycontroller.policyadnterms();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Patent_secondory,
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        backgroundColor: Top,
        centerTitle: true,
        title: Text(
          "Jimble Policy & Terms",
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
            onPressed: () {
              Get.back(result: true);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Patent_secondory,
            )),
      ),
      body:

//        Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           shbox20,
//           Container(
//             child: Column(
//               children: [
//                 SingleChildScrollView(
//                   child: Obx(
//                     () {
//                       return Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: Center(
//                           child: Text(
//                             policycontroller.policyandterms.value?.data
//                                     ?.privacyPolicy ??
//                                 'No policy available',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 shbox20,
//                 Center(
//                   child: InkWell(
//                     onTap: () {
//                       Get.back(result: true);
//                     },
//                     child: Container(
//                       width: width * 0.30,
//                       height: height * 0.050,
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(offset: Offset(0, 4), blurRadius: 3)
//                         ],
//                         color: Top,
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Patent_Black, width: 1),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Next".tr, //Continue
//                           style:
//                               TextStyle(color: Patent_secondory, fontSize: 20),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20),
//           // ElevatedButton(
//           //   onPressed: () {
//           //     Get.back(result: true);
//           //   },
//           //   style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//           //   child: Text("Continue", style: TextStyle(color: Colors.white)),
//           // ),
//         ],
//       ),
//     );
//   }
// }

          Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(child: Obx(() {
                final data = policycontroller.policyandterms.value?.data;

                if (data == null) {
                  // Show shimmer
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                }

                if (data.privacyPolicy!.isEmpty) {
                  // No data message
                  return Center(
                    child:
                        Text("No data found.", style: TextStyle(fontSize: 16)),
                  );
                }

                // Show actual data
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data.privacyPolicy.toString(),
                    textAlign: _parseTextAlign(data.textAlignment.toString()),
                    style: TextStyle(
                        fontSize: _parseFontSize(data.fontSize.toString()),
                        color: _parseHexColor(data.textColor.toString()),
                        fontFamily: 'InterSemiBold'),
                  ),
                );
              })),
            ),
            shbox20,
            Center(
              child: InkWell(
                onTap: () {
                  Get.back(result: true);
                },
                child: Container(
                  width: width * 0.30,
                  height: height * 0.050,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(offset: Offset(0, 4), blurRadius: 3)],
                    color: Top,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Patent_Black, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      "Next".tr, //Continue
                      style: TextStyle(color: Patent_secondory, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  double _parseFontSize(String? fontSizeStr) {
    if (fontSizeStr == null) return 14.0; // default size
    return double.tryParse(fontSizeStr.replaceAll("px", "")) ?? 14.0;
  }

  Color _parseHexColor(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) return Colors.black;
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) hexColor = "FF$hexColor"; // Add full opacity
    return Color(int.parse("0x$hexColor"));
  }

  TextAlign _parseTextAlign(String? alignment) {
    switch (alignment?.toLowerCase()) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      case 'justify':
        return TextAlign.justify;
      default:
        return TextAlign.left;
    }
  }
}
