import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/constans/constants.dart';
import 'package:vpn_basic_project/controllers/controller.dart';
import 'package:vpn_basic_project/controllers/native_ad_controller.dart';
import 'package:vpn_basic_project/helper/ad_helper.dart';
import 'package:vpn_basic_project/widgets/vpn_card.dart';

class LocationsScreen extends StatelessWidget {
  LocationsScreen({super.key});

  final _vpnController = LocationController();
  final _adController = NativeAdController();

  @override
  Widget build(BuildContext context) {
    _adController.ad = AdHelper.loadNativeAd(adController: _adController);
    if (_vpnController.vpnList.isEmpty) _vpnController.getVpnData();

    return Obx(
      () => Scaffold(
        bottomNavigationBar:
            _adController.ad != null && _adController.adLoaded.isTrue
                ? SafeArea(
                    child: SizedBox(
                      height: 90,
                      child: AdWidget(ad: _adController.ad!),
                    ),
                  )
                : null,
        floatingActionButton: FloatingActionButton(
          backgroundColor: primeColor,
          onPressed: () {
            if (_vpnController.vpnList.isEmpty)
              _vpnController.getVpnData();
            else if (_vpnController.vpnList.isNotEmpty)
              Future.delayed(
                  Duration(seconds: 5), () => CircularProgressIndicator());
          },
          child: Icon(
            CupertinoIcons.refresh,
            size: 20,
          ),
        ),
        appBar: AppBar(
          backgroundColor: primeColor,
          title: Text(
            'Locations (${_vpnController.vpnList.length})',
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: _vpnController.isLoading.value
            ? _loadingWidget(context)
            : _vpnController.vpnList.isEmpty
                ? _noVPNFound()
                : _vpnData(),
      ),
    );
  }

  _vpnData() => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: _vpnController.vpnList.length,
        itemBuilder: (ctx, i) => VpnCard(vpn: _vpnController.vpnList[i]),
      );

  _loadingWidget(context) => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/lottie/loading.json',
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width * .6,
              frameRate: FrameRate.max,
            ),
          ],
        ),
      );

  _noVPNFound() => Center(
        child: Text(
          'VPNs not found',
          style: TextStyle(fontSize: 50, color: Colors.red),
        ),
      );
}
