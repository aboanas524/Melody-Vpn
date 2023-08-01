import 'dart:convert';
import 'dart:developer';
import 'package:csv/csv.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:vpn_basic_project/helper/pref.dart';
import 'package:vpn_basic_project/models/ip_details.dart';
import 'package:vpn_basic_project/models/vpn.dart';

class API {
  static Future<List<Vpn>> getVPNServices() async {
    final List<Vpn> vpnList = [];
    try {
      final res =
          await http.get(Uri.parse('http://www.vpngate.net/api/iphone/'));
      var csvString = res.body.split('#')[1].replaceAll('*', '');
      List<List<dynamic>> list = const CsvToListConverter().convert(csvString);
      final header = list[0];

      Map<String, dynamic> tempJson = {};
      for (int i = 1; i < list.length - 1; i++) {
        for (int j = 0; j < header.length; j++) {
          tempJson.addAll({header[j].toString(): list[i][j]});
        }
        vpnList.add(Vpn.fromJson(tempJson));
      }
    } catch (e) {
      log('Erorr : $e');
    }
    vpnList.shuffle();
    if (vpnList.isNotEmpty) Pref.vpnList = vpnList;
    return vpnList;
  }

  static Future<void> getIPDetails({required Rx<IPDetails> ipData}) async {
    try {
      final res = await http.get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(res.body);
      ipData.value = IPDetails.fromJson(data);
    } catch (e) {
      log('Error ip details :$e');
    }
  }
}
