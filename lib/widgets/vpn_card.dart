import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/constans/constants.dart';
import 'package:vpn_basic_project/controllers/home_controller.dart';
import 'package:vpn_basic_project/helper/pref.dart';
import 'package:vpn_basic_project/models/vpn.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';

class VpnCard extends StatelessWidget {
  final Vpn vpn;
  const VpnCard({super.key, required this.vpn});

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<HomeController>();

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        child: InkWell(
          onTap: () {
            _controller.vpn.value = vpn;
            Pref.vpn = vpn;
            Get.back();
            if (_controller.vpnState.value == VpnEngine.vpnConnected) {
              VpnEngine.stopVpn();
              Future.delayed(
                  Duration(seconds: 2), () => _controller.connectToVpn());
            } else {
              _controller.connectToVpn();
            }
          },
          borderRadius: BorderRadius.circular(15),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text(vpn.countryLong),
            leading: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black12)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/flags/${vpn.countryShort.toLowerCase()}.png',
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.15,
                    fit: BoxFit.fill,
                  )),
            ),
            subtitle: Row(children: [
              Icon(
                Icons.speed_rounded,
                size: 22,
                color: primeColor,
              ),
              Text(
                _formatBytes(vpn.speed, 1),
                style: TextStyle(fontSize: 13),
              ),
            ]),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(
                vpn.ping.toString(),
                style: TextStyle(color: Colors.black45, fontSize: 17),
              ),
              SizedBox(
                width: 4,
              ),
              Icon(
                Icons.equalizer_rounded,
                size: 25,
                color: primeColor,
              )
            ]),
          ),
        ),
      ),
    );
  }

  String _formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['Bps', 'Kbps', 'Mbps', 'Gbps', 'Tbps'];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
