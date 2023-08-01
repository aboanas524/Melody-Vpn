import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/constans/constants.dart';
import 'package:vpn_basic_project/controllers/home_controller.dart';
import 'package:vpn_basic_project/helper/ad_helper.dart';
import 'package:vpn_basic_project/models/vpn_status.dart';
import 'package:vpn_basic_project/screens/locations_screen.dart';
import 'package:vpn_basic_project/screens/network_screen.dart';
import 'package:vpn_basic_project/widgets/count_down_timer.dart';
import 'package:vpn_basic_project/widgets/home_card.dart';
import '../services/vpn_engine.dart';

// ignore: must_be_immutable 
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _controller = Get.put(HomeController());
  var mq;

  @override
  Widget build(BuildContext context) {
    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });
    mq = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 10, 46, 206),
          title: Text('Melody VPN'),
          leading: Icon(CupertinoIcons.home),
          actions: [
            IconButton(
                icon: Icon(Icons.dark_mode),
                onPressed: () {
                  AdHelper.showRewardAd(onComplete: () {
                    log('Success');
                  });
                  /*Get.changeThemeMode(
                      Pref.DarkMode ? ThemeMode.light : ThemeMode.dark);
                  Pref.isDarkMode = !Pref.isDarkMode;*/
                },
                iconSize: 26),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(Icons.info_outline),
                iconSize: 26,
                onPressed: () {
                  // info ///////////////////////////////
                  Get.to(() => NetworkScreen());
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: _changeLocation(),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          //////////////////// Button ///////////////////////////////////
          _vpnButton(),
          CountDownTimer(
            startTimer: _controller.vpnState.value == VpnEngine.vpnConnected,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HomeCard(
                title: _controller.vpn.value.countryLong.isEmpty
                    ? 'Country'
                    : _controller.vpn.value.countryLong,
                suptitle: 'Free',
                icon: CircleAvatar(
                  radius: 30,
                  child: _controller.vpn.value.countryLong.isEmpty
                      ? Icon(
                          Icons.vpn_lock_rounded,
                          size: 30,
                        )
                      : null,
                  backgroundImage: _controller.vpn.value.countryLong.isEmpty
                      ? null
                      : AssetImage(
                          'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png'),
                ),
              ),
              HomeCard(
                  title: _controller.vpn.value.countryLong.isEmpty
                      ? '100 ms'
                      : '${_controller.vpn.value.ping}',
                  suptitle: 'Ping',
                  icon: CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 30,
                      child: Icon(
                        Icons.equalizer_rounded,
                        size: 30,
                        color: Colors.white,
                      ))),
            ],
          ),
          StreamBuilder<VpnStatus?>(
            initialData: VpnStatus(),
            stream: VpnEngine.vpnStatusSnapshot(),
            builder: (context, snapshot) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                HomeCard(
                    title: snapshot.data!.byteIn ?? '0 kbps',
                    suptitle: 'Download',
                    icon: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 30,
                        child: Icon(
                          Icons.arrow_downward_rounded,
                          size: 30,
                          color: Colors.white,
                        ))),
                HomeCard(
                    title: snapshot.data!.byteOut ?? '0 kbps',
                    suptitle: 'Upload',
                    icon: CircleAvatar(
                        backgroundColor: Colors.lightBlue,
                        radius: 30,
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          size: 30,
                          color: Colors.white,
                        ))),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  ///// Vpn Button /////
  Widget _vpnButton() => Semantics(
        button: true,
        child: Container(
          padding: EdgeInsets.all(20),
          width: mq.height * 0.26,
          height: mq.height * 0.26,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _controller.vpnState.value == VpnEngine.vpnConnected
                ? connectedColor.withOpacity(0.10)
                : primeColor.withOpacity(0.10),
          ),
          child: Container(
            width: mq.height * 0.24,
            height: mq.height * 0.24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _controller.vpnState.value == VpnEngine.vpnConnected
                  ? connectedColor.withOpacity(0.2)
                  : primeColor.withOpacity(0.2),
            ),
            padding: EdgeInsets.all(20),
            child: Container(
              width: mq.height * 0.22,
              height: mq.height * 0.22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _controller.vpnState.value == VpnEngine.vpnConnected
                    ? connectedColor.withOpacity(0.4)
                    : primeColor.withOpacity(0.4),
              ),
              padding: EdgeInsets.all(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(115),
                onTap: () {
                  _controller.connectToVpn();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _controller.vpnState.value == VpnEngine.vpnConnected
                        ? connectedColor
                        : primeColor,
                    shape: BoxShape.circle,
                  ),
                  width: mq.height * 0.2,
                  height: mq.height * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Icon(
                          Icons.power_settings_new,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _controller.vpnState.value == VpnEngine.vpnDisconnected
                            ? 'Tap to connect'
                            : _controller.vpnState.value
                                .replaceAll("_", " ")
                                .toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  /////// Change Location ///////
  Widget _changeLocation() => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              Get.to(() => LocationsScreen());
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
              height: 60,
              decoration: BoxDecoration(
                  color: primeColor, borderRadius: BorderRadius.circular(50)),
              child: Row(children: [
                Icon(
                  CupertinoIcons.globe,
                  size: 30,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Change Location',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.white,
                  size: 30,
                )
              ]),
            ),
          ),
        ),
      );
}
