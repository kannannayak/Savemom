// ignore_for_file: unused_field, non_constant_identifier_names, unused_label, file_names, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace, empty_statements

import 'dart:io';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:savemom/Register/Controller/Contorller.dart';
import '../Color.dart';
import 'package:intl/intl.dart';
import '../JimblePrivacyPolicy/JimblePrivacyPolicy.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isLoading = false;
  final RegisterContorller registerContorller = Get.put(RegisterContorller());
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String? _imageName;
  String? _aadharImageName;
  String? _CMRegImageName;
  String? _selectedTitle;
  bool isfamilyClicked = false;
  final TextEditingController mm = TextEditingController();
  String? _selectedGender;
  //Jimble policies and terms
  bool isChecked = false;
  //Password
  bool _obscurePassword = true;
  // Confirm Password
  bool _obscureConfirmPassword = true;
  String? selectaccont;
  // DropDown
  final FocusNode cityFocusNode = FocusNode();
  final FocusNode stateFocusNode = FocusNode();
  final FocusNode districtFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();

  void _clearImage() {
    setState(() {
      selectedImage = null;
      _imageProfileName = null;
    });
  }

  //image Profile picker
  final ImagePicker _pickerProfile = ImagePicker();
  File? selectedImage;
  String? _imageProfileName;
  Uint8List? imagesbytes;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _pickerProfile.pickImage(source: source);

    if (pickedFile != null) {
      File selectedImage = File(pickedFile.path);
      Uint8List imge = await selectedImage.readAsBytes();
      setState(() {
        imagesbytes = imge;

        _imageProfileName = pickedFile.name;
        print("imagebytes${imagesbytes}");
      });
    }
  }

  //image FamilyProfile picker
  final ImagePicker _pickerFamilyProfile = ImagePicker();
  File? selectedFamilyImage;
  String? _imageFamilyProfileName;
  Uint8List? imagesbytesFamily;

  bool isClicked = false;

  bool hasReadPolicy = false;

  void _clearFamilyImage() {
    setState(() {
      selectedFamilyImage = null;
      _imageFamilyProfileName = null;
    });
  }

  //Profile Image
  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text("Take a Photo"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: Text("Choose From Gallery".tr),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String? newname;
  Future<void> pickFamilyImage(ImageSource source, int index) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final name = pickedFile.name;

      imagesbytesFamily = bytes;
      _imageFamilyProfileName = name;
      registerContorller.familys[index]["profile_img"]?.value =
          imagesbytesFamily;
      registerContorller.familys[index]["profile_img_name"]?.value =
          _imageFamilyProfileName.toString();
      newname = registerContorller.familys[index]["profile_img_name"]?.value;
      print("newname$newname");
    }
  }

  void _showImageSourceDialog1(int index) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text("Take a Photo"),
                onTap: () {
                  Navigator.pop(context);
                  pickFamilyImage(ImageSource.camera, index);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: Text("Choose From Gallery".tr),
                onTap: () {
                  Navigator.pop(context);
                  pickFamilyImage(ImageSource.gallery, index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String? tt;
  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final formattedDate =
          "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";

      registerContorller.dobController.value.text = formattedDate;

      int age = DateTime.now().year - pickedDate.year;
      if (DateTime.now().month < pickedDate.month ||
          (DateTime.now().month == pickedDate.month &&
              DateTime.now().day < pickedDate.day)) {
        age--;
      }
      registerContorller.ageController.value.text = age.toString();
    }
  }

  Future<void> _submitForm() async {
    if (registerContorller.formKey.value.currentState!.validate()) {
      registerContorller.formKey.value.currentState!.save();
      // _showOtpDialog(); // Optional: Save the form state if needed
      print("Form Submitted Successfully");
      registerContorller.bb = registerContorller.getFamily();
      if (isClicked && hasReadPolicy) {
        print("Filtered family: ${registerContorller.bb}");
        await callApi();
        // print("kkkkkkkkkkkkkkk${registerContorller.regmodeldata}");

        print(
          "ddddddddddddddddddddddddddddddd ${registerContorller.msmr.value.dropDownValue?.name}",
        );
        print("Name: ${registerContorller.nameController.value.text}");
        print("Contact: ${registerContorller.contactController.value.text}");
        print("Email: ${registerContorller.emailController.value.text}");
        print("DOB: ${registerContorller.dobController.value.text}");
        print("Age: ${registerContorller.ageController.value.text}");
        print("gender: ${registerContorller.genderController.value.text}");
        print("Aadhar: ${registerContorller.aadharController.value.text}");
        print("Address: ${registerContorller.addressController.value.text}");
        print("location: ${registerContorller.locationController.value.text}");
        print("pincode: ${registerContorller.pinCodeController.value.text}");
        print("city: ${registerContorller.citycontroller.value.toString()}");
        print(
          "distrit: ${registerContorller.districtcontroller.value.toString()}",
        );
        print(
          "distrit: ${registerContorller.districtcontroller.value.dropDownValue?.name}",
        );
        print("state: ${registerContorller.statecontroller.value.toString()}");
        print("pass: ${registerContorller.passwordController.value.text}");
        print(
          "confmpass: ${registerContorller.confirmPasswordController.value.text}",
        );
        //  print("Relationship: ${registerContorller.familymembername.value.toString()}");
        print(
          "familymember: ${registerContorller.passwordController.value.text}",
        );
        // print(
        //     "familymemberDob: ${registerContorller.dobFamilyController.value.toString()}");
        // print(
        //     "familymemberAeg: ${registerContorller.ageFamilyController.value.text}");

        if (!isChecked) {
          //  Get.snackbar(
          //     "Error",
          //     "You must agree to the terms before submitting the form.",
          //     backgroundColor: Colors.red,
          //     colorText: Colors.white,
          //   );
          return;
        }
      } else {
        print("Form Submitted please read jimble ");
      }
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText: "Please fill all the required fields",
        backgroundColor: Colors.white,
        titleStyle: const TextStyle(color: Colors.red),
        middleTextStyle: const TextStyle(color: Colors.red),
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("OK"),
        ),
        cancel: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
        ),
      );
    }
  }

  String? date1;
  Future<void> _selectDateFamily() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      date1 = pickedDate.toString();
      String formattedDate =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      int age = DateTime.now().year - pickedDate.year;
      if (DateTime.now().month < pickedDate.month ||
          (DateTime.now().month == pickedDate.month &&
              DateTime.now().day < pickedDate.day)) {
        age--;
      }

      setState(() {
        registerContorller.dobFamilyController.value.text = formattedDate;
        registerContorller.ageFamilyController.value.text = age.toString();
      });
    }
  }

  Uint8List emptyImage = Uint8List(0);

  callApi() async {
    print("call api calling entry");
    if (imagesbytes != null) {
      print("imagepatient $imagesbytes");
    } else {
      print("imagesbytes is null");
    }

    // print(
    // "imagefalimyXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX${imagesbytesFamily!}");
    final bool valuereg = await registerContorller.registerApi(
      registerContorller.normalmrs.value.dropDownValue?.name ?? "",
      registerContorller.nameController.value.text,
      imagesbytes ?? emptyImage,
      registerContorller.contactController.value.text,
      registerContorller.emailController.value.text,
      registerContorller.dobController.value.text,
      registerContorller.ageController.value.text,
      registerContorller.genderController.value.text,
      registerContorller.aadharController.value.text,
      registerContorller.addressController.value.text,
      registerContorller.locationController.value.text,
      registerContorller.pinCodeController.value.text,
      registerContorller.citycontroller.value.dropDownValue?.name ?? '',
      registerContorller.districtcontroller.value.dropDownValue?.name ?? '',
      registerContorller.statecontroller.value.dropDownValue!.name,
      registerContorller.passwordController.value.text,
      registerContorller.confirmPasswordController.value.text,
    );
    if (valuereg == true) {
      _showOtpDialog();
    }
  }

  // Otp Pin Input
  void _showOtpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Enter OTP".tr,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Jaldi', fontSize: 25),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Pinput(
                controller: registerContorller.otpController.value,
                length: 4,
                keyboardType: TextInputType.number,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ), // Text color set to black
                  decoration: BoxDecoration(
                    color: Patent_PinInput, // Background color set to gray
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Patent_Black,
                    ), // Optional: border color
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  registerContorller.resendapi();
                }, // Resend OTP logic
                child: Text(
                  "Resend?".tr,
                  style: TextStyle(
                    fontSize: 18,
                    color: Patent_Black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: InkWell(
                onTap: () {
                  registerContorller.verifiedapi(
                    registerContorller.otpController.value.text,
                  );
                  print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
                },
                child: Container(
                  width: 166.14,
                  height: 48.73,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(offset: Offset(0, 4), blurRadius: 3)],
                    color: Top,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Patent_Black, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      "Verify".tr,
                      style: TextStyle(color: Patent_secondory, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ), // Optional: round the corners of the dialog box
            side: BorderSide(
              color: Patent_Black,
            ), // Black border for the dialog box
          ),
          backgroundColor: Colors.white, // White background for the AlertDialog
        );
      },
    );
  }

  @override
  void dispose() {
    districtFocusNode.dispose();
    cityFocusNode.dispose();
    stateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setScreenSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // color: Top,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;

            return Obx(
              () => SingleChildScrollView(
                child: Form(
                  key: registerContorller.formKey.value,
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.4,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Container(
                              height: screenHeight / 2.9,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Top,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(
                                    screenWidth * 0.9,
                                  ),
                                  bottomLeft: Radius.circular(
                                    screenWidth * 0.4,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: height * 0.020,
                              right: width * 0.28,
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
                                "Register".tr,
                                style: TextStyle(
                                  fontFamily: "Jaldi",
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: height * 0.090),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Savemom Declaration".tr,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Jaldi",
                              ),
                            ),
                            shbox5,
                            Text(
                              "Your personal Information will be kept confidential"
                                  .tr,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "JaldiRegular",
                              ),
                            ),
                            shbox20,

                            // Upload Profile Image
                            Text(
                              "  Upload Profile Image".tr,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: _showImageSourceDialog,
                              child: Container(
                                width: width * 0.90,
                                height: 50,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Patent_secondory,
                                  border: Border.all(color: Patent_Black),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _imageProfileName ??
                                            "Choose From Gallery".tr,
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          color: _imageProfileName != null
                                              ? Colors.black
                                              : Patent_HintColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (_imageProfileName != null)
                                      GestureDetector(
                                        onTap: _clearImage,
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                      ),
                                    const SizedBox(width: 10),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.upload,
                                        color: Colors.blue,
                                      ),
                                      onPressed: _showImageSourceDialog,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Name Input
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "* ",
                                    style: GoogleFonts.inter(
                                      color: Colors.red,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Name as in Aadhar Card".tr,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      120, // Slightly increased for better spacing
                                  child: DropDownTextField(
                                    controller:
                                        registerContorller.normalmrs.value,
                                    textFieldDecoration: InputDecoration(
                                      hintText: "select".tr,
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: const BorderSide(
                                          color: Patent_Black,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: const BorderSide(
                                          color: Patent_Black,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: const BorderSide(
                                          color: Patent_Black,
                                        ),
                                      ),
                                    ),
                                    dropDownList: const [
                                      DropDownValueModel(
                                        name: 'Mr',
                                        value: "Mr",
                                      ),
                                      DropDownValueModel(
                                        name: 'Ms',
                                        value: "Ms",
                                      ),
                                    ],
                                    onChanged: (value) {
                                      //     _selectedTitle = value;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Mr/Ms is required";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextFormField(
                                    controller:
                                        registerContorller.nameController.value,
                                    decoration: InputDecoration(
                                      hintText: "Enter Your Name".tr,
                                      hintStyle: GoogleFonts.jaldi(
                                        color: Patent_HintColor,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: const BorderSide(
                                          color: Patent_Black,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: const BorderSide(
                                          color: Patent_Black,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: const BorderSide(
                                          color: Patent_Black,
                                        ),
                                      ),
                                    ),
                                    validator: (value) => value!.isEmpty
                                        ? "Name is required"
                                        : null,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // Contact Number
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "* ",
                                    style: GoogleFonts.inter(
                                      color: Colors.red,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Contact Number".tr,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller:
                                  registerContorller.contactController.value,
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              decoration: InputDecoration(
                                hintText: "Enter Valid Mobile Number".tr,
                                hintStyle: GoogleFonts.inter(
                                  color: Patent_HintColor,
                                ),
                                filled: true,
                                fillColor: Patent_secondory,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              validator: (value) => value!.isEmpty
                                  ? "Contact number is required"
                                  : null,
                            ),
                            // const SizedBox(height: 10),

                            // Email ID
                            Text.rich(
                              TextSpan(
                                children: [
                                  // TextSpan(
                                  //     text: "* ",
                                  //     style: TextStyle(
                                  //         color: Colors.red, fontSize: 18)),
                                  TextSpan(
                                    text: "  Email ID".tr,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller:
                                  registerContorller.emailController.value,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "Enter Valid Email".tr,
                                hintStyle: GoogleFonts.inter(
                                  color: Patent_HintColor,
                                ),
                                filled: true,
                                fillColor: Patent_secondory,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              // validator: (value) =>
                              //     value!.isEmpty ? "Email is required" : null,
                            ),
                            const SizedBox(height: 20),

                            // Date of Birth, Age, and Gender in a Single Row
                            Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  // Date of Birth Field
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "* ",
                                                  style: GoogleFonts.inter(
                                                    fontSize: 18,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "DOB".tr, //Date of Birth
                                                  style: GoogleFonts.inter(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          child: TextFormField(
                                            controller: registerContorller
                                                .dobController
                                                .value,
                                            decoration: InputDecoration(
                                              hintText: "DD/MM/YYYY",
                                              hintStyle: GoogleFonts.inter(
                                                color: Patent_HintColor,
                                              ),
                                              filled: true,
                                              fillColor: Patent_secondory,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              suffixIcon: IconButton(
                                                icon: const Icon(
                                                  Icons.calendar_today,
                                                ),
                                                onPressed: _selectDate,
                                              ),
                                            ),
                                            validator: (value) => value!.isEmpty
                                                ? "Date of Birth is required"
                                                : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  // Age Field with Label
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            "Age".tr,
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          child: TextFormField(
                                            controller: registerContorller
                                                .ageController
                                                .value,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(5),
                                              hintText: "Age".tr,
                                              hintStyle: GoogleFonts.inter(
                                                color: Patent_HintColor,
                                              ),
                                              filled: true,
                                              fillColor: Patent_secondory,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                            validator: (value) => value!.isEmpty
                                                ? "Age is required"
                                                : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 5),

                                  // Gender Dropdown
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Gender
                                        Container(
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "* ",
                                                  style: GoogleFonts.inter(
                                                    color: Colors.red,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "Gender".tr,
                                                  style: GoogleFonts.inter(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          child:
                                              DropdownButtonFormField<String>(
                                                value:
                                                    registerContorller
                                                        .genderController
                                                        .value
                                                        .text
                                                        .isNotEmpty
                                                    ? registerContorller
                                                          .genderController
                                                          .value
                                                          .text
                                                    : null,
                                                // value: _selectedGender,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          50,
                                                        ),
                                                  ),
                                                ),

                                                items: const [
                                                  DropdownMenuItem(
                                                    value: 'Male',
                                                    child: Text("Male"),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'Female',
                                                    child: Text("Female"),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'Oters',
                                                    child: Text("Others"),
                                                  ),
                                                ],
                                                onChanged: (value) {
                                                  registerContorller
                                                          .genderController
                                                          .value
                                                          .text =
                                                      value!;
                                                  // setState(() {
                                                  //   _selectedGender = value;
                                                  // });
                                                },
                                                validator: (value) =>
                                                    value == null
                                                    ? "Gender is required"
                                                    : null,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Aadhar Number Input
                            Text.rich(
                              TextSpan(
                                children: [
                                  // TextSpan(
                                  //     text: "* ",
                                  //     style: TextStyle(
                                  //         color: Colors.red, fontSize: 18)),
                                  TextSpan(
                                    text: "  Aadhar Number".tr,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Patent_Black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller:
                                  registerContorller.aadharController.value,
                              keyboardType: TextInputType.number,
                              maxLength:
                                  14, // Including spaces (XXXX XXXX XXXX)
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(
                                  14,
                                ), // Limit to 14 characters (including spaces)
                                AadharInputFormatter(), // Custom formatter for spacing
                              ],
                              decoration: InputDecoration(
                                hintText: "Enter Aadhar Number".tr,
                                hintStyle: GoogleFonts.inter(
                                  color: Patent_HintColor,
                                ),
                                filled: true,
                                fillColor: Patent_secondory,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return "Aadhar number is required";
                              //   } else if (!RegExp(r'^\d{4} \d{4} \d{4}$')
                              //       .hasMatch(value)) {
                              //     return "Enter a valid 12-digit Aadhar number";
                              //   }
                              //   return null;
                              // },
                            ),

                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "* ",
                                    style: GoogleFonts.inter(
                                      color: Colors.red,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Address".tr,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),

                            TextFormField(
                              controller:
                                  registerContorller.addressController.value,
                              decoration: InputDecoration(
                                hintText: "Enter Address".tr,
                                hintStyle: GoogleFonts.inter(
                                  color: Patent_HintColor,
                                ),
                                filled: true,
                                fillColor: Patent_secondory,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              validator: (value) =>
                                  value!.isEmpty ? "Address is required" : null,
                            ),
                            const SizedBox(height: 10),

                            Container(
                              // color: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    // Location
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "* ",
                                                  style: GoogleFonts.inter(
                                                    color: Colors.red,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "Location".tr,
                                                  style: GoogleFonts.inter(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          TextFormField(
                                            controller: registerContorller
                                                .locationController
                                                .value,
                                            decoration: InputDecoration(
                                              hintText: "Enter Location".tr,
                                              hintStyle: GoogleFonts.inter(
                                                color: Patent_HintColor,
                                              ),
                                              filled: true,
                                              fillColor: Patent_secondory,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                            validator: (value) => value!.isEmpty
                                                ? "Location is required"
                                                : null,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // Gender Dropdown
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Area Pin code
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "* ",
                                                  style: GoogleFonts.inter(
                                                    color: Colors.red,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "Pincode".tr, //Area
                                                  style: GoogleFonts.inter(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          TextFormField(
                                            controller: registerContorller
                                                .pinCodeController
                                                .value,
                                            keyboardType:
                                                TextInputType.numberWithOptions(),
                                            decoration: InputDecoration(
                                              hintText: "Enter Pin code".tr,
                                              hintStyle: GoogleFonts.inter(
                                                color: Patent_HintColor,
                                              ),
                                              filled: true,
                                              fillColor: Patent_secondory,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty)
                                                return "Pin code is required";
                                              if (value.length != 6)
                                                return "Enter a valid 6-digit PIN code";
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "City/Town/Village".tr,
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: DropdownSearch<DropDownValueModel>(
                                  key: ValueKey(
                                    'city_dropdown',
                                  ), // Optional: for widget identification
                                  selectedItem: registerContorller
                                      .citycontroller
                                      .value
                                      .dropDownValue,
                                  items:
                                      (
                                        String filter,
                                        LoadProps? loadProps,
                                      ) async {
                                        // Client-side filtering of cityList based on search query
                                        if (filter.isEmpty) {
                                          return registerContorller.cityList;
                                        }
                                        return registerContorller.cityList
                                            .where(
                                              (item) => item.name
                                                  .toLowerCase()
                                                  .contains(
                                                    filter.toLowerCase(),
                                                  ),
                                            )
                                            .toList();
                                      },
                                  itemAsString: (DropDownValueModel? item) =>
                                      item?.name ?? '',
                                  compareFn:
                                      (
                                        DropDownValueModel? a,
                                        DropDownValueModel? b,
                                      ) =>
                                          a?.value ==
                                          b?.value, // Compare based on the 'value' field
                                  decoratorProps: DropDownDecoratorProps(
                                    decoration: InputDecoration(
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      hintText: "Choose City/Town/Village".tr,
                                      hintStyle: TextStyle(
                                        color: Color(0xffD9D9D9),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                  popupProps: PopupProps.menu(
                                    showSearchBox:
                                        true, // Enable search functionality
                                    searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                        hintText: "Search City/Town/Village",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    menuProps: const MenuProps(
                                      backgroundColor: Colors.white,
                                    ),
                                    fit: FlexFit.tight,
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          300, // Limit max height (adjust as needed)
                                    ),
                                  ),
                                  // validator: (DropDownValueModel? value) =>
                                  //     value == null
                                  //         ? "*please select a city/town/village"
                                  //         : null,
                                  onChanged: (DropDownValueModel? val) {
                                    if (val != null && val.value != null) {
                                      try {
                                        registerContorller
                                                .citycontroller
                                                .value
                                                .dropDownValue =
                                            val;
                                        registerContorller
                                            .selectedCityId
                                            .value = int.parse(
                                          val.value.toString(),
                                        );
                                        registerContorller.districtList
                                            .clear(); // Clear previous district list
                                        registerContorller
                                                .districtcontroller
                                                .value
                                                .dropDownValue =
                                            null; // Clear district controller
                                        print("City Dropdown onChanged:");
                                        print(
                                          "Selected City: ${val.name} (ID: ${val.value})",
                                        );
                                        print(
                                          "selectedCityId: ${registerContorller.selectedCityId.value}",
                                        );
                                        print(
                                          "citycontroller.dropDownValue: ${registerContorller.citycontroller.value.dropDownValue?.name} (Value: ${registerContorller.citycontroller.value.dropDownValue?.value})",
                                        );
                                        print(
                                          "cityList length: ${registerContorller.cityList.length}",
                                        );
                                        print(
                                          "districtList length: ${registerContorller.districtList.length}",
                                        );
                                        print(
                                          "stateList length: ${registerContorller.stateList.length}",
                                        );
                                        print(
                                          "statecontroller.dropDownValue: ${registerContorller.statecontroller.value.dropDownValue?.name ?? 'None'}",
                                        );
                                        registerContorller.fetchDistrict(
                                          registerContorller
                                              .selectedCityId
                                              .value,
                                        );
                                        cityFocusNode.unfocus();
                                      } catch (e, stackTrace) {
                                        print(
                                          "Error in city dropdown onChanged: $e",
                                        );
                                        print(stackTrace);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            //District
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "District".tr,
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: DropdownButtonFormField<DropDownValueModel>(
                                  value: registerContorller
                                      .districtcontroller
                                      .value
                                      .dropDownValue,
                                  decoration: InputDecoration(
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    hintText: "Choose District".tr,
                                    hintStyle: TextStyle(
                                      color: Color(0xffD9D9D9),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  items: registerContorller.districtList.map((
                                    DropDownValueModel item,
                                  ) {
                                    return DropdownMenuItem<DropDownValueModel>(
                                      value: item,
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (DropDownValueModel? val) {
                                    if (val != null && val.value != null) {
                                      try {
                                        registerContorller
                                                .districtcontroller
                                                .value
                                                .dropDownValue =
                                            val;
                                        // Clear state controller
                                        districtFocusNode.unfocus();
                                      } catch (e, stackTrace) {
                                        print(
                                          "Error in district dropdown onChanged: $e",
                                        );
                                        print(stackTrace);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "* ",
                                        style: GoogleFonts.inter(
                                          color: Colors.red,
                                          fontSize: 18,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "State".tr,
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            //State
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: DropdownSearch<DropDownValueModel>(
                                  key: ValueKey('state_dropdown'),
                                  selectedItem: registerContorller
                                      .statecontroller
                                      .value
                                      .dropDownValue,
                                  items:
                                      (
                                        String filter,
                                        LoadProps? loadProps,
                                      ) async {
                                        if (filter.isEmpty) {
                                          return registerContorller.stateList;
                                        }
                                        return registerContorller.stateList
                                            .where(
                                              (item) => item.name
                                                  .toLowerCase()
                                                  .contains(
                                                    filter.toLowerCase(),
                                                  ),
                                            )
                                            .toList();
                                      },
                                  itemAsString: (DropDownValueModel? item) =>
                                      item?.name ?? '',
                                  compareFn:
                                      (
                                        DropDownValueModel? a,
                                        DropDownValueModel? b,
                                      ) => a?.value == b?.value,
                                  decoratorProps: DropDownDecoratorProps(
                                    decoration: InputDecoration(
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      hintText: "Choose State".tr,
                                      hintStyle: TextStyle(
                                        color: Color(0xffD9D9D9),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                        hintText: "Search State",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    fit: FlexFit.tight,
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          250, // Match original menuMaxHeight
                                    ),
                                    listViewProps: ListViewProps(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 4,
                                      ),
                                    ),
                                    menuProps: const MenuProps(
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  validator: (DropDownValueModel? value) =>
                                      value == null
                                      ? "*please select a state"
                                      : null,
                                  onChanged: (DropDownValueModel? val) {
                                    try {
                                      if (val != null) {
                                        registerContorller
                                                .statecontroller
                                                .value
                                                .dropDownValue =
                                            val;
                                        print("Selected State: ${val.value}");
                                        stateFocusNode.unfocus();
                                      }
                                    } catch (e, stackTrace) {
                                      print(
                                        "Error in state dropdown onChanged: $e",
                                      );
                                      print(stackTrace);
                                    }
                                  },
                                ),
                              ),
                            ),

                            shbox20,
                            Text(
                              "Family Members".tr,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            shbox5,
                            IconButton(
                              icon: Container(
                                width: width * 0.88,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Add a Family Member",
                                    style: GoogleFonts.inter(
                                      color: Patent_secondory,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  isfamilyClicked = true;
                                  if (registerContorller.familys.isEmpty) {
                                    registerContorller.addFamilyMembers();
                                  }
                                });
                              },
                            ),
                            shbox20,
                            isfamilyClicked == true
                                ? Container(
                                    child: SingleChildScrollView(
                                      padding: EdgeInsets.all(3),
                                      child: Obx(
                                        () => Column(
                                          children: [
                                            ...registerContorller.familys.asMap().entries.map((
                                              entry,
                                            ) {
                                              int index = entry.key;
                                              var family = entry.value;

                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: buildInputField(
                                                          "Relationship".tr,
                                                          family["relationship"]!,
                                                          width,
                                                          isRequired: true,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                top: 15,
                                                              ),
                                                          child: Container(
                                                            width: 40,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                    Radius.circular(
                                                                      25,
                                                                    ),
                                                                  ),
                                                            ),
                                                            child: Icon(
                                                              Icons.add,
                                                              size: 20,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          registerContorller
                                                              .addInitialFamilyMembers();
                                                          print(
                                                            registerContorller
                                                                .bb,
                                                          );

                                                          if (registerContorller
                                                                  .familys
                                                                  .isNotEmpty &&
                                                              index <
                                                                  registerContorller
                                                                      .familys
                                                                      .length) {
                                                            print(
                                                              "imagename: ${registerContorller.familys[index]["profile_img_name"]}",
                                                            );
                                                          } else {
                                                            print(
                                                              "familys list is empty or index out of range",
                                                            );
                                                          }
                                                        },
                                                      ),
                                                      IconButton(
                                                        icon: Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                top: 15,
                                                              ),
                                                          child: Container(
                                                            width: 40,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                    Radius.circular(
                                                                      25,
                                                                    ),
                                                                  ),
                                                            ),
                                                            child: Icon(
                                                              Icons
                                                                  .remove_circle,
                                                              size: 20,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () =>
                                                            registerContorller
                                                                .removeFamilyMembers(
                                                                  index,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                  buildInputFieldFamilym(
                                                    family["familyMembersLabel"],
                                                    family["familymembername"]!,
                                                    width,
                                                    isRequired: true,
                                                  ),
                                                  shbox10,
                                                  Container(
                                                    // color: Colors.red,
                                                    child: Row(
                                                      children: [
                                                        // DOB and Age Section
                                                        // Date of Birth Field
                                                        Expanded(
                                                          flex: 4,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text.rich(
                                                                TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text:
                                                                          "* ",
                                                                      style: GoogleFonts.inter(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: "DOB"
                                                                          .tr,
                                                                      style: GoogleFonts.inter(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              TextFormField(
                                                                controller: TextEditingController(
                                                                  text: formatDate(
                                                                    family["dob"]
                                                                        .value,
                                                                  ),
                                                                ),
                                                                readOnly: true,
                                                                decoration: InputDecoration(
                                                                  filled: true,
                                                                  fillColor:
                                                                      Patent_secondory,
                                                                  hintText:
                                                                      "DD/MM/YYYY",
                                                                  suffixIcon: IconButton(
                                                                    icon: Icon(
                                                                      Icons
                                                                          .calendar_today,
                                                                    ),
                                                                    onPressed: () =>
                                                                        _selectDateF(
                                                                          context,
                                                                          index,
                                                                        ),
                                                                  ),
                                                                  border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          50,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        // Age Field
                                                        const SizedBox(
                                                          width: 5,
                                                        ),

                                                        Expanded(
                                                          flex: 2,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Age".tr,
                                                                style: GoogleFonts.inter(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              TextFormField(
                                                                controller: TextEditingController(
                                                                  text:
                                                                      family["age"]
                                                                          ?.value ??
                                                                      '',
                                                                ),
                                                                readOnly: true,
                                                                decoration: InputDecoration(
                                                                  filled: true,
                                                                  fillColor:
                                                                      Patent_secondory,
                                                                  hintText:
                                                                      "Age".tr,
                                                                  border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          50,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),

                                                        // Gender Dropdown
                                                        Expanded(
                                                          flex: 3,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text.rich(
                                                                TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text:
                                                                          "* ",
                                                                      style: GoogleFonts.inter(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: "Gender"
                                                                          .tr,
                                                                      style: GoogleFonts.inter(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              DropDownTextField(
                                                                controller:
                                                                    family["gender"],
                                                                clearOption:
                                                                    true,
                                                                textFieldDecoration: InputDecoration(
                                                                  filled: true,
                                                                  fillColor:
                                                                      Patent_secondory,
                                                                  border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          50,
                                                                        ),
                                                                  ),
                                                                ),
                                                                dropDownList: const [
                                                                  DropDownValueModel(
                                                                    name:
                                                                        'Male',
                                                                    value:
                                                                        'Male',
                                                                  ),
                                                                  DropDownValueModel(
                                                                    name:
                                                                        'Female',
                                                                    value:
                                                                        'Female',
                                                                  ),
                                                                  DropDownValueModel(
                                                                    name:
                                                                        'Other',
                                                                    value:
                                                                        'Other',
                                                                  ),
                                                                ],
                                                                onChanged:
                                                                    (val) {},
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  shbox5,
                                                  buildInputField_aadhar_no(
                                                    "Aadhar Number".tr,
                                                    family["aadhar_no"]!,
                                                    width,
                                                  ),
                                                  buildInputFieldFamilyPhoto(
                                                    "Upload Profile Image".tr,
                                                    registerContorller
                                                        .familys[index]["profile_img_name"]
                                                        ?.value,
                                                    imagesbytesFamily,
                                                    width,
                                                    isRequired: true,
                                                    onPickImage: () =>
                                                        _showImageSourceDialog1(
                                                          index,
                                                        ),
                                                    onClearImage: () {
                                                      registerContorller
                                                              .familys[index]["profile_img"]
                                                              ?.value =
                                                          null;
                                                      registerContorller
                                                              .familys[index]["profile_img_name"]
                                                              ?.value =
                                                          '';
                                                    },
                                                  ),
                                                  const SizedBox(height: 10),
                                                ],
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            const SizedBox(height: 10),

                            Text(
                              "  Enter 4 digit pin".tr,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller:
                                  registerContorller.passwordController.value,
                              obscureText: _obscurePassword,
                              maxLength: 4,
                              decoration: InputDecoration(
                                hintText: "****".tr, //Enter 4 digit Pin
                                hintStyle: GoogleFonts.inter(
                                  color: Patent_HintColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                filled: true,
                                fillColor: Patent_secondory,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a Pin";
                                } else if (value.length < 4) {
                                  return "Pin must be at least 4 characters";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "  Confirm Pin".tr,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: registerContorller
                                  .confirmPasswordController
                                  .value,
                              obscureText: _obscureConfirmPassword,
                              maxLength: 4,
                              decoration: InputDecoration(
                                hintText: "****", //Enter 4 digit Pin
                                hintStyle: GoogleFonts.inter(
                                  color: Patent_HintColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                filled: true,
                                fillColor: Patent_secondory,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureConfirmPassword =
                                          !_obscureConfirmPassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a new Pin";
                                } else if (value.length < 4) {
                                  return "Pin must be at least 4 characters";
                                } else if (value !=
                                    registerContorller
                                        .passwordController
                                        .value
                                        .text) {
                                  return "The Pin does not match the confirmation Pin.";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),
                            Center(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Read ".tr,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          if (registerContorller
                                              .formKey
                                              .value
                                              .currentState!
                                              .validate()) {
                                            bool? agreed = await Get.to<bool>(
                                              () => JimblePrivacyPolicy(),
                                              transition: Transition.fade,
                                            );

                                            if (agreed == true) {
                                              setState(() {
                                                isClicked = true;
                                                hasReadPolicy = true;
                                              });
                                              print("is clicked : $isClicked");
                                              print(
                                                "terms and conditions : $hasReadPolicy",
                                              );
                                            } else {
                                              Get.snackbar(
                                                "Notice",
                                                "You must agree to the policy to proceed.",
                                                backgroundColor: Color(
                                                  0xff197C95,
                                                ),
                                                snackPosition:
                                                    SnackPosition.TOP,
                                              );
                                            }
                                          } else {
                                            // reqAlert();
                                          }
                                        },
                                    ),
                                    TextSpan(
                                      text: "Savemom policy and terms".tr,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19,
                                        fontFamily: 'InterRegular',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Checkbox(
                                  value: isClicked,
                                  onChanged: (bool? value) async {
                                    if (registerContorller
                                        .formKey
                                        .value
                                        .currentState!
                                        .validate()) {
                                      setState(() {
                                        isClicked = value ?? false;
                                        hasReadPolicy = value ?? false;
                                        print("is clicked : $isClicked");
                                        print(
                                          "terms and conditions : $hasReadPolicy",
                                        );
                                      });
                                      if (isClicked) {
                                        bool? mm = await Get.to<bool>(
                                          () => JimblePrivacyPolicy(),
                                          transition: Transition.fade,
                                        );
                                        print(mm);
                                        if (mm == false) {
                                          setState(() {
                                            isClicked = false;
                                            hasReadPolicy = false;
                                          });
                                        }
                                      }
                                    } else {
                                      Get.snackbar(
                                        "Notice",
                                        "You must agree to the policy to proceed.",
                                        backgroundColor: Color(0xff197C95),
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    }
                                  },
                                  activeColor: Colors.black,
                                ),
                                Expanded(
                                  child: Text(
                                    "I have read and hereby agree Savemom policies and terms"
                                        .tr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: "Jaldi",
                                      color: Colors.black,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            shbox20,
                            // Center(
                            //   child: InkWell(
                            //     onTap: () async {
                            //       FocusScope.of(context).unfocus();
                            //       // await _submitForm();
                            //       if (registerContorller
                            //           .formKey.value.currentState!
                            //           .validate()) {
                            //         if (isClicked == true &&
                            //             hasReadPolicy == true) {
                            //           _submitForm();
                            //         } else {
                            //           reqAlert1();
                            //         }
                            //       }
                            //     },
                            //     child: Container(
                            //       width: width * 0.40,
                            //       height: height * 0.060,
                            //       decoration: BoxDecoration(
                            //         boxShadow: [
                            //           BoxShadow(
                            //               offset: Offset(0, 4), blurRadius: 3)
                            //         ],
                            //         color: Patent_secondory,
                            //         borderRadius: BorderRadius.circular(10),
                            //         border: Border.all(
                            //             color: Patent_Black, width: 1),
                            //       ),
                            //       child: Center(
                            //         child: isLoading
                            //             ? SizedBox(
                            //                 width: 20,
                            //                 height: 20,
                            //                 child: Container(
                            //                   child: LoadingAnimationWidget
                            //                       .discreteCircle(
                            //                     color: Top,
                            //                     size: 40,
                            //                   ),
                            //                 ))
                            //             : Text(
                            //                 "Submit".tr,
                            //                 style: GoogleFonts.inter(
                            //                     color: Top, fontSize: 20),
                            //               ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Center(
                              child: InkWell(
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  if (registerContorller
                                      .formKey
                                      .value
                                      .currentState!
                                      .validate()) {
                                    if (isClicked && hasReadPolicy) {
                                      registerContorller.isLoading.value = true;
                                      try {
                                        await _submitForm();
                                      } finally {
                                        registerContorller.isLoading.value =
                                            false;
                                      }
                                    } else {
                                      reqAlert1();
                                    }
                                  } else {
                                    registerContorller.isLoading.value = false;
                                  }
                                },
                                child: Obx(
                                  () => Container(
                                    width: width * 0.40,
                                    height: height * 0.060,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 3,
                                        ),
                                      ],
                                      color: Patent_secondory,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Patent_Black,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: registerContorller.isLoading.value
                                          ? SizedBox(
                                              width: 24,
                                              height: 24,
                                              child:
                                                  LoadingAnimationWidget.discreteCircle(
                                                    color: Top,
                                                    size: 40,
                                                  ),
                                            )
                                          : Text(
                                              "Submit".tr,
                                              style: GoogleFonts.inter(
                                                color: Top,
                                                fontSize: 20,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildInputField(
    String label,
    TextEditingController controller,
    double width, {
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              if (isRequired)
                TextSpan(
                  text: "* ",
                  style: GoogleFonts.inter(color: Colors.red, fontSize: 18),
                ),
              TextSpan(
                text: label,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Patent_Black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: width,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Enter $label",
              hintStyle: GoogleFonts.inter(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget buildInputField_aadhar_no(
    String label,
    TextEditingController controller,
    double width, {
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              if (isRequired)
                TextSpan(
                  text: "* ",
                  style: GoogleFonts.inter(color: Colors.red, fontSize: 18),
                ),
              TextSpan(
                text: label,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Patent_Black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: width,
          child: TextField(
            keyboardType: TextInputType.number,

            maxLength: 14, // Including spaces (XXXX XXXX XXXX)
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(
                14,
              ), // Limit to 14 characters (including spaces)
              AadharInputFormatter(), // Custom formatter for spacing
            ],
            controller: controller,
            decoration: InputDecoration(
              hintText: "Enter $label",
              hintStyle: GoogleFonts.inter(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget buildInputFieldFamilym(
    String label,
    TextEditingController controller,
    double width, {
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              if (isRequired)
                TextSpan(
                  text: "* ",
                  style: GoogleFonts.inter(color: Colors.red, fontSize: 18),
                ),
              TextSpan(
                text: label,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Patent_Black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            SizedBox(
              width: 120, // Slightly increased for better spacing
              child: DropDownTextField(
                controller: registerContorller.msmr.value,
                textFieldDecoration: InputDecoration(
                  hintText: "select".tr,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Patent_Black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Patent_Black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Patent_Black),
                  ),
                ),
                dropDownList: const [
                  DropDownValueModel(name: 'Mr', value: "Mr"),
                  DropDownValueModel(name: 'Ms', value: "Ms"),
                ],
                onChanged: (value) {
                  //     _selectedTitle = value;
                },
              ),
            ),
            swbox5,
            Container(
              width: screenWidth * 0.55,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Name as in Aadhar Card".tr,
                  hintStyle: GoogleFonts.inter(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget buildInputFieldFamilyPhoto(
    String label,
    String? imageName,
    Uint8List? imageBytes,
    double width, {
    required bool isRequired,
    required VoidCallback onPickImage,
    required VoidCallback onClearImage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "  $label",
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: onPickImage, // Use the callback
          child: Container(
            width: width * 0.90,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Patent_secondory,
              border: Border.all(color: Patent_Black),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    imageName ?? "Choose From Gallery".tr,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: imageName != null
                          ? Colors.black
                          : Patent_HintColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (imageName != null)
                  GestureDetector(
                    onTap: onClearImage, // Use the callback
                    child: const Icon(Icons.close, color: Colors.red),
                  ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.upload, color: Colors.blue),
                  onPressed: onPickImage, // Use the callback
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Function to build the family photo input field
  Widget buildInputFieldFamilyPhoto1(
    String label,
    String fileName,
    Uint8List? imageBytes,
    double width, {
    required bool isRequired,
    required VoidCallback onPickImage,
    required VoidCallback onClearImage,
  }) {
    // Your custom widget implementation here...
    // For example, you might return a Column with file name, image preview, and buttons.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        if (imageBytes != null)
          Image.memory(imageBytes, width: width, height: width),
        Row(
          children: [
            ElevatedButton(
              onPressed: onPickImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: onClearImage,
              child: const Text('Clear Image'),
            ),
          ],
        ),
        if (fileName.isNotEmpty) Text('Selected: $fileName'),
      ],
    );
  }

  //
  Widget buildInputFieldFamily(
    String label,
    TextEditingController controller,
    double width, {
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              if (isRequired)
                TextSpan(
                  text: "* ",
                  style: GoogleFonts.inter(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              TextSpan(
                text: label,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Patent_Black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: 600,
          child: TextFormField(
            controller: registerContorller.dobFamilyController.value,
            decoration: InputDecoration(
              hintText: "DD/MM/YYYY",
              hintStyle: GoogleFonts.inter(color: Patent_HintColor),
              filled: true,
              fillColor: Patent_secondory,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: _selectDateFamily,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Future<void> _selectDateF(BuildContext context, int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      // Format picked date
      String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      // Format for API
      String apiFormatted = picked.toString();

      // Save DOB

      // Calculate Age
      setState(() {
        print("picked date : ${picked}");
        print(apiFormatted);
        int age = DateTime.now().year - picked.year;
        if (DateTime.now().month < picked.month ||
            (DateTime.now().month == picked.month &&
                DateTime.now().day < picked.day)) {
          age--;
        }
        registerContorller.familys[index]["dob"]?.value = apiFormatted;

        // Save Age
        registerContorller.familys[index]["age"]?.value = age.toString();
      });
      ;
    }
  }

  void reqAlert1() {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        backgroundColor: Top,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Please read Savemom",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'InterBold',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "policy and terms",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Center(
                      child: Container(
                        height: 28,
                        width: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                          boxShadow: [BoxShadow(offset: Offset(0, 5))],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            "OK",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(String? input) {
    try {
      if (input == null || input.trim().isEmpty) return "";

      // Try parsing the input
      DateTime date = DateTime.parse(input);

      // Format to dd-MM-yyyy
      return DateFormat("dd/MM/yyyy").format(date);
    } catch (e) {
      // If format is wrong or parse fails, return original or empty
      return "";
    }
  }
}

/// **Custom Input Formatter for Aadhar Number (XXXX XXXX XXXX)**
class AadharInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(" ", ""); // Remove spaces
    String formatted = "";
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) formatted += " ";
      formatted += digits[i];
    }
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
