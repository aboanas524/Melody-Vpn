import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';
import 'package:get/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(
        Duration(seconds:2),() {
          Get.off(()=>HomeScreen()) ;
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (x)=>HomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/shield.png',width: 150,height: 150,),
            Text('Melody VPN',
              style: TextStyle(
              color: Colors.black87,
              fontSize: 25,
              fontWeight: FontWeight.w500,
              letterSpacing: 3,
              fontStyle: FontStyle.italic
            ),),
          ],
        ),
      ),
    );
  }
}
