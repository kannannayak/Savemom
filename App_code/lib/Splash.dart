import 'package:flutter/material.dart';
import 'package:get/get.dart';
  
import 'package:savemom/Cache/Cache_helper.dart';
import 'package:savemom/HomeJimble/HomeJimble.dart';
import 'package:savemom/Login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay like splash (same as video duration feel)
    Future.delayed(const Duration(seconds: 3), () {
      checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF34363A),
      body: Center(
        child: Image(image: AssetImage("assets/images/Savemom.png")),
      ),
    );
  }

  Future<void> checkLoginStatus() async {
    final pName = await Cachehelper.getSaveddata("p_name") ?? "";
    final rName = await Cachehelper.getSaveddata("r_name") ?? "";
    final pId = await Cachehelper.getSaveddata("p_id") ?? "";
    final rId = await Cachehelper.getSaveddata("rId") ?? "";

    if (pId.isNotEmpty) {
      Get.offAll(
        HomeJimble(pName: pName, pId: pId, familyMemberName: rName, rId: rId),
      );
    } else {
      Get.offAll(const Login());
    }
  }
}
