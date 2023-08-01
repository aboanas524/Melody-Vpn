import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:vpn_basic_project/api/api.dart';
import 'package:vpn_basic_project/constans/constants.dart';
import 'package:vpn_basic_project/models/ip_details.dart';
import 'package:vpn_basic_project/models/network_data.dart';
import 'package:vpn_basic_project/widgets/network_card.dart';

class NetworkScreen extends StatelessWidget {
  const NetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ipData = IPDetails.fromJson({}).obs;
    API.getIPDetails(ipData: ipData);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primeColor,
        title: Text('Network info'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primeColor,
        onPressed: () {
          ipData.value = IPDetails.fromJson({});
          API.getIPDetails(ipData: ipData);
        },
        child: Icon(
          CupertinoIcons.refresh,
          size: 22,
        ),
      ),
      body: Obx(
        () => ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * .02,
            right: MediaQuery.of(context).size.width * .02,
            top: MediaQuery.of(context).size.height * .01,
            bottom: MediaQuery.of(context).size.height * .1,
          ),
          children: [
            NetworkCard(
                data: NetworkData(
                    title: 'IP Address',
                    subtitle: ipData.value.query,
                    icon: Icon(
                      CupertinoIcons.location_solid,
                      color: primeColor,
                      size: 30,
                    ))),
            NetworkCard(
                data: NetworkData(
                    title: 'Internet Provider',
                    subtitle: ipData.value.isp,
                    icon: Icon(
                      Icons.business,
                      color: Colors.amber,
                      size: 30,
                    ))),
            NetworkCard(
                data: NetworkData(
                    title: 'Location',
                    subtitle:
                        '${ipData.value.city} ,${ipData.value.regionName} ,${ipData.value.country}',
                    icon: Icon(
                      CupertinoIcons.location,
                      color: Colors.pink,
                      size: 30,
                    ))),
            NetworkCard(
                data: NetworkData(
                    title: 'Pin-code',
                    subtitle: ipData.value.zip.isEmpty
                        ? '- - - - '
                        : ipData.value.zip,
                    icon: Icon(
                      Icons.code,
                      color: Colors.blue,
                      size: 30,
                    ))),
            NetworkCard(
                data: NetworkData(
                    title: 'Timezone',
                    subtitle: ipData.value.timezone,
                    icon: Icon(
                      CupertinoIcons.time,
                      color: Colors.green,
                      size: 30,
                    )))
          ],
        ),
      ),
    );
  }
}
