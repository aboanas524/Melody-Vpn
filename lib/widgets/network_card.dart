import 'package:flutter/material.dart';
import 'package:vpn_basic_project/models/network_data.dart';

class NetworkCard extends StatelessWidget {
  final NetworkData data;
  const NetworkCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Container(
        width: 200,
        height: 88,
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              ////////// Icon
              leading: Icon(
                data.icon.icon,
                size: data.icon.size ?? 30,
                color: data.icon.color,
              ),
              //// Title
              title: Text(data.title),
              //// Subtitle
              subtitle: Text(data.subtitle),
            )),
      ),
    );
  }
}
