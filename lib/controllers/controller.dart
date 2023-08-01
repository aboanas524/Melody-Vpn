import 'package:get/get.dart';
import 'package:vpn_basic_project/api/api.dart';
import 'package:vpn_basic_project/helper/pref.dart';
import 'package:vpn_basic_project/models/vpn.dart';

class LocationController extends GetxController {
  List<Vpn> vpnList = Pref.vpnList;
  final RxBool isLoading = false.obs;
  Future<void> getVpnData() async {
    isLoading.value = true;
    vpnList.clear();
    vpnList = await API.getVPNServices();
    isLoading.value = false;
  }
}
