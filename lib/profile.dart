import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:microsite/constant.dart';
import 'package:microsite/login.dart';
import 'package:microsite/rounded_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Profile extends StatefulWidget {
  String? profile_picture;
  Profile({Key? key, this.profile_picture}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var value,
      usr_name,
      role_code,
      supervisor,
      role_name,
      employee_name,
      email,
      address,
      office_name,
      monthly,
      yearly,
      profile_picture;
  int counter = 0;
  File? changePhoto;
  bool changeProfile = false;
  final currencyFormatter = NumberFormat.currency(locale: 'ID');

  get preferences => null;
  @override
  void initState() {
    super.initState();
    getPref();
    // print("Emp no: " + widget.emp_no!.toString());
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      usr_name = preferences.getString("username");
      role_code = preferences.getString("role_code");
      supervisor = preferences.getString("supervisor");
      role_name = preferences.getString("role_name");
      employee_name = preferences.getString("employee_name");
      email = preferences.getString("address");
      address = preferences.getString("email");
      office_name = preferences.getString("office_name");
      monthly = preferences.getString("monthly_achievement");
      yearly = preferences.getString("yearly_achievement");
      profile_picture = preferences.getString("profile_picture");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.352,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/bg-img.jpg'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              blue_brifinance.withOpacity(0.8),
                              BlendMode.dstATop),
                        ),
                      ),
                      // child: Image.asset("assets/images/bg-img.jpg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 16, right: 16),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text("Yearly Achievement",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "SF",
                                        fontSize: 14,
                                        color: text_darkgrey)),
                                Text(
                                    yearly != null
                                        ? currencyFormatter
                                            .format(double.parse(yearly))
                                            .toString()
                                        : '0',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "SF",
                                        fontSize: 12,
                                        color: Color(0xff575757))),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text("Monthly Achievement",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "SF",
                                        fontSize: 14,
                                        color: text_darkgrey)),
                                Text(
                                    monthly != null
                                        ? currencyFormatter
                                            .format(double.parse(monthly))
                                            .toString()
                                        : '0',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "SF",
                                        fontSize: 12,
                                        color: Color(0xff575757))),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.35,
                  top: MediaQuery.of(context).size.height * 0.25,
                  child: Stack(
                      // clipBehavior: Clip.none,
                      // fit: StackFit.expand,
                      children: [
                        changeProfile == false
                            ? widget.profile_picture == null
                                ? CircleAvatar(
                                    backgroundColor: orange_brifinance,
                                    radius: 55,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/monkey.jpg"), //NetworkImage
                                      radius: 50,
                                    ), //CircleAvatar
                                  )
                                : CircleAvatar(
                                    backgroundColor: orange_brifinance,
                                    radius: 55,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "${image_url}profile_picture_RM/${widget.profile_picture!}"), //NetworkImage
                                      radius: 50,
                                    ), //CircleAvatar
                                  )
                            : CircleAvatar(
                                backgroundColor: orange_brifinance,
                                radius: 55,
                                child: CircleAvatar(
                                  backgroundImage: FileImage(
                                    changePhoto!,
                                  ), //NetworkImage
                                  radius: 50,
                                ), //CircleAvatar
                              ),
                        Positioned(
                            bottom: 0,
                            right: -20,
                            child: RawMaterialButton(
                              onPressed: () {},
                              elevation: 2.0,
                              fillColor: Color(0xFFF5F6F9),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: orange_brifinance,
                              ),
                              padding: EdgeInsets.all(10.0),
                              shape: CircleBorder(),
                            )),
                      ]),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 35,
                              decoration: BoxDecoration(
                                color: orange_brifinance,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  "ABOUT",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "SF",
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "SF",
                                          fontSize: 14,
                                          color: text_darkgrey),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      employee_name.toString().toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "SF",
                                          fontSize: 14,
                                          color: text_darkgrey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Username",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "SF",
                                          fontSize: 14,
                                          color: text_darkgrey),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      usr_name.toString().toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "SF",
                                          fontSize: 14,
                                          color: text_darkgrey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Position",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "SF",
                                          fontSize: 14,
                                          color: text_darkgrey),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      role_name.toString().toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "SF",
                                          fontSize: 14,
                                          color: text_darkgrey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Unit Kerja",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "SF",
                                          fontSize: 14,
                                          color: text_darkgrey),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      office_name.toString().toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "SF",
                                          fontSize: 14,
                                          color: text_darkgrey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "SF",
                                          fontSize: 14,
                                          color: text_darkgrey),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      email.toString().toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "SF",
                                          fontSize: 14,
                                          color: text_darkgrey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Address",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "SF",
                                          fontSize: 14,
                                          color: text_darkgrey),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      address.toString().toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "SF",
                                          fontSize: 14,
                                          color: text_darkgrey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    RoundedButton(
                            text: "LOGOUT",
                            press: () {
                              signOut();
                            },
                            c_width: double.infinity,
                            color: orange_brifinance,
                          )
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
      builder: EasyLoading.init(),
    );
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      // preferences.remove("result");
      preferences.remove("value");
      preferences.remove("username");
      preferences.remove("role_code");
      preferences.remove("role_name");
      preferences.remove("employee_name");
      preferences.remove("address");
      preferences.remove("email");
      preferences.remove("office_name");
      preferences.remove("supervisor");
      preferences.remove("emp_no");
      preferences.remove("ref_office_id");
      preferences.remove("job_title_name");
      preferences.remove("job_title_code");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
    });
  }
}
