
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:microsite/akumulasi.dart';
import 'package:microsite/header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';

class NotifList extends StatefulWidget {
  NotifList({Key? key})
      : super(key: key);

  @override
  State<NotifList> createState() => _NotifListState();
}

class _NotifListState extends State<NotifList> {
  String? username;
  var usr_name,
      role_name,
      employee_name,
      office_name,
      monthly,
      yearly,
      profile_picture;
  final currencyFormatter = NumberFormat.currency(locale: 'ID');
  bool showNotifBadge = true;

  void initState() {
    super.initState();
    getPref();
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      usr_name = preferences.getString("username");
      role_name = preferences.getString("role_name");
      employee_name = preferences.getString("employee_name");
      office_name = preferences.getString("office_name");
      monthly = preferences.getString("monthly_achievement");
      yearly = preferences.getString("yearly_achievement");
      username = preferences.getString("username");
      profile_picture = preferences.getString("profile_picture");
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Column(children: [
            Stack(
              children: [
                background(),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget background() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.3 -
            MediaQuery.of(context).padding.top,
        width: double.infinity,
        decoration: BoxDecoration(
          color: blue_brifinance,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Header(
                  nama: employee_name,
                  position: role_name,
                  uk: office_name,
                  image_src: profile_picture == null
                      ? "monkey"
                      : profile_picture.toString()),
              Akumulasi(
                  yearly_achivement: yearly != null
                      ? currencyFormatter
                          .format(double.parse(yearly))
                          .toString()
                      : '0',
                  monthly_achivement: monthly != null
                      ? currencyFormatter
                          .format(double.parse(monthly))
                          .toString()
                      : '0'),
            ],
          ),
        ));
  }
}

_showToast(BuildContext context, String msg) async {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(msg),
    ),
  );
}
