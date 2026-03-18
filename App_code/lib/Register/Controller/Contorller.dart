import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;




import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:savemom/AccountCreated/AccountCreated.dart';
import 'package:savemom/Color.dart';
import 'package:savemom/Network_Api/Apiend_points.dart';
import 'package:savemom/Register/Model/ResendModel.dart';
import 'package:savemom/Register/Model/VerifiedModel.dart';
import 'package:savemom/Register/Model/registermodel.dart';



class RegisterContorller extends GetxController {
  var familys = <Map<String, dynamic>>[].obs;
  var verified = Verifiedmodel().obs;
  var resend = ResentModel().obs;
  final Rx<TextEditingController> otpController = TextEditingController().obs;
  Map<String, dynamic> _familyMembers(int familyIndex) {
    return {
      "r_jimble_id": "JItSmrffrefe00f2rg5dc66",
      "relationship": TextEditingController(),
      "familyMembersLabel": "Family Member ${familyIndex + 1}",
      "familymembername": TextEditingController(),
      "dob": "".obs,
      "age": "".obs,
      "gender": SingleValueDropDownController(),
      "aadhar_no": TextEditingController(),
      "profile_img": Rx<Uint8List?>(null),
      "profile_img_name": "".obs,
    };
  }

  var pid = ''.obs;
  List<Map<String, dynamic>> getFamily() {
    List<Map<String, dynamic>> filtered = [];

    for (var family in familys) {
      String relationship = family["relationship"]?.text?.trim() ?? "";
      String mrms = family["mrms"]?.text?.trim() ?? "";
      String familymembername = family["familymembername"]?.text?.trim() ?? "";
      String dob = family["dob"]?.value?.toString().trim() ?? "";
      String age = family["age"]?.value?.toString().trim() ?? "";
      String gender =
          family["gender"]?.dropDownValue?.value?.toString().trim() ?? "";
      String aadhar_no = family["aadhar_no"]?.text?.trim() ?? "";

      // **Remove the default empty list** so profile_img stays null if never set:
      Uint8List? profile_img = family["profile_img"]?.value;

      String profile_img_name = family["profile_img_name"]?.value ?? "";

      // Skip entries that are entirely blank (including no image)
      if (relationship.isEmpty &&
          familymembername.isEmpty &&
          dob.isEmpty &&
          age.isEmpty &&
          gender.isEmpty &&
          aadhar_no.isEmpty &&
          profile_img == null) {
        continue;
      }

      filtered.add({
        "r_jimble_id": family["r_jimble_id"],
        "relationship": relationship,
        "mrms": mrms,
        "familymembername": familymembername,
        "dob": dob,
        "age": age,
        "gender": gender,
        "aadhar_no": aadhar_no,
        "profile_img": profile_img,
        "profile_img_name": profile_img_name,
      });
    }

    return filtered;
  }

  void onInit() {
    super.onInit();
    addFamilyMembers();
    fetchCities();
    fetchState();
  }

  var cityList = <DropDownValueModel>[].obs;
  var districtList = <DropDownValueModel>[].obs;
  var stateList = <DropDownValueModel>[].obs;

  var selectedCityId = 0.obs;
  var selectedDistrictId = 0.obs;
  Future<void> fetchCities() async {
    print("object");
    try {
      const apiUrl =
          "https://jimble.traitsolutions.in/Restapi/patient/get_location_data.php";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"api_key": "jimble@123"}),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          List<dynamic> data = jsonResponse['data'];
          cityList.value = data
              .map((item) => DropDownValueModel(
                    name: item['city_name'],
                    value: item['id'].toString(),
                  ))
              .toList();
        } else {
          Get.snackbar("Error", jsonResponse['message'],
              backgroundColor: Color(0xff0D98BA));
        }
      } else {
        Get.snackbar("Error", "Failed to fetch cities",
            backgroundColor: Color(0xff0D98BA));
      }
    } catch (e) {
      print("Error fetching cities: $e");
      Get.snackbar("Network Error", "Please check your internet connection.",
          backgroundColor: Color(0xff0D98BA));
    }
  }

  Future<void> fetchDistrict(int cityId) async {
    try {
      const apiUrl =
          "https://jimble.traitsolutions.in/Restapi/patient/get_location_data.php";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "api_key": "jimble@123",
          "city_id": cityId,
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          var data = jsonResponse['data'];
          districtList.value = [
            DropDownValueModel(
              name: data['district_name'],
              value: data['district_id'].toString(),
            )
          ];
          selectedDistrictId.value = data['district_id'];
          districtcontroller.value.dropDownValue = DropDownValueModel(
            name: data['district_name'],
            value: data['district_id'].toString(),
          );
          print(districtcontroller.value.dropDownValue!.name);
        } else {
          districtList.clear();
          Get.snackbar("Error", jsonResponse['message'],
              backgroundColor: Color(0xff0D98BA));
        }
      } else {
        districtList.clear();
        Get.snackbar("Error", "Failed to fetch district",
            backgroundColor: Color(0xff0D98BA));
      }
    } catch (e) {
      print("Error fetching district: $e");
      districtList.clear();
      Get.snackbar("Network Error", "Please check your internet connection.",
          backgroundColor: Color(0xff0D98BA));
    }
  }

  Future<void> fetchState() async {
    try {
      const apiUrl =
          "https://jimble.traitsolutions.in/Restapi/adminapi/get_states.php";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "api_key": "jimble@123",
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          print(jsonResponse);
          var data = jsonResponse['data'];
          stateList.value = data.map<DropDownValueModel>((state) {
            return DropDownValueModel(
              name: state['state_name'],
              value: state['state_code'],
            );
          }).toList();
          print("state${stateList}");
        } else {
          stateList.clear();
          Get.snackbar("Error", jsonResponse['message'],
              backgroundColor: Color(0xff0D98BA));
        }
      } else {
        stateList.clear();
        Get.snackbar("Error", "Failed to fetch state",
            backgroundColor: Color(0xff0D98BA));
      }
    } catch (e) {
      print("Error fetching state: $e");
      stateList.clear();
      Get.snackbar("Network Error", "Please check your internet connection.",
          backgroundColor: Color(0xff0D98BA));
    }
  }

  List<Map<String, dynamic>> bb = [];
  void addInitialFamilyMembers() {
    // familys.add(_familyMembers(1));
    familys.add(_familyMembers(familys.length));
    print("After adding: $familys");

    bb = getFamily();
    print("Filtered family: $bb");

    if (bb.isNotEmpty) {
      print("data: ${bb[0]['profile_img']}");
    } else {
      print("No valid family members found in bb list.");
    }
  }

  void addFamilyMembers() {
    familys.add(_familyMembers(familys.length));
  }

  void removeFamilyMembers(int index) {
    if (index >= 0 && index < familys.length) {
      familys.removeAt(index);
      update(); // If you're using GetBuilder
    }
  }

  void clearFamilyData() {
    // Dispose all controllers to avoid memory leaks
    for (var family in familys) {
      (family["relationship"] as TextEditingController?)?.dispose();
      (family["mrms"] as TextEditingController?)?.dispose();
      (family["familymembername"] as TextEditingController?)?.dispose();
      (family["aadhar_no"] as TextEditingController?)?.dispose();
      // No need to dispose obs or SingleValueDropDownController
    }

    familys.clear(); // Remove all entries
    familys.add(_familyMembers(0)); // Re-add a clean one
    update(); // Notify UI if using GetBuilder or similar
  }

  final Rx<GlobalKey<FormState>> _formKey = GlobalKey<FormState>().obs;
  Rx<GlobalKey<FormState>> get formKey => _formKey;
  final Rx<SingleValueDropDownController> msmr =
      SingleValueDropDownController().obs;

  final Rx<SingleValueDropDownController> normalmrs =
      SingleValueDropDownController().obs;

  final Rx<TextEditingController> nameController = TextEditingController().obs;
  final Rx<TextEditingController> contactController =
      TextEditingController().obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> dobController = TextEditingController().obs;
  final Rx<TextEditingController> ageController = TextEditingController().obs;
  final Rx<TextEditingController> aadharController =
      TextEditingController().obs;
  final Rx<TextEditingController> addressController =
      TextEditingController().obs;
  final Rx<TextEditingController> genderController =
      TextEditingController().obs;
  final Rx<TextEditingController> locationController =
      TextEditingController().obs;
  final Rx<TextEditingController> pinCodeController =
      TextEditingController().obs;

// final Rx<SingleValueDropDownController> selectedGender = SingleValueDropDownController().obs;
  final Rx<SingleValueDropDownController> citycontroller =
      SingleValueDropDownController().obs;
  final Rx<SingleValueDropDownController> districtcontroller =
      SingleValueDropDownController().obs;
  final Rx<SingleValueDropDownController> statecontroller =
      SingleValueDropDownController().obs;
  final Rx<SingleValueDropDownController> Familymsmr =
      SingleValueDropDownController().obs;

  final Rx<TextEditingController> dobFamilyController =
      TextEditingController().obs;
  final Rx<TextEditingController> ageFamilyController =
      TextEditingController().obs;

  final Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;
  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;

  var regmodel = Registermodel().obs;
  var regmodeldata = Registermodel().message;
  var isLoading = false.obs;

  Future<bool> registerApi(
      String msmr,
      String patientname,
      Uint8List profileImage,
      String contactNum,
      String emailId,
      String dob,
      String age,
      String gender,
      String adharnum,
      String address,
      String location,
      String pincode,
      String city,
      String distrit,
      String state,
      String pass,
      String confmpass) async {
    print('''
                    Patient Details:
                    Name: $patientname
                    Contact Number: $contactNum
                    Email ID: $emailId
                    Date of Birth: $dob
                    Age: $age
                    Gender: $gender
                    Aadhar Number: $adharnum
                    Address: $address
                    Location: $location
                    Pincode: $pincode
                    City: $city
                    District: $distrit
                    State: $state
                    Password: $pass
                    Confirm Password: $confmpass
                    Profile Image Length (bytes): ${profileImage.length}
                    print:${bb}
                    print:${dob}
                    print:${age}
                    print:${gender}''');
    try {
      isLoading.value = true;
      const apiUrl = ApiendPoints.maniurl + ApiendPoints.register;
      const apiToken = ApiendPoints.apiToken;

      print(apiUrl);

      String formattedDob = dob;
      try {
        final inputFormat = DateFormat('dd/MM/yyyy');
        final outputFormat = DateFormat('yyyy-MM-dd');
        formattedDob = outputFormat.format(inputFormat.parse(dob));
      } catch (e) {
        print('DOB format error: $e');
      }
      var reqData = http.MultipartRequest("POST", Uri.parse(apiUrl))
        ..fields["api_key"] = apiToken
        ..fields["mrms"] = msmr
        ..fields["p_name"] = patientname
        ..fields["mobile_no"] = contactNum.toString()
        ..fields["emil"] = emailId
        ..fields["dob"] = formattedDob
        ..fields["age"] = age
        ..fields["gender"] = gender
        ..fields["aadhar_no"] = adharnum.replaceAll(' ', '')
        ..fields["address"] = address
        ..fields["location"] = location
        ..fields["pincode"] = pincode.toString()
        ..fields["city"] = city
        ..fields["district"] = distrit
        ..fields["state"] = state
        ..fields["pass"] = pass
        ..fields["confirm_pss"] = confmpass;

      reqData.files.add(
        http.MultipartFile.fromBytes(
          "patient_profile",
          profileImage,
          filename: "profile.jpg",
        ),
      );
      // Add image
      reqData.files.add(
        http.MultipartFile.fromBytes(
          "patient_profile",
          profileImage,
          filename: "profile.jpg",
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      String convertDateFormat(String dateStr) {
        final inputFormat = DateFormat('dd-MM-yyyy');
        final outputFormat = DateFormat('yyyy-MM-dd');
        final date = inputFormat.parse(dateStr);
        return outputFormat.format(date);
      }

      // Dynamically add relationship fields
      for (int i = 0; i < bb.length; i++) {
        reqData.fields["relationships[$i][r_jimble_id]"] = bb[i]['r_jimble_id'];
        reqData.fields["relationships[$i][relationship]"] =
            bb[i]['relationship'];
        reqData.fields["relationships[$i][mrms]"] = bb[i]['mrms'];
        reqData.fields["relationships[$i][familymembername]"] =
            bb[i]['familymembername'];
        reqData.fields["relationships[$i][dob]"] = bb[i]['dob'];
        reqData.fields["relationships[$i][age]"] = bb[i]['age'];
        reqData.fields["relationships[$i][gender]"] = bb[i]['gender'];
        reqData.fields["relationships[$i][aadhar_no]"] = bb[i]['aadhar_no'];

        if (bb[i]['profile_img'] != null) {
          try {
            if (bb[i]['profile_img'] is String) {
              // Case 1: Handle file path (String)
              final filePath = bb[i]['profile_img'].toString();
              if (filePath.trim().isNotEmpty) {
                final file = File(filePath);
                if (await file.exists()) {
                  final bytes = await file.readAsBytes();
                  reqData.files.add(
                    http.MultipartFile.fromBytes(
                      "profile_img_$i",
                      bytes,
                      filename: "profile_img_$i.png",
                    ),
                  );
                  print("Image added from path: $filePath");
                } else {
                  print("File not found at path: $filePath");
                }
              }
            } else if (bb[i]['profile_img'] is List<int> ||
                bb[i]['profile_img'] is Uint8List) {
              // Case 2: Handle raw bytes (Uint8List/List<int>)
              final bytes = bb[i]['profile_img'] as Uint8List;
              reqData.files.add(
                http.MultipartFile.fromBytes(
                  "profile_img_$i",
                  bytes,
                  filename: "profile_img_$i.png",
                ),
              );
              print("Image added from raw bytes");
            }
          } catch (e) {
            print("Error uploading image: $e");
          }
        } else {
          print("No profile image provided for index $i");
        }
      }
      print("enter xxxxxxxxxxxxxxxxxxxxxxxxx");
      var response = await reqData.send();

      print("Response Status Code: ${response.statusCode}");
      print(profileImage);
      print("enter 1");
      var responseData = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        print("enter 2");

        var deceoderesponse = json.decode(responseData);
        final regmodeldata = Registermodel.fromJson(deceoderesponse);
        if (regmodeldata.status == true) {
          print("enter 3");
          print("modelres${regmodeldata.pId}");
          print(regmodeldata.pId);
          pid.value = regmodeldata.pId.toString();
          Get.snackbar(
            "Register",
            regmodeldata.message.toString(),
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          // clearFormFields();
          return true;
        } else {
          Get.snackbar(
            messageText: Text(
              regmodeldata.message.toString(),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            "Alert",
            "",
            colorText: Colors.black,
            backgroundColor: Top,
          );
          print("jffyiiuiooui$regmodeldata.message");
          return false;
        }
      } else {
        print("enter 4");
        final errorData = await response.stream.bytesToString(); // Read ONCE
        print("Response Headers: ${response.headers}");
        print('Error Data: $errorData');

        print("Error Response: $errorData");
        print("modelres${regmodel.value.status}");
        print("mess${regmodel.value.message}");
        print("modelres${regmodel.value.pId}");
        print("ddddddddddddddddddddddddddddddd ${msmr}");
        return false;
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
      return false;
      print(E);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifiedapi(String otpcontroller) async {
    try {
      final apiUrl = ApiendPoints.maniurl + ApiendPoints.register;
      print(pid);
      print("PID: ${pid.value}");

      var reqData = {
        "api_key": "Jimble@123",
        "verify_otp": true,
        "p_id": pid.value,
        "otp": otpcontroller
      };
      print("enter2 verified");

      var respones = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(reqData),
      );

      print("enter3 verified");
      print("Raw response body: ${respones.body}");

      if (respones.statusCode == 200) {
        print("enter4 verified");
        final responseData = jsonDecode(respones.body);
        final modelTest = Verifiedmodel.fromJson(responseData);

        if (modelTest.status == true) {
          otpController.value.clear();
          Get.to(Accountcreated(JIDI: modelTest.jimbleId.toString()),
              transition: Transition.fade);
          print("enter5 verified");
          verified.value = modelTest;
          print(verified.value!.jimbleId);
          print(modelTest.status);
          print(modelTest.message);
        } else {
          print("enter6 verified");
          print("Status: ${modelTest.status}");
          print("Message: ${modelTest.message}");
          print("Jimble ID: ${modelTest.jimbleId}");
        }
      } else {
        print("HTTP Error: ${respones.statusCode}");
      }
    } catch (e) {
      print("Exception occurred: $e");
    }
  }

  Future<void> resendapi() async {
    try {
      final apiUrl = ApiendPoints.maniurl + ApiendPoints.register;
      print("enter1 resend ");
      var reqData = {
        "api_key": "Jimble@123",
        "resend_otp": true,
        "p_id": pid.value
      };
      print("enter2 resend ");
      var url = Uri.parse(apiUrl);
      var respones = await http.post(url, body: jsonEncode(reqData));
      print("enter3 resend ");
      print(respones);
      if (respones.statusCode == 200) {
        print("enter4 resend ");
        final rdelete = jsonDecode(respones.body);
        var rdelete2 = ResentModel.fromJson(rdelete);
        if (rdelete2.status == true) {
          resend.value = rdelete2;

          print(rdelete2.status);
          print(rdelete2.message);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void clearFormFields() {
    // Reset form fields
    nameController.value.clear();
    contactController.value.clear();
    emailController.value.clear();
    dobController.value.clear();
    ageController.value.clear();
    aadharController.value.clear();
    addressController.value.clear();
    genderController.value.clear();
    locationController.value.clear();
    pinCodeController.value.clear();
    dobFamilyController.value.clear();
    ageFamilyController.value.clear();
    passwordController.value.clear();
    confirmPasswordController.value.clear();

    // Reset dropdowns
    msmr.value = SingleValueDropDownController();
    normalmrs.value = SingleValueDropDownController();
    citycontroller.value = SingleValueDropDownController();
    districtcontroller.value = SingleValueDropDownController();
    statecontroller.value = SingleValueDropDownController();
    Familymsmr.value = SingleValueDropDownController();

    // Optionally reset the form key too (if you want to reset validation state)
    _formKey.value = GlobalKey<FormState>();

    clearFamilyData();
  }
}
