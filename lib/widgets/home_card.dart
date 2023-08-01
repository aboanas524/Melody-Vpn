import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String suptitle, title;
  final Widget icon;

  const HomeCard(
      {super.key,
      required this.suptitle,
      required this.title,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        icon,
        SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          suptitle,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
        ),
      ]),
    );
  }
}
