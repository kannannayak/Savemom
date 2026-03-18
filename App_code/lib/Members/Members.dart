import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:savemom/Cache/Cache_helper.dart';
import 'package:savemom/Color.dart';
import 'package:savemom/HomeJimble/HomeJimble.dart';
import 'package:savemom/HomeJimble/helper.dart';

import 'package:savemom/Members/Controller.dart';


import '../language.dart';

class Members extends StatefulWidget {
  const Members({Key? key}) : super(key: key);

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
  final Relationshipscontroller relationshipscontroller =
      Get.put(Relationshipscontroller());
  String? bb;
  List<bool> isCheckedList = [];
  int? selectedIndex;
  bool iscliked = false;
  final Helper helperclass = Get.put(Helper());
  @override
  void initState() {
    super.initState();
    _loadData();
    loadSavedRId();
  }

  void loadSavedRId() async {
    final savedRId = await Cachehelper.getSaveddata("rId");
    print("Saved rId: $savedRId");
  }

  Future<void> _loadData() async {
    try {
      await relationshipscontroller.relationshipsapi();
      setState(() {
        isCheckedList = List.generate(
            relationshipscontroller.membersmodeldata.length, (_) => false);
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load data: $e",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        backgroundColor: Top,
        colorText: Patent_secondory,
        borderRadius: 25,
      );
    }
    print(bb);
  }

  void _handleCheckbox(int index, bool? value) async {
    setState(() {
      // Uncheck all checkboxes
      for (int i = 0; i < isCheckedList.length; i++) {
        isCheckedList[i] = false;
      }
      iscliked = false; // Uncheck the first item's checkbox

      // Check the selected checkbox
      if (value == true) {
        if (index == -1) {
          // First item's checkbox
          iscliked = true;
          selectedIndex = -1;
          print(relationshipscontroller.membersmodeldata.isNotEmpty
              ? relationshipscontroller.membersmodeldata.first.pId
              : "No pId");
          relationshipscontroller.family.value =
              relationshipscontroller.membersmodeldata.first.pName.toString();
          print(relationshipscontroller.family);
        } else {
          // ListView checkbox
          isCheckedList[index] = true;
          selectedIndex = index;

          print(
              "rid pass member page : ${relationshipscontroller.membersmodeldata[index].rId}");
          print(
              relationshipscontroller.membersmodeldata[index].familymembername);
          relationshipscontroller.family.value = relationshipscontroller
              .membersmodeldata[index].familymembername
              .toString();
          print(relationshipscontroller.family);
        }
      } else {
        selectedIndex = null;
      }
    });
    // final int? ridj = relationshipscontroller.membersmodeldata[index].rId;
    // if (ridj != null) {
    //   await Cachehelper.savedata("rId", ridj.toString());
    //   print("uppa yavathu pass akuma : ${ridj}");
    // }

    if (index >= 0 && index < relationshipscontroller.membersmodeldata.length) {
      // Your original code remains unchanged below
      final int? ridj = relationshipscontroller.membersmodeldata[index].rId;
      if (ridj != null) {
        await Cachehelper.savedata("rId", ridj.toString());
        print("uppa yavathu pass akuma : ${ridj}");
      }
    } else {
      print("Invalid index access prevented: $index");
    }
  }

  @override
  Widget build(BuildContext context) {
    setScreenSize(context);

    return Scaffold(
        backgroundColor: Patent_secondory,
      body: SingleChildScrollView(
        child: Obx(
          () {
            return relationshipscontroller.membersmodeldata.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.4,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Container(
                              height: screenHeight / 2.9,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                color: Top,
                                borderRadius: BorderRadius.only(
                                  bottomRight:
                                      Radius.circular(screenWidth * 0.9),
                                  bottomLeft:
                                      Radius.circular(screenWidth * 0.4),
                                ),
                              ),
                            ),
                            Positioned(
                              top: screenHeight * 0.020,
                              right: screenWidth * 0.28,
                              child: Image.asset(
                                "assets/images/Savemom.png",
                                width: screenWidth * 0.6,
                                height: screenHeight / 5,
                              ),
                            ),
                            Positioned(
                              top: screenHeight * 0.25,
                              left: 35,
                              child: Text(
                                "Users".tr,
                                style: TextStyle(
                                  fontFamily: "Jaldi",
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // shbox60,
                      Container(
                        width: screenWidth * 0.95,
                        decoration: BoxDecoration(
                          color: Top,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              shbox5,
                              Center(
                                child: Text(
                                  "Select Patient".tr,
                                  style: GoogleFonts.jaldi(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.locale?.languageCode == 'ta'
                                        ? 20
                                        : 30,
                                    color: Patent_secondory,
                                  ),
                                ),
                              ),
                              shbox3,
                              Column(
                                children: [
                                  // First Row (Header)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween, // Adjust alignment
                                        children: [
                                          Text(
                                            relationshipscontroller
                                                    .membersmodeldata.isNotEmpty
                                                ? relationshipscontroller
                                                    .membersmodeldata
                                                    .first
                                                    .pName
                                                    .toString()
                                                : "",
                                            style: GoogleFonts.jaldi(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color: Patent_secondory,
                                            ),
                                          ),
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              activeColor: iscliked
                                                  ? Colors.black
                                                  : Colors.red,
                                              checkColor: Colors.white,
                                              value: iscliked,
                                              onChanged: (bool? value) {
                                                _handleCheckbox(-1, value);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // ListView for dynamic items
                                  relationshipscontroller
                                              .membersmodeldata.isNotEmpty ||
                                          relationshipscontroller
                                                  .membersmodeldata
                                                  .first
                                                  .familymembername !=
                                              null
                                      ? ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: relationshipscontroller
                                              .membersmodeldata.length,
                                          itemBuilder: (context, index) {
                                            final shrtreation =
                                                relationshipscontroller
                                                    .membersmodeldata[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween, // Adjust alignment
                                                      children: [
                                                        if (shrtreation
                                                                .familymembername !=
                                                            null)
                                                          Text(
                                                            shrtreation
                                                                .familymembername
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .jaldi(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 24,
                                                              color:
                                                                  Patent_secondory,
                                                            ),
                                                          ),
                                                        if (shrtreation
                                                                .familymembername !=
                                                            null)
                                                          Transform.scale(
                                                            scale: 1.5,
                                                            child: Checkbox(
                                                              activeColor:
                                                                  isCheckedList[
                                                                          index]
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .red,
                                                              checkColor:
                                                                  Colors.white,
                                                              value:
                                                                  isCheckedList[
                                                                      index],
                                                              onChanged: (bool?
                                                                  value) {
                                                                _handleCheckbox(
                                                                    index,
                                                                    value);
                                                              },
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      : Container(),
                                ],
                              ),
                              shbox10,
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      side: const BorderSide(
                                          color: Colors.black, width: 1),
                                    ),
                                    elevation: 10,
                                    shadowColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                  ),
                                  onPressed: () async {
                                    helperclass.pname.value = "";
                                    helperclass.rname.value = "";
                                    helperclass.pjimbleid.value = "";
                                    helperclass.rjimbleid.value = "";

                                    helperclass.rimage.value = "";

                                    print(
                                        " theriyala iyyyoooo: ${relationshipscontroller.family}");
                                    if (selectedIndex != null) {
                                      String pName = '';
                                      String pId = '';
                                      String familyMemberName = '';
                                      String rId = '';

                                      if (selectedIndex == -1) {
                                        print("sdfc");
                                        var selected = relationshipscontroller
                                            .membersmodeldata.first;
                                        pName = selected.pName ?? '';
                                        pId = selected.pJimbleId.toString();
                                        await Cachehelper.savedata(
                                            "jimbleId", pId);
                                        final JimbleId =
                                            await Cachehelper.getSaveddata(
                                                "jimbleId");
                                        print(
                                            "JimbleId Data pass   : $JimbleId");

                                        await Cachehelper.savedata("p_name",
                                            selected.pName.toString());
                                        final getsavedPname =
                                            await Cachehelper.getSaveddata(
                                                "p_name");
                                        print("getsavedData  : $getsavedPname");
                                        print("pid$pId");
                                      } else {
                                        print("sdfc2");
                                        // Other checkboxes selected - use family member info
                                        var selected = relationshipscontroller
                                            .membersmodeldata[selectedIndex!];
                                        familyMemberName =
                                            selected.familymembername ?? '';
                                        pId = selected.pId?.toString() ?? '';
                                        rId = selected.rJimbleId?.toString() ??
                                            '';
                                        await Cachehelper.savedata("r_name",
                                            familyMemberName.toString());
                                        final getsaveRNID =
                                            await Cachehelper.getSaveddata(
                                                "r_name");
                                        print("getsaveR_name : $getsaveRNID");

                                        print(
                                            "rid values tik tik pass : ${rId}");

                                        helperclass.rimage.value =
                                            selected.profileImg.toString();
                                        final rjimble =
                                            await Cachehelper.savedata(
                                                "rjimble", rId);

                                        print("rjimble kkkssss : $rId");
                                        print(
                                            "image${helperclass.rimage.value}");
                                      }

                                      Get.snackbar(
                                        "Patient Selected",
                                        selectedIndex == -1
                                            ? "Name: $pName"
                                            : "Family Member: $familyMemberName",
                                        snackPosition: SnackPosition.BOTTOM,
                                        margin: const EdgeInsets.only(
                                            bottom: 20, left: 20, right: 20),
                                        backgroundColor: Top,
                                        colorText: Patent_secondory,
                                        borderRadius: 25,
                                      );

                                      Get.off(
                                        HomeJimble(
                                          pName: pName,
                                          pId: pId,
                                          familyMemberName: familyMemberName,
                                          rId: rId,
                                        ),
                                        transition: Transition.fade,
                                      );
                                    } else {
                                      Get.snackbar(
                                        "Error",
                                        "Please select a patient",
                                        snackPosition: SnackPosition.BOTTOM,
                                        margin: const EdgeInsets.only(
                                            bottom: 20, left: 20, right: 20),
                                        backgroundColor: Top,
                                        colorText: Patent_secondory,
                                        borderRadius: 25,
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Go".tr,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff02AEB5),
                                    ),
                                  ),
                                ),
                              ),
                              shbox10,
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
