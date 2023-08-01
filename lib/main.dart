import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vpn_basic_project/helper/ad_helper.dart';
import 'package:vpn_basic_project/helper/pref.dart';
import 'package:vpn_basic_project/screens/Splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Pref.initializeHive();
  await AdHelper.initAds();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Melody VPN',
      home: SplashScreen(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        elevation: 5,
        centerTitle: true,
      )),
    );
  }
}
