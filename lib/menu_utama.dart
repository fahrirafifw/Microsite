import 'dart:convert';
import 'dart:async';
import 'package:microsite/components/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:microsite/beranda.dart';
import 'package:microsite/constant.dart';
import 'package:microsite/custom_animated_bottom_bar.dart';
import 'package:microsite/notification.dart';
import 'package:microsite/profile.dart';
import 'package:microsite/test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

enum ConnectivityResult { wifi, mobile, none }

class _MainMenuState extends State<MainMenu> {
  ConnectivityResult result = ConnectivityResult.none;
  bool hasInternet = false;
  late Timer _timer;
  bool forceLogout = false;
  final navigatorKey = GlobalKey<NavigatorState>();
  final _formKey = GlobalKey<FormState>();
  var usr_name, emp_no;
  int _currentIndex = 0;
  final _inactiveColor = Color(0xff004993);

  int count_notification = 0;

  var notification_data;

  List? notification_list, notification_list_not_read;
  String? profile_picture;

  int _counter = 1;
  bool showNotifBadge = false;

  @override
  void initState() {
    super.initState();
    getPref();
    _getRefreshDataCount();
    getProfilePicture();
  }

  Future<void> getProfilePicture() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? temp_emp_no = preferences.getString("emp_no");
    var list_emp_no = temp_emp_no!.split("-");
    String emp_no = list_emp_no[0] + list_emp_no[1];

    var request = await http.post(
        Uri.parse("${auth_controller}showProfilePicture"),
        headers: {
          "x-api-key": "${api_key}",
          "Content-Type": "application/json"
        },
        body: jsonEncode({'emp_no': emp_no}));

    final response = jsonDecode(request.body);

    setState(() {
      if (response == "null") {
        profile_picture = null;
      } else {
        profile_picture = response;
      }
    });

    preferences.setString("profile_picture", profile_picture!);
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      usr_name = preferences.getString("username");
      emp_no = preferences.getString("emp_no");
    });
  }

  Future<void> _getRefreshDataCount() async {
    this.getJsonData(context);
  }

  Future<void> getJsonData(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    // NOTIFICATION DATA
    var response_notification = await http.post(
        Uri.parse('${auth_controller}getDataNotification'),
        headers: {
          "x-api-key": "${api_key}",
          "Content-Type": "application/json"
        },
        body: jsonEncode({'username': usr_name}));

    setState(() {
      var data_notification = jsonDecode(response_notification.body);

      if (data_notification["data_notif"] == null) {
        notification_list = null;
      } else {
        notification_list = data_notification["data_notif"];
      }

      if (data_notification["data_not_read"] == null) {
        notification_list_not_read = null;
      } else {
        notification_list_not_read = data_notification["data_not_read"];
        showNotifBadge = true;
      }
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            content: new Text('Are you sure to logout from application?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: getBody(),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          activeColor: Colors.blue,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.notifications),
          title: Text('Notification'),
          activeColor: Colors.blue,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.account_circle_rounded),
          title: Text('Profile'),
          activeColor: Colors.blue,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      Beranda(),
      NotifList(),
      Profile(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
  @override
  Widget form() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Form(key: _formKey, 
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Container(decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                ),
          ),
          InputField(
            label:"Nama Lengkap",
            hintText: "Nama....",
            onChanged: (value){},
            type: TextInputType.text,
            fieldColor: Colors.white,
            validator: (value){
              if(value!.isEmpty){
                return "Name is Required!";
              }else{
                return null;
              }
            },

          ),
          //Karyawan bri group?

          InputField(
                  label: "Alamat Rumah",
                  hintText: "Alamat Rumah",
                  onChanged: (value) {},
                  type: TextInputType.text,
                  fieldColor: Colors.white,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Alamat is Required!";
                    } else {
                      return null;
                    }
                  },
                  
                ),

          ])
            ,)
            ,)
            ,)
            ,
    );
  }
}
