import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:microsite/beranda.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:microsite/components/new_dropdown.dart';
import 'package:microsite/constant.dart';
import 'package:microsite/menu_utama.dart';
import 'package:microsite/rounded_button.dart';
import 'package:microsite/rounded_input_Phone_Number.dart';
import 'package:microsite/rounded_input_field.dart';
import 'package:microsite/rounded_password_field.dart';
import 'package:microsite/signup.dart';
import 'package:microsite/test.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum LoginStatus {
  notSignIn,
  signIn_LO,
  signIn_BM,
  signIn_CRDSTAFF,
  signIn_CRDGH,
  signIn_BOD
}

class _LoginScreenState extends State<LoginScreen> {
  static LoginStatus _loginStatus = LoginStatus.notSignIn;
  bool _flag = true;
  bool hasInternet = false;
  final myUsernameController = TextEditingController();
  final myPasswordController = TextEditingController();
  final myPhoneNumberController = TextEditingController();
  String? nUsername,
      nPassword,
      kodecabang,
      getVersion,
      nPhoneNumber,
      input_kodecabang;
  final kodeCabang = [
    'JAKARTA HO2',
    'KC WEST JAKARTA',
    'KC BEKASI',
    'KC BANDUNG',
    'KC SURABAYA',
    'KC MEDAN',
    'KC SAMARINDA',
    'KC BALIKPAPAN',
    'KC SOLO',
    'KC PALEMBANG',
    'KC MAKASAR',
    'KC DENPASAR',
    'KC SEMARANG',
    'KC PEKANBARU',
    'KP BANJARMASIN',
    'KC MALANG',
    'KP CIREBON',
    'KC BANDAR LAMPUNG ',
    'KC DEPOK',
    'KC BSD',
    'KC BANYUWANGI',
    'KC MANADO',
    'KC YOGYAKARTA',
    'KC BOGOR',
    'KC PONTIANAK',
    'KP KELAPA GADING',
    'KP PADANG',
    'KP PONDOK INDAH',
    'KP KOTA',
    'KP MANGGA DUA',
    'KP KLENDER',
    'KP PLUIT',
    'KP CIBUBUR',
    'KP SERANG',
    'KP CIKUPA',
    'KP CIKARANG',
    'KP KARAWANG',
    'KP CIMAHI',
    'KP BATAM',
    'KP JAMBI',
    'KP SIDOARJO',
    'KP JEMBER'
  ];

  // USER
  String? usr_name,
      brch_code,
      role_code,
      role_name,
      employee_name,
      email,
      address,
      office_name,
      office_code,
      supervisor,
      emp_no,
      ref_office_id,
      job_title_name,
      job_title_code,
      area,
      result,
      Message;
  int? role_value;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getPref();
    _initPackageInfo();
  }

  @override
  void dispose() {
    myUsernameController.dispose();
    myPasswordController.dispose();
    myPhoneNumberController.dispose();

    super.dispose();
  }

  login(String nUsername, String nPassword, String nPhoneNumber,
      BuildContext context) async {
    /*try {*/

    // CALL API ROLECHECK
    final resp = await http
        .post(Uri.parse("${credit_approval_controller}loginMyBrif"), headers: {
      /*"x-api-key": "${api_key}"*/
    }, body: {
      "username": nUsername,
      "password": nPassword,
      "branch_code": input_kodecabang
    });

    final data2 = jsonDecode(resp.body);
    print(data2);
    print(input_kodecabang);

    if (data2['result'] == 99) {
      Message = data2['Message'];
      Alert(
        context: context,
        type: AlertType.warning,
        title: "WARNING",
        desc: Message,
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: blue_brifinance,
          ),
        ],
      ).show();
    } else if (data2['result'] == 984) {
      Message = data2['Message'];
      Alert(
        context: context,
        type: AlertType.warning,
        title: "WARNING",
        desc: Message,
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            color: blue_brifinance,
          ),
        ],
      ).show();
    } else if (data2['result'] == 1) {
      Message = data2['Message'];
      Alert(
        context: context,
        type: AlertType.info,
        title: "Login Berhasil!",
        desc: Message,
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Beranda()));
            },
            color: blue_brifinance,
          ),
        ],
      ).show();
      setState(() {
        _flag = true;
      });
      //   return MaterialPageRoute(
      // builder: (BuildContext context) => Beranda(),);
      // if (role_code == "LO") {
      //   if (supervisor == null) {
      //     supervisor = "NULL";
      //   }
      //   setState(() {
      //     print("signIn LO");
      //     _loginStatus = LoginStatus.signIn_LO;
      //     _flag = true;
      //     savePref(
      //         role_value!,
      //         usr_name!,
      //         role_code!,
      //         role_name!,
      //         employee_name!,
      //         email!,
      //         address!,
      //         office_name!,
      //         office_code!,
      //         supervisor!,
      //         emp_no!,
      //         ref_office_id!,
      //         job_title_name!,
      //         job_title_code!,
      //         area!);
      //   });
      //   _showToast(context, Message!);

      // } else if (role_code == "CRDSTAFF") {
      //   if (supervisor == null) {
      //     supervisor = "NULL";
      //   }
      //   setState(() {
      //     _loginStatus = LoginStatus.signIn_CRDSTAFF;
      //     _flag = true;
      //     savePref(
      //         role_value!,
      //         usr_name!,
      //         role_code!,
      //         role_name!,
      //         employee_name!,
      //         email!,
      //         address!,
      //         office_name!,
      //         office_code!,
      //         supervisor!,
      //         emp_no!,
      //         ref_office_id!,
      //         job_title_name!,
      //         job_title_code!,
      //         area!);
      //   });
      //   _showToast(context, Message!);
      // } else if (role_code == "CRDGH" || role_code == "CRDDGH") {
      //   if (supervisor == null) {
      //     supervisor = "NULL";
      //   }
      //   setState(() {
      //     _loginStatus = LoginStatus.signIn_CRDGH;
      //     _flag = true;
      //     savePref(
      //         role_value!,
      //         usr_name!,
      //         role_code!,
      //         role_name!,
      //         employee_name!,
      //         email!,
      //         address!,
      //         office_name!,
      //         office_code!,
      //         supervisor!,
      //         emp_no!,
      //         ref_office_id!,
      //         job_title_name!,
      //         job_title_code!,
      //         area!);
      //   });
      //   _showToast(context, Message!);
      // } else if (role_code == "BM" ||
      //     role_code == "MKTUH" ||
      //     role_code == "MKTGH" ||
      //     role_code == "DCBM" ||
      //     role_code == "CBM") {
      //   if (supervisor == null) {
      //     supervisor = "NULL";
      //   }
      //   setState(() {
      //     print("signIn BM");
      //     _loginStatus = LoginStatus.signIn_BM;
      //     _flag = true;
      //     savePref(
      //         role_value!,
      //         usr_name!,
      //         role_code!,
      //         role_name!,
      //         employee_name!,
      //         email!,
      //         address!,
      //         office_name!,
      //         office_code!,
      //         supervisor!,
      //         emp_no!,
      //         ref_office_id!,
      //         job_title_name!,
      //         job_title_code!,
      //         area!);
      //   });
      //   _showToast(context, Message!);
      // } else if (role_code == "BOD") {
      //   if (supervisor == null) {
      //     supervisor = "NULL";
      //   }
      //   setState(() {
      //     print("signIn BOD");
      //     _loginStatus = LoginStatus.signIn_BOD;
      //     _flag = true;
      //     savePref(
      //         role_value!,
      //         usr_name!,
      //         role_code!,
      //         role_name!,
      //         employee_name!,
      //         email!,
      //         address!,
      //         office_name!,
      //         office_code!,
      //         supervisor!,
      //         emp_no!,
      //         ref_office_id!,
      //         job_title_name!,
      //         job_title_code!,
      //         area!);
      //   });
      //   _showToast(context, Message!);
      // }
    }
    // } else if (data2.length == 3) {
    //   status = data2['status'];
    //   msg = data2['message'];
    //   if (status == "data_not_found") {
    //     Alert(
    //       context: context,
    //       type: AlertType.warning,
    //       title: "WARNING",
    //       desc: msg,
    //       buttons: [
    //         DialogButton(
    //           child: Text(
    //             "OK",
    //             style: TextStyle(color: Colors.white, fontSize: 20),
    //           ),
    //           onPressed: () {Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => SignUpPage()));},
    //           color: blue_brifinance,
    //         ),
    //       ],
    //     ).show();
    //   } else if (status == "failed_check_mac") {
    //     Alert(
    //       context: context,
    //       type: AlertType.warning,
    //       title: "WARNING",
    //       desc: msg,
    //       buttons: [
    //         DialogButton(
    //           child: Text(
    //             "OK",
    //             style: TextStyle(color: Colors.white, fontSize: 20),
    //           ),
    //           onPressed: () {Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => SignUpPage()));},
    //           color: blue_brifinance,
    //         ),
    //       ],
    //     ).show();
    //   }
    // } else if (data2.length == 4) {
    //   status = data2['status'];
    //   msg = data2['Message'];
    //   if (status == "outdated_version") {
    //     Alert(
    //       context: context,
    //       type: AlertType.warning,
    //       title: "WARNING",
    //       desc: msg,
    //       buttons: [
    //         DialogButton(
    //           child: Text(
    //             "OK",
    //             style: TextStyle(color: Colors.white, fontSize: 20),
    //           ),
    //           onPressed: () {Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => SignUpPage()));},
    //           color: blue_brifinance,
    //         ),
    //       ],
    //     ).show();
    //   } else if (status == "no_data_found") {
    //     Alert(
    //       context: context,
    //       type: AlertType.warning,
    //       title: "WARNING",
    //       desc: msg,
    //       buttons: [
    //         DialogButton(
    //           child: Text(
    //             "OK",
    //             style: TextStyle(color: Colors.white, fontSize: 20),
    //           ),
    //           onPressed: () {Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => SignUpPage()));},
    //           color: blue_brifinance,
    //         ),
    //       ],
    //     ).show();
    //   }
    // } else {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //             title: Text('Login As',
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontFamily: "SF",
    //                     fontSize: 16,
    //                     color: text_darkgrey)),
    //             content: Container(
    //               height: 300.0, // Change as per your requirement
    //               width: 300.0, // Change as per your requirement
    //               child: ListView.builder(
    //                 shrinkWrap: true,
    //                 itemCount: data2.length,
    //                 itemBuilder: (BuildContext context, int index) {
    //                   return data2 == null
    //                       ? Text("Not Found")
    //                       : itemList(data2[index]['ROLE_CODE'],
    //                           data2[index]['OFFICE_NAME'], () {
    //                           usr_name = data2[index]['USERNAME'];
    //                           role_code = data2[index]['ROLE_CODE'];
    //                           role_name = data2[index]['ROLE_NAME'];
    //                           employee_name = data2[index]['EMP_NAME'];
    //                           email = data2[index]['EMAIL_1'];
    //                           address = data2[index]['ADDR'];
    //                           office_name = data2[index]['OFFICE_NAME'];
    //                           office_code = data2[index]['OFFICE_CODE'];
    //                           supervisor = data2[index]['SUPERVISOR'];
    //                           emp_no = data2[index]['EMP_NO'];
    //                           ref_office_id = data2[index]['REF_OFFICE_ID'];
    //                           job_title_name = data2[index]['JOB_TITLE_NAME'];
    //                           job_title_code = data2[index]['JOB_TITLE_CODE'];
    //                           area = data2[index]['AREA'];
    //                           status = "data_found";
    //                           msg = "Login as ${data2[index]['ROLE_NAME']}";

    //                           if (role_code == "BM" ||
    //                               role_code == "MKTUH" ||
    //                               role_code == "MKTGH" ||
    //                               role_code == "BM" ||
    //                               role_code == "DCBM" ||
    //                               role_code == "CBM") {
    //                             role_value = 2;

    //                             if (supervisor == null) {
    //                               supervisor = "NULL";
    //                             }
    //                             setState(() {
    //                               print("signIn BM");
    //                               _loginStatus = LoginStatus.signIn_BM;
    //                               _flag = true;
    //                               savePref(
    //                                   role_value!,
    //                                   usr_name!,
    //                                   role_code!,
    //                                   role_name!,
    //                                   employee_name!,
    //                                   email!,
    //                                   address!,
    //                                   office_name!,
    //                                   office_code!,
    //                                   supervisor!,
    //                                   emp_no!,
    //                                   ref_office_id!,
    //                                   job_title_name!,
    //                                   job_title_code!,
    //                                   area!);
    //                             });
    //                           } else if (role_code == "CRDSTAFF") {
    //                             role_value = 3;

    //                             if (supervisor == null) {
    //                               supervisor = "NULL";
    //                             }

    //                             setState(() {
    //                               _loginStatus = LoginStatus.signIn_CRDSTAFF;
    //                               _flag = true;
    //                               savePref(
    //                                   role_value!,
    //                                   usr_name!,
    //                                   role_code!,
    //                                   role_name!,
    //                                   employee_name!,
    //                                   email!,
    //                                   address!,
    //                                   office_name!,
    //                                   office_code!,
    //                                   supervisor!,
    //                                   emp_no!,
    //                                   ref_office_id!,
    //                                   job_title_name!,
    //                                   job_title_code!,
    //                                   area!);
    //                             });
    //                           } else if (role_code == "CRDGH" ||
    //                               role_code == "CRDDGH") {
    //                             role_value = 5;

    //                             if (supervisor == null) {
    //                               supervisor = "NULL";
    //                             }

    //                             setState(() {
    //                               _loginStatus = LoginStatus.signIn_CRDGH;
    //                               _flag = true;
    //                               savePref(
    //                                   role_value!,
    //                                   usr_name!,
    //                                   role_code!,
    //                                   role_name!,
    //                                   employee_name!,
    //                                   email!,
    //                                   address!,
    //                                   office_name!,
    //                                   office_code!,
    //                                   supervisor!,
    //                                   emp_no!,
    //                                   ref_office_id!,
    //                                   job_title_name!,
    //                                   job_title_code!,
    //                                   area!);
    //                             });
    //                           } else if (role_code == "BOD") {
    //                             role_value = 4;

    //                             if (supervisor == null) {
    //                               supervisor = "NULL";
    //                             }

    //                             setState(() {
    //                               _loginStatus = LoginStatus.signIn_BOD;
    //                               _flag = true;
    //                               savePref(
    //                                   role_value!,
    //                                   usr_name!,
    //                                   role_code!,
    //                                   role_name!,
    //                                   employee_name!,
    //                                   email!,
    //                                   address!,
    //                                   office_name!,
    //                                   office_code!,
    //                                   supervisor!,
    //                                   emp_no!,
    //                                   ref_office_id!,
    //                                   job_title_name!,
    //                                   job_title_code!,
    //                                   area!);
    //                             });
    //                           }

    //                           Navigator.pop(context);
    //                         });
    //                 },
    //               ),
    //             ));
    //       });
    /*}*/
    // } catch (error) {
    //   _showToast(context, error.toString());
    // }
  }

  Widget itemList(String role_code, office_name, VoidCallback pressed) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: pressed,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.person,
                    color: Color(0xff004993),
                    size: 20,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        role_code,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "SF",
                            fontSize: 12,
                            color: text_darkgrey),
                      ),
                      Text(
                        office_name,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: "SF",
                            fontSize: 12,
                            color: text_darkgrey),
                      ),
                    ],
                  ),
                ),
              ])),
        ));
  }

  savePref(String usr_name, brch_code) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      // preferences.setInt("result", value);

      preferences.setString("username", usr_name);
      preferences.setString("branch_code", brch_code);

      // preferences.commit();
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      role_value = preferences.getInt("value");
      usr_name = preferences.getString("username");
      brch_code = preferences.getString("branch_code");
      role_code = preferences.getString("role_code");
      role_name = preferences.getString("role_name");
      employee_name = preferences.getString("employee_name");
      email = preferences.getString("address");
      address = preferences.getString("email");
      office_name = preferences.getString("office_name");
      office_code = preferences.getString("office_code");
      supervisor = preferences.getString("supervisor");
      emp_no = preferences.getString("emp_no");
      ref_office_id = preferences.getString("ref_office_id");
      job_title_name = preferences.getString("job_title_name");
      job_title_code = preferences.getString("job_title_code");
      area = preferences.getString("area");

      if (role_value == 1) {
        _loginStatus = LoginStatus.signIn_LO;
      } else if (role_value == 2) {
        _loginStatus = LoginStatus.signIn_BM;
      } else if (role_value == 3) {
        _loginStatus = LoginStatus.signIn_CRDSTAFF;
      } else if (role_value == 5) {
        _loginStatus = LoginStatus.signIn_CRDGH;
      } else if (role_value == 4) {
        _loginStatus = LoginStatus.signIn_BOD;
      } else {
        _loginStatus = LoginStatus.notSignIn;
      }
    });
  }

  String handler() {
    return "Username / Password wrong";
  }

  Widget noConnection() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Image.asset("assets/images/lost_connection.jpg"),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          body: PageView(
            children: [
              Container(
                  width: double.infinity,
                  height: size.height,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: size.height * 0.03),
                              Image.asset(
                                "assets/images/brif.png",
                                height: size.height * 0.2,
                              ),
                              RoundedInputField(
                                hintText: "Username",
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Username is Required!";
                                  } else if (_flag == false) {
                                    _flag = true;
                                    return handler();
                                  } else {
                                    return null;
                                  }
                                },
                                controller: myUsernameController,
                              ),
                              RoundedPasswordField(
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password is Required!";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: myPasswordController,
                              ),
                              RoundedInputFieldPhoneNumber(
                                hintText: "Phone: (08xxxx)",
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Nomor Handphone is Required!";
                                  } else if (!RegExp(
                                    r"^0[1-9]{1}\d{1}[\s-]?\d{4}[\s-]?\d{0,6}$",
                                    caseSensitive: false,
                                    multiLine: false,
                                  ).hasMatch(value)) {
                                    return "Format Nomor Hp Salah!";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: myPhoneNumberController,
                              ),
                              NewDropdown(
                                validator: (value) {
                                  if (value == null) {
                                    return "Kode Cabang";
                                  } else {
                                    return null;
                                  }
                                },
                                val: kodecabang,
                                items: kodeCabang,
                                dd_label: "-- Kode Cabang --",
                                label: "-- Kode Cabang --",
                                onChanged: (value) async {
                                  setState(() {
                                    kodecabang = value;
                                    if (kodecabang == "JAKARTA HO2") {
                                      input_kodecabang = "007";
                                    } else if (kodecabang ==
                                        "KC WEST JAKARTA") {
                                      input_kodecabang = "008";
                                    } else if (kodecabang == "KC BEKASI") {
                                      input_kodecabang = "009";
                                    } else if (kodecabang == "KC BANDUNG") {
                                      input_kodecabang = "003";
                                    } else if (kodecabang == "KC SURABAYA") {
                                      input_kodecabang = "002";
                                    } else if (kodecabang == "KC MEDAN") {
                                      input_kodecabang = "005";
                                    } else if (kodecabang == "KC SAMARINDA") {
                                      input_kodecabang = "004";
                                    } else if (kodecabang == "KC BALIKPAPAN") {
                                      input_kodecabang = "010";
                                    } else if (kodecabang == "KC SOLO") {
                                      input_kodecabang = "011";
                                    } else if (kodecabang == "KC PALEMBANG") {
                                      input_kodecabang = "012";
                                    } else if (kodecabang == "KC MAKASAR") {
                                      input_kodecabang = "013";
                                    } else if (kodecabang == "KC DENPASAR") {
                                      input_kodecabang = "014";
                                    } else if (kodecabang == "KC SEMARANG") {
                                      input_kodecabang = "015";
                                    } else if (kodecabang == "KKC PEKANBARU") {
                                      input_kodecabang = "016";
                                    } else if (kodecabang == "KP BANJARMASIN") {
                                      input_kodecabang = "017";
                                    } else if (kodecabang == "KC MALANG") {
                                      input_kodecabang = "018";
                                    } else if (kodecabang == "KP CIREBON") {
                                      input_kodecabang = "019";
                                    } else if (kodecabang ==
                                        "KC BANDAR LAMPUNG") {
                                      input_kodecabang = "020";
                                    } else if (kodecabang == "KC DEPOK") {
                                      input_kodecabang = "021";
                                    } else if (kodecabang == "KC BSD") {
                                      input_kodecabang = "022";
                                    } else if (kodecabang == "KC BANYUWANGI") {
                                      input_kodecabang = "023";
                                    } else if (kodecabang == "KC MANADO") {
                                      input_kodecabang = "029";
                                    } else if (kodecabang == "KC YOGYAKARTA") {
                                      input_kodecabang = "028";
                                    } else if (kodecabang == "KC BOGOR") {
                                      input_kodecabang = "027";
                                    } else if (kodecabang == "KC PONTIANAK") {
                                      input_kodecabang = "026";
                                    } else if (kodecabang ==
                                        "KP KELAPA GADING") {
                                      input_kodecabang = "025";
                                    } else if (kodecabang == "KP PADANG") {
                                      input_kodecabang = "030";
                                    } else if (kodecabang ==
                                        "KP PONDOK INDAH") {
                                      input_kodecabang = "033";
                                    } else if (kodecabang == "KP KOTA") {
                                      input_kodecabang = "034";
                                    } else if (kodecabang == "KP MANGGA DUA") {
                                      input_kodecabang = "035";
                                    } else if (kodecabang == "KP KLENDER") {
                                      input_kodecabang = "036";
                                    } else if (kodecabang == "KP PLUIT") {
                                      input_kodecabang = "037";
                                    } else if (kodecabang == "KP CIBUBUR") {
                                      input_kodecabang = "038";
                                    } else if (kodecabang == "KP SERANG") {
                                      input_kodecabang = "039";
                                    } else if (kodecabang == "KP CIKUPA") {
                                      input_kodecabang = "040";
                                    } else if (kodecabang == "KP CIKARANG") {
                                      input_kodecabang = "041";
                                    } else if (kodecabang == "KP KARAWANG") {
                                      input_kodecabang = "042";
                                    } else if (kodecabang == "KP CIMAHI") {
                                      input_kodecabang = "043";
                                    } else if (kodecabang == "KP BATAM") {
                                      input_kodecabang = "044";
                                    } else if (kodecabang == "KP JAMBI") {
                                      input_kodecabang = "045";
                                    } else if (kodecabang == "KP SIDOARJO") {
                                      input_kodecabang = "046";
                                    } else if (kodecabang == "KP JEMBER") {
                                      input_kodecabang = "047";
                                    } else {
                                      input_kodecabang = "999";
                                    }
                                  });
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 16, bottom: 20),
                                child: RoundedButton(
                                  text: "LOGIN",
                                  color: Color(0xff004993),
                                  textColor: Colors.white,
                                  c_width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  press: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      print(
                                          "nUsername: " + nUsername.toString());
                                      setState(() {
                                        hasInternet;
                                      });
                                      print(hasInternet);

                                      nUsername = myUsernameController.text;
                                      nPassword = myPasswordController.text;
                                      nPhoneNumber =
                                          myPhoneNumberController.text;

                                      savePref(nUsername!, input_kodecabang!);
                                      print(nUsername);
                                      print(nPassword);
                                      print(nPhoneNumber);
                                      print(input_kodecabang);

                                      login(nUsername!, nPassword!,
                                          nPhoneNumber!, context);
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: size.height * 0.05),
                              Text(
                                "Version ${getVersion}",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "SF",
                                    fontSize: 14,
                                    color: Color(0xff004993)),
                              ),

                              //                         Padding(
                              //                           padding:
                              //                               const EdgeInsets.only(top: 1, bottom: 100),
                              //                           child: RoundedButton(
                              //                             text: "Register",
                              //                             color: Color.fromARGB(255, 185, 6, 6),
                              //                             textColor: Colors.white,
                              //                             c_width:
                              //                                 MediaQuery.of(context).size.width * 0.8,
                              //                             press: () {
                              //   Navigator.push(
                              //       context, MaterialPageRoute(builder: (context) => SignUpPage()));
                              // },
                              //                           ),
                              //                         ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        );
      case LoginStatus.signIn_LO:
        return MainMenu();
      case LoginStatus.signIn_BM:
        return MainMenu();
      case LoginStatus.signIn_CRDSTAFF:
        return MainMenu();
      case LoginStatus.signIn_CRDGH:
        return MainMenu();
      case LoginStatus.signIn_BOD:
        return MainMenu();
    }
  }

  void _showToast(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      getVersion = info.version;
    });
  }
}
