import 'dart:convert';
import 'package:get/get.dart';
import 'package:vpn_basic_project/helper/ad_helper.dart';
import 'package:vpn_basic_project/helper/pref.dart';
import 'package:vpn_basic_project/models/vpn.dart';
import 'package:vpn_basic_project/models/vpn_config.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';

class HomeController extends GetxController {
  final Rx<Vpn> vpn = Pref.vpn.obs;
  final vpnState = VpnEngine.vpnDisconnected.obs;
  void connectToVpn() async {
    ///Stop right here if user not select a vpn
    if (vpn.value.openVPNConfigDataBase64.isEmpty) return;

    if (vpnState.value == VpnEngine.vpnDisconnected) {
      ///Start if stage is disconnected
      final data = Base64Decoder().convert(vpn.value.openVPNConfigDataBase64);
      final config = Utf8Decoder().convert(data);
      final vpnConfig = VpnConfig(
          country: vpn.value.countryLong.toLowerCase(),
          username: 'vpn',
          password: 'vpn',
          config: config);

      AdHelper.showInterstitialAd(
        onComplete: () async {
          await VpnEngine.startVpn(vpnConfig);
        },
      );
    } else {
      ///Stop if stage is "not" disconnected
      await VpnEngine.stopVpn();
    }
  }
}
