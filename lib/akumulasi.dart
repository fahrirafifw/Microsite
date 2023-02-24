import 'package:flutter/material.dart';

class Akumulasi extends StatelessWidget {
  final String yearly_achivement, monthly_achivement;

  const Akumulasi(
      {Key? key,
      required this.yearly_achivement,
      required this.monthly_achivement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Yearly Achievement",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "SF",
                      fontSize: 14,
                      color: Colors.white),
                ),
                Text(
                  yearly_achivement,
                  style: TextStyle(
                      fontFamily: "SF", fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Monthly Achievement",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "SF",
                      fontSize: 14,
                      color: Colors.white),
                ),
                Text(
                  monthly_achivement,
                  style: TextStyle(
                      fontFamily: "SF", fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
