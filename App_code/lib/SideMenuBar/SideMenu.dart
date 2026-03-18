// ignore_for_file: sort_child_properties_last, use_key_in_widget_constructors, use_build_context_synchronously, file_names, unused_import, non_constant_identifier_names, must_be_immutable, unused_element, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



import 'package:savemom/Cache/Cache_helper.dart';
import 'package:savemom/Color.dart';
import 'package:savemom/HomeJimble/helper.dart';
import 'package:savemom/Login/Controller/LoginController.dart';
import 'package:savemom/Network_Api/Apiend_points.dart';
import 'package:savemom/Profile/Family%20members.dart';
import 'package:savemom/Profile/Profile.dart';
import 'package:savemom/Profile/ProfileController/Controller_Profile.dart';
import 'package:savemom/SideMenuBar/SideMenuController/DeleteController.dart';



class NavDrawer extends StatefulWidget {
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final deletecontroller = Get.put(Deletecontroller());
  final profilecontroller2 = Get.put(Profilecontroller());
  TextEditingController deletetextcontroller = TextEditingController();
  final Helper helperclass = Get.put(Helper());
  final logindispose = Get.put(Logincontroller());

  @override
  void initState() {
    _loadSavedData();
    chksavedata();
    profilecontroller.profileapi();
    print("pjimbleid : ssssss ${helperclass.pjimbleid}");
    print("rjimbleid : kkkkkk ${helperclass.rjimbleid}");
    print("pname : xxxxx ${helperclass.pname}");
    print("rname : rrrrrr ${helperclass.rname}");
    print("image${helperclass.rimage.value}");

    super.initState();
  }

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

  String? getsaveRNID;
  String? getsavedPname;
  String? JimbleId;

  Future<void> _loadSavedData() async {
    getsaveRNID = await Cachehelper.getSaveddata("r_name");
    getsavedPname = await Cachehelper.getSaveddata("p_name");
    JimbleId = await Cachehelper.getSaveddata("jimbleId");
    setState(() {}); // Update the UI if needed
  }

  @override
  Widget build(BuildContext context) {
    Future logoutclear() async {
      await Cachehelper.deletedata("p_id");
      await Cachehelper.deletedata("rId");
      await Cachehelper.deletedata("r_name");
      await Cachehelper.deletedata("p_name");
      await Cachehelper.deletedata("jimbleId");
      await Cachehelper.deletedata("rjimble");
      Cachehelper.deletedata("rId");
      Cachehelper.deletedata("p_id");
      print("Delete pid : ${Cachehelper.deletedata("p_id")}");
      print("Delete rId : ${Cachehelper.deletedata("rId")}");
      // Get.off(Login(), transition: Transition.fade);
      // Get.off(SplashScreen(), transition: Transition.fade);
    }


    setScreenSize(context);
    return Drawer(
      backgroundColor: Top,
      width: screenWidth * 0.8,
      child: ListView(
        // padding: EdgeInsets.zero,
        children: <Widget>[
          shbox10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                              ApiendPoints.maniurl + helperclass.rimage.value,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/Profile.png',
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        )
                      : (profilecontroller.profiledata.value?.patient
                                      ?.patientProfile ==
                                  null ||
                              profilecontroller.profiledata.value!.patient!
                                  .patientProfile!.isEmpty)
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
                                  height: 100,
                                  width: 100,
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
                                      profilecontroller.profiledata.value!
                                          .patient!.patientProfile!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/Profile.png',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  children: [
                    Text(
                      (pname?.isNotEmpty ?? false) ? pname! : (rname ?? ''),
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Patent_secondory),
                    ),
                    shbox3,
                    Text(
                      (pjimbleid?.isNotEmpty ?? false)
                          ? pjimbleid!
                          : (rjimbleid ?? ''),
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Patent_secondory),
                    )
                  ],
                ),
              )
            ],
          ),
          shbox15,
          ListTile(
            leading: Image.asset(
              "assets/images/Profilepic.png",
              width: 60,
              height: 60,
            ),
            title: Text(
              "Profile".tr,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: Get.locale?.languageCode == 'ta' ? 10 : 14,
                  color: Patent_secondory),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Patent_secondory,
            ),
            onTap: () => {
              //    Get.back(),
              Get.to(
                  Profile(
                    pid: helperclass.pname.toString() ?? "hh",
                  ),
                  transition: Transition.fade),
            },
          ),
          shbox3,
          Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: Colors.white,
          ),
          shbox3,
         
         
      
     
      
       
    
       
        ],
      ),
    );
  }
}
