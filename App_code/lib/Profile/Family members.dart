// ignore_for_file: file_names, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:savemom/Color.dart';
import 'package:savemom/HomeJimble/helper.dart';
import 'package:savemom/Network_Api/Apiend_points.dart';
import 'package:savemom/Profile/ProfileController/DeleterelationshipControllre.dart';

import '../language.dart';
import 'ProfileController/Controller_Profile.dart';

class Familymembers extends StatefulWidget {
  const Familymembers(
      {super.key,
      required this.Imagesr,
      required this.Dobr,
      required this.Ager,
      required this.Genderr,
      required this.Aadharr,
      required this.pname,
      required this.jidir,
      required this.rname,
      required this.relationr,
      required this.rid,
      required this.value});
  final String Dobr;
  final String Ager;
  final String Genderr;
  final String Aadharr;
  final String pname;
  final String rname;
  final String jidir;
  final String relationr;
  final String Imagesr;
  final String rid;
  final String value;

  @override
  State<Familymembers> createState() => _FamilymembersState();
}

final deleter = Get.put(Deleterelationshipcontrollre());

final profilecontroller = Get.put(Profilecontroller());
final Helper helperclass = Get.put(Helper());
String FormateDate(String data) {
  try {
    DateTime dataparse = DateTime.parse(data);
    return DateFormat("dd-MM-yyyy").format(dataparse);
  } catch (e) {
    print('Date parsing error: $e');
    return "-";
  }
}

class _FamilymembersState extends State<Familymembers> {
  @override
  Widget build(BuildContext context) {
    print(helperclass.pjimbleid);
    print(helperclass.rjimbleid);
    print(helperclass.pname);
    print("fvjhkgbdsjkfhbfjkhdsbv${widget.value}");
    void deletefamily() {
      Get.dialog(
        AlertDialog(
          backgroundColor: Dialogbox,
          // barrierDismissible: false,
          content: Column(
            mainAxisSize: MainAxisSize.min, // Prevents unnecessary height usage
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Are you sure you want to".tr, //Are You Sure You Want to
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.inter(
                      fontSize: Get.locale?.languageCode == 'ta' ? 14 : 18,
                      fontWeight: FontWeight.bold,
                      color: Dialogtext),
                ),
              ),
              Text(
                "delete this profile ?".tr,
                style: GoogleFonts.inter(
                    fontSize: Get.locale?.languageCode == 'ta' ? 14 : 18,
                    fontWeight: FontWeight.bold,
                    color: Dialogtext),
              ),
              shbox5,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      deleter.Deleteapi(widget.rid).toString();
                      // Get.offAll(Login());
                      print("Yes button tapped!");
                      // Add your desired action here
                    },
                    child: Container(
                      width: screenWidth * 0.2,
                      height: 50, // Ensures a perfect circle
                      decoration: BoxDecoration(
                          color: Dialogbutton2,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      alignment: Alignment
                          .center, // Centers the text inside the container
                      child: Text(
                        "Yes".tr,
                        style: GoogleFonts.inter(
                          fontSize: Get.locale?.languageCode == 'ta' ? 14 : 20,
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
                          color: Dialogbutton1,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      alignment: Alignment
                          .center, // Centers the text inside the container
                      child: Text(
                        "No".tr,
                        style: GoogleFonts.inter(
                          fontSize: Get.locale?.languageCode == 'ta' ? 14 : 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Adjust text color if needed
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    setScreenSize(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    print("image:   ${widget.Imagesr}");
    return Scaffold(
        backgroundColor: Patent_secondory,
        appBar: AppBar(
          toolbarHeight: height * 0.080,
          backgroundColor: Top,
          centerTitle: true,
          title: Text(
            "Family Members",
            style: TextStyle(
                // textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize:
                    Appbar[Get.locale?.languageCode] ?? screenWidth * 0.07,
                fontFamily: "JaldiBold",
                color: Patent_secondory),
            // style:TextStyle(color: Patent_secondory,fontFamily: )
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined,
                color: Patent_secondory, size: width * 0.08),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Stack(children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Top,
                  borderRadius: BorderRadius.all(Radius.circular(60)),
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
                        widget.jidir,
                        // member.rJimbleId.toString(),
                        style: TextStyle(
                          color: Patent_secondory,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Center(
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
                            profilecontroller.profiledata.value?.relationships
                                        ?.isNotEmpty ==
                                    true
                                ? ApiendPoints.maniurl + widget.Imagesr
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
                        child: Text(widget.rname,
                            // member.familymembername.toString(),
                            style: _profileTextStyle())),
                    SizedBox(height: 1),
                    _buildProfileRow("DOB".tr, FormateDate(widget.Dobr)),
                    _buildProfileRow("Age".tr, "${widget.Ager} years"),
                    _buildProfileRow("Gender".tr, widget.Genderr),
                    _buildProfileRow(widget.pname, widget.relationr),
                    _buildProfileRow("Aadhar No".tr, widget.Aadharr),
                  ],
                ),
              ),
              // ignore: unrelated_type_equality_checks

              widget.value == "0"
                  ? Positioned(
                      right: 25,
                      top: 25,
                      child: InkWell(
                        onTap: () {
                          deletefamily();
                        },
                        child: Icon(
                          Icons.delete,
                          size: 40,
                          color: DialogDelete1,
                        ),
                      ))
                  : Container()
            ]),
          ),
        ));
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
        ],
      ),
    );
  }

  Widget _buildRelationshipRow(String label, String value,
      {bool isMoney = false}) {
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: InkWell(
              onTap: () {},
              child: Text(
                isMoney ? "\u20B9$value" : value, // ₹ symbol for money values
                style: GoogleFonts.inter(
                    color: Colors.pink,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
