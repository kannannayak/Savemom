import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savemom/Login/login.dart';
import 'package:savemom/Splash.dart';

import 'language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleFonts.pendingFonts();
  await GetStorage.init();
  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );
  runApp(MyApp());
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await GoogleFonts.pendingFonts();
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Locale("en", "US"),
      fallbackLocale: Locale("en", "US"),
      translations: Language(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          // Login(),
          SplashScreen(),
    );
  }
}
