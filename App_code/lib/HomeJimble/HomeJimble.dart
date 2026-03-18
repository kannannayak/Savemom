// ignore_for_file: unused_local_variable, use_super_parameters, unused_import, deprecated_member_use, avoid_unnecessary_containers, file_names, sized_box_for_whitespace, non_constant_identifier_names

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:savemom/Cache/Cache_helper.dart';
import 'package:savemom/Color.dart';
import 'package:savemom/HomeJimble/Controller/Homecartcontroller.dart';
import 'package:savemom/HomeJimble/helper.dart';
import 'package:savemom/HomeJimble/slider/slider_controller.dart';
import 'package:savemom/Members/Controller.dart';
import 'package:savemom/Network_Api/Apiend_points.dart';
import 'package:savemom/Profile/ProfileController/Controller_Profile.dart';
import 'package:savemom/QR/qrview.dart';
import 'package:savemom/SideMenuBar/SideMenu.dart';
import 'package:shimmer/shimmer.dart';

import 'package:qr_flutter/qr_flutter.dart';
import '../language.dart';

class HomeJimble extends StatefulWidget {
  final String familyMemberName;
  final String pName;
  final String pId;

  final String rId;

  const HomeJimble({
    Key? key,
    required this.familyMemberName,
    required this.pName,
    required this.pId,
    required this.rId,
  }) : super(key: key);

  @override
  State<HomeJimble> createState() => _HomeJimbleState();
}

class _HomeJimbleState extends State<HomeJimble> {
  final Helper helperclass = Get.put(Helper());
  final profilecontroller = Get.put(Profilecontroller());
  final Relationshipscontroller relationshipscontroller = Get.put(
    Relationshipscontroller(),
  );
  final sliderController = Get.put(SliderController());
  final homecartdata = Get.put(Homecartcontroller());

  String? savedPname;
  String? savedRname;

  @override
  void initState() {
    profilecontroller.profileapi();
    super.initState();
    chksavedata();
    initialize();

    print("gp ssss : ${homecartdata.gp_cart}");
    print("S kkkkkk : ${homecartdata.s_cart}");

    print("rid:${widget.rId}");
    print(
      "Id check : ${widget.pId}+${widget.rId}+${widget.familyMemberName}+${widget.pName}",
    );
  }

  void initialize() async {
    await loadSavedData();
    // notificationCon.notificationOnlyCountViewApi();
    homecartdata.homecartshowapi();
    profilecontroller.profileapi();
    // medicalcords = Get.put(Medicalcontroller());
    sliderController.sliderApi();

    // notificationController.notificationApi();
    print("gp ssss : ${homecartdata.gp_cart}");
    print("S kkkkkk : ${homecartdata.s_cart}");

    print("Saved p name : $savedPname");
    print("Saved relation name : $savedRname");
  }

  String? getsaveRNID;
  String? getsavedPname;
  String? JimbleId;
  String? pname;
  String? rname;
  String? pjimbleid;
  String? rjimbleid;
  Future<void> chksavedata() async {
    final getsavedPname = await Cachehelper.getSaveddata("p_name");
    pname = getsavedPname;

    final JimbleId = await Cachehelper.getSaveddata("jimbleId");
    pjimbleid = JimbleId;

    final getsaveRname = await Cachehelper.getSaveddata("r_name");
    rname = getsaveRname;

    final getsaveRNID = await Cachehelper.getSaveddata("rjimble");
    rjimbleid = getsaveRNID;

    // Print values
    print("P Name: $pname");
    print("P Jimble ID: $pjimbleid");
    print("R Name: $rname");
    print("R Jimble ID: $rjimbleid");
  }

  Future<void> loadSavedData() async {
    getsaveRNID = await Cachehelper.getSaveddata("r_name");
    getsavedPname = await Cachehelper.getSaveddata("p_name");
    JimbleId = await Cachehelper.getSaveddata("jimbleId");
    setState(() {});
    savedPname = await Cachehelper.getSaveddata("p_name");
    savedRname = await Cachehelper.getSaveddata("r_name");
    setState(() {});
  }

  List<String> sliderimage = [
    "https://jimble.traitsolutions.in/Restapi/adminapi/uploads/68369ea42b454_133886655802858820.jpg",
  ];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool condition = false;

  Future<String> generateQrData() async {
    // First await all async operations
    final pId = await Cachehelper.getSaveddata("p_id") ?? "";
    final rId = await Cachehelper.getSaveddata("rId") ?? "";

    // Then construct the JSON object
    final qrData = {
      'Pid': pId,
      'Pjimble':
          profilecontroller.profiledata.value?.patient?.pJimbleId.toString() ??
          '',
      'Rid': rId,
      'Rjimble': widget.rId ?? '',
      // Add more fields as needed
    };

    return jsonEncode(qrData);
  }

  void Qrcode() async {
    profilecontroller.profileapi();
    // Make this function async
    setScreenSize(context);
    final qrData = await generateQrData(); // Await the QR data

    Get.dialog(
      AlertDialog(
        backgroundColor:
            Colors.transparent, // Remove the default dialog background
        contentPadding: EdgeInsets.zero, // Remove default padding
        content: Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.63,
          decoration: BoxDecoration(
            color: Top,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              shbox20,
              Container(
                width: screenWidth * 0.68,
                // height: screenHeight * 0.15,
                decoration: BoxDecoration(
                  color: Dialogbox,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  children: [
                    shbox10,
                    Column(
                      children: [
                        helperclass.rimage.value.isNotEmpty
                            ? Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3.0,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    ApiendPoints.maniurl +
                                        helperclass.rimage.value,
                                    height: 65,
                                    width: 65,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/Profile.png',
                                        height: 65,
                                        width: 65,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              )
                            : (profilecontroller
                                          .profiledata
                                          .value
                                          ?.patient
                                          ?.patientProfile ==
                                      null ||
                                  profilecontroller
                                      .profiledata
                                      .value!
                                      .patient!
                                      .patientProfile!
                                      .isEmpty)
                            ? Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3.0,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/Profile.png',
                                    height: 65,
                                    width: 65,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3.0,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    ApiendPoints.maniurl +
                                        profilecontroller
                                            .profiledata
                                            .value!
                                            .patient!
                                            .patientProfile!,
                                    height: 65,
                                    width: 65,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/Profile.png',
                                        height: 65,
                                        width: 65,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              ),
                        swbox10,
                        Text(
                          (pjimbleid?.isNotEmpty ?? false)
                              ? pjimbleid!
                              : (rjimbleid ?? ''),
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Patent_Black,
                          ),
                        ),
                        Text(
                          (pname?.isNotEmpty ?? false) ? pname! : (rname ?? ''),
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Patent_Black,
                          ),
                        ),
                        // Text(
                        //   "${profilecontroller.profiledata.value?.patient?.age.toString()} / ${profilecontroller.profiledata.value?.patient?.gender.toString()}",
                        //   style: GoogleFonts.inter(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 20,
                        //     color: Patent_Black,
                        //   ),
                        // ),
                        shbox5,
                      ],
                    ),
                  ],
                ),
              ),
              shbox20,
              Container(
                width: screenWidth * 0.7,
                height: screenHeight * 0.3,
                decoration: BoxDecoration(
                  color: Dialogbox,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: QrImageView(
                    data:
                        qrData, // Use the actual QR data instead of the function reference
                    version: QrVersions.auto,
                    size: screenWidth * 0.6,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              shbox15,
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: const BorderSide(color: Colors.black, width: 2),
                    ),
                    elevation: 10,
                    shadowColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Close".tr,
                    style: GoogleFonts.jaldi(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Top,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final passappnum = Get.put(AppointdetailsShowcartController());
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final String qrData =
        profilecontroller.profiledata.value?.patient?.pJimbleId ?? 'N/A';
    setScreenSize(context);
    String _getDisplayName() {
      if (savedPname != null && savedPname!.trim().isNotEmpty) {
        return savedPname!;
      } else if (widget.familyMemberName != null &&
          widget.familyMemberName!.trim().isNotEmpty) {
        return widget.familyMemberName!;
      } else {
        return "Empty";
      }
    }

    return Scaffold(
      backgroundColor: Patent_secondory,
      key: scaffoldKey,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        backgroundColor: Top,
        centerTitle: true,
        title: Text(
          "Savemom",
          style: TextStyle(
            // textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: Appbar[Get.locale?.languageCode] ?? screenWidth * 0.07,
            fontFamily: "jaldiBold",
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
          icon: Image.asset(
            "assets/images/SideMenu.png",
            scale: screenWidth * 0.08,
            height: screenWidth * 0.08,
            fit: BoxFit.contain,
          ),
          onPressed: () {
            // Get.offAll(NavDrawer()); // No need for context
            //  Scaffold.of(context).openDrawer();
            scaffoldKey.currentState?.openDrawer();

            print("this pji : ${helperclass.pjimbleid}");
            print("this rji : ${helperclass.rjimbleid}");
            print("this pn : ${helperclass.pname}");
            print("this rn : ${helperclass.rname}");

            print(helperclass.pjimbleid);
            print(helperclass.rjimbleid);
            print(helperclass.pname);
            print(helperclass.rname);
            print("image${helperclass.rimage.value}");

            if (widget.pId.isNotEmpty && widget.pName.isNotEmpty) {
              print("1");
              helperclass.pjimbleid.value = widget.pId;
              helperclass.pname.value = widget.pName;
            } else {
              print("2");
              helperclass.rjimbleid.value = widget.rId;
              helperclass.rname.value = widget.familyMemberName;
            }
          },
          // icon: Icon(Icons.menu,
          //     color: Patent_secondory, size: screenWidth * 0.08),
        ),

        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 15),
        //     child: Container(
        //       height: 40,
        //       width: 150,
        //       padding: const EdgeInsets.symmetric(horizontal: 10),
        //       decoration: BoxDecoration(
        //         color: Color(0xffD9D9D9),
        //         borderRadius: BorderRadius.circular(30),
        //       ),
        //       child: Row(
        //         children: [
        //           Image.asset(
        //             "assets/images/translate.png",
        //             width: 30,
        //             height: 30,
        //           ),
        //           const SizedBox(width: 8),
        //           Expanded(
        //             child: DropdownButtonHideUnderline(
        //               child: DropdownButton<String>(
        //                 // value: logincontroller.selectedLanguage.value,
        //                 isExpanded: true,
        //                 dropdownColor: Color(0xffD9D9D9),
        //                 icon: const Icon(Icons.keyboard_arrow_down_rounded,
        //                     color: Colors.black),
        //                 style: const TextStyle(
        //                     color: Color(0xff02AEB5), fontSize: 14),
        //                 items: const [
        //                   DropdownMenuItem(
        //                       value: "en_US", child: Text('English')),
        //                   DropdownMenuItem(
        //                       value: "ta_IN", child: Text('தமிழ்')),
        //                   DropdownMenuItem(
        //                       value: "ml_IN", child: Text('മലയാളം')),
        //                   DropdownMenuItem(
        //                       value: "te_IN", child: Text('తెలుగు')),
        //                   DropdownMenuItem(
        //                       value: "kn_IN", child: Text('ಕನ್ನಡ')),
        //                   DropdownMenuItem(
        //                       value: "hi_IN", child: Text('हिंदी')),
        //                   DropdownMenuItem(
        //                       value: "bn_IN", child: Text('বাংলা')),
        //                 ],
        //                 onChanged: (String? newValue) {
        //                   if (newValue != null) {
        //                     setState(() {
        //                       // logincontroller.selectedLanguage.value = newValue;
        //                     });
        //                     final localeParts = newValue.split('_');
        //                     if (localeParts.length == 2) {
        //                       Get.updateLocale(
        //                           Locale(localeParts[0], localeParts[1]));
        //                     } else {
        //                       Get.updateLocale(Locale(localeParts[0]));
        //                     }
        //                   }
        //                 },
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ],
      ),
      drawer: NavDrawer(),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                shbox5,

                // Container(
                //     height: screenHeight * 0.15,
                //     width: screenWidth * 0.9,
                //     child: const GpSlider()),
                shbox10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [],
                ),
                shbox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Qrcode();
                          },
                          child: Container(
                            // height: 70,
                            // width: 70,
                            height: screenHeight * 0.15,
                            width: screenWidth * 0.34,
                            decoration: BoxDecoration(
                              color: Top,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              // Centers the image
                              child: Image.asset(
                                'assets/images/Qr.png',
                                height: 100,
                                width: 100,
                                fit: BoxFit
                                    .contain, // Ensure image is properly fitted
                              ),
                            ),
                          ),
                        ),
                        shbox3,
                        Text(
                          "QR Code".tr,
                          // "Your long text here".tr.split(' ').skip(7).join(' '),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: "Jaldi",
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(Qrview());
                            // Qrcode();
                          },
                          child: Container(
                            // height: 70,
                            // width: 70,
                            height: screenHeight * 0.15,
                            width: screenWidth * 0.34,
                            decoration: BoxDecoration(
                              color: Top,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              // Centers the image
                              child: Image.asset(
                                'assets/images/Scan.png',
                                height: 100,
                                width: 100,
                                fit: BoxFit
                                    .contain, // Ensure image is properly fitted
                              ),
                            ),
                          ),
                        ),
                        shbox3,
                        Text(
                          "QR Scan".tr,
                          // "Your long text here".tr.split(' ').skip(7).join(' '),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: "Jaldi",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                shbox10,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
