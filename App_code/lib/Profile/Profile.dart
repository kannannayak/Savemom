// ignore_for_file: file_names, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:savemom/Color.dart';
import 'package:savemom/HomeJimble/HomeJimble.dart';
import 'package:savemom/HomeJimble/helper.dart';
import 'package:savemom/Network_Api/Apiend_points.dart';

import '../language.dart';
import 'ProfileController/Controller_Profile.dart';
import 'Family members.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.pid});
  final String pid;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final profilecontroller = Get.put(Profilecontroller());
  final Helper helperclass = Get.put(Helper());
  String valuecheck = "";
  String FormateDate(String data) {
    try {
      DateTime dataparse = DateTime.parse(data);
      return DateFormat("dd-MM-yyyy").format(dataparse);
    } catch (e) {
      print('Date parsing error: $e');
      return "-";
    }
  }

  @override
  void initState() {
    profilecontroller.profileapi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("getvalurether${widget.pid}");
    print(helperclass.pjimbleid);
    print(helperclass.rjimbleid);
    print(helperclass.pname);
    print(helperclass.rname);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Patent_secondory,
      appBar: AppBar(
        toolbarHeight: height * 0.080,
        backgroundColor: Top,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
              // textStyle: Theme.of(context).textTheme.displayLarge,
              fontSize: Appbar[Get.locale?.languageCode] ?? screenWidth * 0.07,
              fontFamily: "JaldiBold",
              color: Patent_secondory),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            print("gdf");
            Get.off(
                HomeJimble(familyMemberName: "", pName: "", pId: "", rId: ""));
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined,
              color: Patent_secondory, size: width * 0.08),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(child: Obx(
          () {
            final data = profilecontroller.profiledata.value;

            if (data == null || data.patient == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Top,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        data.patient!.pJimbleId.toString(),
                        style: TextStyle(
                          color: Patent_secondory,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    profilecontroller.profiledata.value!.patient!
                                    .patientProfile ==
                                null ||
                            profilecontroller.profiledata.value!.patient!
                                .patientProfile!.isEmpty
                        ? Center(
                            child: Container(
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
                            ),
                          )
                        : Center(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3.0,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  profilecontroller.profiledata.value?.patient
                                              ?.patientProfile?.isNotEmpty ==
                                          true
                                      ? ApiendPoints.maniurl +
                                          profilecontroller.profiledata.value!
                                              .patient!.patientProfile!
                                      : 'assets/images/Profile.png', // fallback image
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/Profile.png', // a local placeholder
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 5),
                    Center(
                        child: Text(
                            profilecontroller.profiledata.value!.patient!.pName
                                .toString(),
                            style: _profileTextStyle())),
                    SizedBox(height: 1),
                    _buildProfileRow(
                        "DOB".tr, FormateDate(data.patient!.dob.toString())),
                    _buildProfileRow("Age".tr,
                        "${profilecontroller.profiledata.value!.patient!.age} years"),
                    _buildProfileRow(
                        "Gender".tr,
                        profilecontroller.profiledata.value!.patient!.gender
                            .toString()),
                    _buildProfileRow(
                        "Contact Number".tr,
                        profilecontroller.profiledata.value!.patient!.mobileNo
                            .toString()),
                    _buildProfileRow(
                        "Email ID".tr,
                        profilecontroller.profiledata.value!.patient!.emil
                            .toString()),
                    _buildProfileRow(
                        "Aadhar No".tr,
                        profilecontroller.profiledata.value!.patient!.aadharNo
                            .toString()),
                    _buildProfileRow(
                        "Address".tr,
                        profilecontroller.profiledata.value!.patient!.address
                            .toString()),
                    _buildProfileRow(
                        "Location".tr,
                        profilecontroller.profiledata.value!.patient!.location
                            .toString()),
                    _buildProfileRow(
                        "Pincode".tr,
                        profilecontroller.profiledata.value!.patient!.pincode
                            .toString()),
                    _buildProfileRow(
                        "City/village".tr,
                        profilecontroller.profiledata.value!.patient!.city
                            .toString()),
                    _buildProfileRow(
                        "District".tr,
                        profilecontroller.profiledata.value!.patient!.district
                            .toString()),
                    _buildProfileRow(
                        "State".tr,
                        profilecontroller.profiledata.value!.patient!.state
                            .toString()),
                    shbox15,
                    _buildProfileRow1("Family".tr, ""),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: profilecontroller
                              .profiledata.value!.relationships?.length ??
                          0,
                      itemBuilder: (context, index) {
                        final relation = profilecontroller
                            .profiledata.value!.relationships![index];

                        return Visibility(
                          visible: relation.deleteStatus ==
                              0, // Show only if deleteStatus is 0
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, left: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Text(
                                    relation.relationship?.toString() ?? "Null",
                                    style: GoogleFonts.inter(
                                      color: Patent_Black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: InkWell(
                                    onTap: () {
                                      print(
                                          "jhbjhb${helperclass.pjimbleid.value}");
                                      print(helperclass.rjimbleid);
                                      print(helperclass.pname);
                                      print(helperclass.rname);
                                      if (helperclass.pjimbleid.isNotEmpty &&
                                          helperclass.pname.isNotEmpty) {
                                        print('1');
                                        valuecheck = "0";
                                        print(valuecheck);
                                      } else {
                                        print("2");
                                        valuecheck = "1";
                                        print(valuecheck);
                                      }
                                      Get.to(
                                          Familymembers(
                                            Imagesr:
                                                relation.profileImg.toString(),
                                            relationr: relation.relationship
                                                .toString(),
                                            Aadharr:
                                                relation.aadharNo.toString(),
                                            Ager: relation.age.toString(),
                                            Dobr: relation.dob.toString(),
                                            Genderr: relation.gender.toString(),
                                            jidir:
                                                relation.rJimbleId.toString(),
                                            pname: profilecontroller.profiledata
                                                .value!.patient!.pName
                                                .toString(),
                                            rname: relation.familymembername
                                                .toString(),
                                            rid: relation.rId.toString(),
                                            value: valuecheck,
                                          ),
                                          transition: Transition.fade);
                                    },
                                    child: Text(
                                      relation.familymembername?.toString() ??
                                          "Null",
                                      style: GoogleFonts.inter(
                                        color: Relationship,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          },
        )),
      ),
    );
  }

  TextStyle _profileTextStyle() {
    return TextStyle(
        color: Patent_secondory, fontSize: 16, fontFamily: 'InterBold');
  }

  Widget _buildProfileRow(String label, String value, {bool isMoney = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: Patent_Black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Text(
              isMoney ? "\u20B9$value" : value, // ₹ symbol for money values
              style: GoogleFonts.inter(
                  color: Patent_secondory,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ], //9942148040
      ),
    );
  }

  Widget _buildProfileRow1(String label, String value, {bool isMoney = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: Patent_Black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Text(
              isMoney ? "\u20B9$value" : value, // ₹ symbol for money values
              style: GoogleFonts.inter(
                  color: Patent_secondory,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ], //9942148040
      ),
    );
  }

//   Widget _buildRelationshipRow(String label, String value,
//       {bool isMoney = false}) {
//     return }
// }
}
