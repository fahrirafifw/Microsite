import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:microsite/beranda.dart';
import 'package:microsite/components/new_dropdown.dart';
import 'package:microsite/constant.dart';
import 'package:microsite/login.dart';
import 'package:microsite/rounded_button.dart';
import 'package:microsite/rounded_input_field.dart';
import 'package:microsite/rounded_input_field_email.dart';
import 'package:microsite/rounded_input_field_phone.dart';
import 'package:microsite/rounded_input_field_username.dart';
import 'package:microsite/rounded_password_field.dart';
import 'package:microsite/test.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key ?key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final myUsernameController = TextEditingController();
  final myNameController = TextEditingController();
  final myEmailController = TextEditingController();
  final myNomorhpController = TextEditingController();
  final myPasswordController = TextEditingController();
  String? nNama, nUsername,nEmail,nNomorhp,nPassword,result,kodecabang,input_kodecabang;
  String? usr_name,
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
      
      Message;
  int? role_value;
  final kodeCabang = ['JAKARTA HO2', 'KC WEST JAKARTA', 'KC BEKASI', 'KC BANDUNG', 'KC SURABAYA', 'KC MEDAN', 'KC SAMARINDA','KC BALIKPAPAN','KC SOLO',
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
  final _formKey = GlobalKey<FormState>();
  bool _flag = true;
  @override
  void dispose() {
    myNameController.dispose();
    myUsernameController.dispose();
    myEmailController.dispose();
    myNomorhpController.dispose();
    myPasswordController.dispose();

    super.dispose();
  }
  savePref(
      int value,
      String usr_name,
      String role_code,
      String role_name,
      String employee_name,
      String address,
      String email,
      String office_name,
      String office_code,
      String supervisor,
      String emp_no,
      String ref_office_id,
      String job_title_name,
      String job_title_code,
      String area) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      // preferences.setInt("result", value);
      preferences.setInt("value", value);
      preferences.setString("username", usr_name);
      preferences.setString("role_code", role_code);
      preferences.setString("role_name", role_name);
      preferences.setString("employee_name", employee_name);
      preferences.setString("address", address);
      preferences.setString("email", email);
      preferences.setString("office_name", office_name);
      preferences.setString("office_code", office_code);
      preferences.setString("supervisor", supervisor);
      preferences.setString("emp_no", emp_no);
      preferences.setString("ref_office_id", ref_office_id);
      preferences.setString("job_title_name", job_title_name);
      preferences.setString("job_title_code", job_title_code);
      preferences.setString("area", area);
      // preferences.commit();
    });
  }
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      role_value = preferences.getInt("value");
      usr_name = preferences.getString("username");
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

      // if (role_value == 1) {
      //   _loginStatus = LoginStatus.signIn_LO;
      // } else if (role_value == 2) {
      //   _loginStatus = LoginStatus.signIn_BM;
      // } else if (role_value == 3) {
      //   _loginStatus = LoginStatus.signIn_CRDSTAFF;
      // } else if (role_value == 5) {
      //   _loginStatus = LoginStatus.signIn_CRDGH;
      // } else if (role_value == 4) {
      //   _loginStatus = LoginStatus.signIn_BOD;
      // } else {
      //   _loginStatus = LoginStatus.notSignIn;
      // }
    });
  }

  register(String nNama, String nUsername, String nEmail, String nNomorhp, String nPassword,
      BuildContext context) async {
    try {

      // CALL API ROLECHECK
      final resp = await http.post(Uri.parse("${credit_approval_controller}registMyBrif"),
          headers: {/*"x-api-key": "${api_key}"*/},
          body: {"fullname": nNama, "password": nPassword, "username":nUsername, "email":nEmail, "no_hp":nNomorhp});

      final data3 = jsonDecode(resp.body);
      print(data3);
      if (data3['result'] == 99) {
          Message = data3['Message'];
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
      }
          else if (data3['result'] == 1) {
          Message = data3['Message'];
          Alert(
            context: context,
            type: AlertType.info,
            title: "Register Berhasil!",
            desc: Message,
            buttons: [
              DialogButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {Navigator.push(
            context, MaterialPageRoute(builder: (context) => Beranda()));},
                color: blue_brifinance,
              ),
            ],
          ).show();
        
        // role_value = data2[0]['value'];
        // usr_name = data2[0]['username'];
        // role_code = data2[0]['role_code'];
        // role_name = data2[0]['role_name'];
        // employee_name = data2[0]['employee_name'];
        // email = data2[0]['email'];
        // address = data2[0]['address'];
        // office_name = data2[0]['office_name'];
        // office_code = data2[0]['office_code'];
        // supervisor = data2[0]['supervisor'];
        // emp_no = data2[0]['emp_no'];
        // ref_office_id = data2[0]['ref_office_id'];
        // job_title_name = data2[0]['job_title_name'];
        // job_title_code = data2[0]['job_title_code'];
        // area = data2[0]['area'];
        // status = data2[0]['status'];
        // msg = data2[0]['message'];

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
      //   } else if (status == "data_found_more_than_one") {
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
      //   } else if (status == "data_found") {
      //     if (role_code == "LO") {
      //       if (supervisor == null) {
      //         supervisor = "NULL";
      //       }
      //       setState(() {
      //         print("signIn LO");
      //         _loginStatus = LoginStatus.signIn_LO;
      //         _flag = true;
      //         savePref(
      //             role_value!,
      //             usr_name!,
      //             role_code!,
      //             role_name!,
      //             employee_name!,
      //             email!,
      //             address!,
      //             office_name!,
      //             office_code!,
      //             supervisor!,
      //             emp_no!,
      //             ref_office_id!,
      //             job_title_name!,
      //             job_title_code!,
      //             area!);
      //       });
      //       _showToast(context, msg!);

      //     } else if (role_code == "CRDSTAFF") {
      //       if (supervisor == null) {
      //         supervisor = "NULL";
      //       }
      //       setState(() {
      //         _loginStatus = LoginStatus.signIn_CRDSTAFF;
      //         _flag = true;
      //         savePref(
      //             role_value!,
      //             usr_name!,
      //             role_code!,
      //             role_name!,
      //             employee_name!,
      //             email!,
      //             address!,
      //             office_name!,
      //             office_code!,
      //             supervisor!,
      //             emp_no!,
      //             ref_office_id!,
      //             job_title_name!,
      //             job_title_code!,
      //             area!);
      //       });
      //       _showToast(context, msg!);
      //     } else if (role_code == "CRDGH" || role_code == "CRDDGH") {
      //       if (supervisor == null) {
      //         supervisor = "NULL";
      //       }
      //       setState(() {
      //         _loginStatus = LoginStatus.signIn_CRDGH;
      //         _flag = true;
      //         savePref(
      //             role_value!,
      //             usr_name!,
      //             role_code!,
      //             role_name!,
      //             employee_name!,
      //             email!,
      //             address!,
      //             office_name!,
      //             office_code!,
      //             supervisor!,
      //             emp_no!,
      //             ref_office_id!,
      //             job_title_name!,
      //             job_title_code!,
      //             area!);
      //       });
      //       _showToast(context, msg!);
      //     } else if (role_code == "BM" ||
      //         role_code == "MKTUH" ||
      //         role_code == "MKTGH" ||
      //         role_code == "DCBM" ||
      //         role_code == "CBM") {
      //       if (supervisor == null) {
      //         supervisor = "NULL";
      //       }
      //       setState(() {
      //         print("signIn BM");
      //         _loginStatus = LoginStatus.signIn_BM;
      //         _flag = true;
      //         savePref(
      //             role_value!,
      //             usr_name!,
      //             role_code!,
      //             role_name!,
      //             employee_name!,
      //             email!,
      //             address!,
      //             office_name!,
      //             office_code!,
      //             supervisor!,
      //             emp_no!,
      //             ref_office_id!,
      //             job_title_name!,
      //             job_title_code!,
      //             area!);
      //       });
      //       _showToast(context, msg!);
      //     } else if (role_code == "BOD") {
      //       if (supervisor == null) {
      //         supervisor = "NULL";
      //       }
      //       setState(() {
      //         print("signIn BOD");
      //         _loginStatus = LoginStatus.signIn_BOD;
      //         _flag = true;
      //         savePref(
      //             role_value!,
      //             usr_name!,
      //             role_code!,
      //             role_name!,
      //             employee_name!,
      //             email!,
      //             address!,
      //             office_name!,
      //             office_code!,
      //             supervisor!,
      //             emp_no!,
      //             ref_office_id!,
      //             job_title_name!,
      //             job_title_code!,
      //             area!);
      //       });
      //       _showToast(context, msg!);
      //     }
      //   }
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
      }
    } catch (error) {
      _showToast(context, error.toString());
    }
  }
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }



  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xff004993),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Register Now!',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xff004993),
              
          ),

          // children: [
          //   TextSpan(
          //     text: 'ev',
          //     style: TextStyle(color: Colors.black, fontSize: 30),
          //   ),
          //   TextSpan(
          //     text: 'rnz',
          //     style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
          //   ),
          // ],
          ),
          
    );
  }

  Widget _emailPasswordWidget() {
    String? aplikasilos;
    final losaplikasi = ['Mobile Order', 'NEMO'];
    return Column(
      children: <Widget>[
                      SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: 5),
                              // SizedBox(height: size.height * 0.03),
                              RoundedInputField(
                                hintText: "Nama",
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Nama is Required!";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: myNameController,
                              ),
                              RoundedInputFieldUsername(
                                hintText: "username",
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "username is Required!";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: myUsernameController,
                              ),                              
                              RoundedInputFieldEmail(
                                hintText: "Email",
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "email is Required!";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: myEmailController,
                              ),
                              RoundedInputFieldPhone(
                                hintText: "Nomor Handphone",
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Nomor Handphone is Required!";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: myNomorhpController,
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
                              NewDropdown(
                  val: aplikasilos,
                  items: losaplikasi,
                  dd_label: "-- Aplikasi LOS --",
                  label: "-- Aplikasi LOS --",
                  onChanged: (value) {
                    try {
                      setState(() {
                        aplikasilos = value;
                      });
                      print(aplikasilos);
                    } catch (e) {
                      _showToast(context, e.toString());
                    }
                  },
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
                                  } else  if (kodecabang == "KC WEST JAKARTA") {
                                    input_kodecabang = "008";
                                  }else  if (kodecabang == "KC BEKASI") {
                                    input_kodecabang = "009";
                                  } else  if (kodecabang == "KC BANDUNG") {
                                    input_kodecabang = "003";
                                  }else  if (kodecabang == "KC SURABAYA") {
                                    input_kodecabang = "002";
                                  }
                                   else  if (kodecabang == "KC MEDAN") {
                                    input_kodecabang = "005";
                                  }else  if (kodecabang == "KC SAMARINDA") {
                                    input_kodecabang = "004";
                                  } else  if (kodecabang == "KC BALIKPAPAN") {
                                    input_kodecabang = "010";
                                  }else  if (kodecabang == "KC SOLO") {
                                    input_kodecabang = "011";
                                  } else  if (kodecabang == "KC PALEMBANG") {
                                    input_kodecabang = "012";
                                  }else  if (kodecabang == "KC MAKASAR") {
                                    input_kodecabang = "013";
                                  } else  if (kodecabang == "KC DENPASAR") {
                                    input_kodecabang = "014";
                                  }else  if (kodecabang == "KC SEMARANG") {
                                    input_kodecabang = "015";
                                  }else  if (kodecabang == "KKC PEKANBARU") {
                                    input_kodecabang = "016";
                                  }else  if (kodecabang == "KP BANJARMASIN") {
                                    input_kodecabang = "017";
                                  } else  if (kodecabang == "KC MALANG") {
                                    input_kodecabang = "018";
                                  }else  if (kodecabang == "KP CIREBON") {
                                    input_kodecabang = "019";
                                  }
                                   else  if (kodecabang == "KC BANDAR LAMPUNG") {
                                    input_kodecabang = "020";
                                  }else  if (kodecabang == "KC DEPOK") {
                                    input_kodecabang = "021";
                                  } else  if (kodecabang == "KC BSD") {
                                    input_kodecabang = "022";
                                  }else  if (kodecabang == "KC BANYUWANGI") {
                                    input_kodecabang = "023";
                                  } else  if (kodecabang == "KC MANADO") {
                                    input_kodecabang = "029";
                                  }else  if (kodecabang == "KC YOGYAKARTA") {
                                    input_kodecabang = "028";
                                  } else  if (kodecabang == "KC BOGOR") {
                                    input_kodecabang = "027";
                                  }else  if (kodecabang == "KC PONTIANAK") {
                                    input_kodecabang = "026";
                                  }else  if (kodecabang == "KP KELAPA GADING") {
                                    input_kodecabang = "025";
                                  }else  if (kodecabang == "KP PADANG") {
                                    input_kodecabang = "030";
                                  } else  if (kodecabang == "KP PONDOK INDAH") {
                                    input_kodecabang = "033";
                                  }else  if (kodecabang == "KP KOTA") {
                                    input_kodecabang = "034";
                                  }
                                   else  if (kodecabang == "KP MANGGA DUA") {
                                    input_kodecabang = "035";
                                  }else  if (kodecabang == "KP KLENDER") {
                                    input_kodecabang = "036";
                                  } else  if (kodecabang == "KP PLUIT") {
                                    input_kodecabang = "037";
                                  }else  if (kodecabang == "KP CIBUBUR") {
                                    input_kodecabang = "038";
                                  } else  if (kodecabang == "KP SERANG") {
                                    input_kodecabang = "039";
                                  }else  if (kodecabang == "KP CIKUPA") {
                                    input_kodecabang = "040";
                                  } else  if (kodecabang == "KP CIKARANG") {
                                    input_kodecabang = "041";
                                  }else  if (kodecabang == "KP KARAWANG") {
                                    input_kodecabang = "042";
                                  }else  if (kodecabang == "KP CIMAHI") {
                                    input_kodecabang = "043";
                                  }else  if (kodecabang == "KP BATAM") {
                                    input_kodecabang = "044";
                                  } else  if (kodecabang == "KP JAMBI") {
                                    input_kodecabang = "045";
                                  }else  if (kodecabang == "KP SIDOARJO") {
                                    input_kodecabang = "046";
                                  }
                                   else  if (kodecabang == "KP JEMBER") {
                                    input_kodecabang = "047";
                                  }else {
                                    input_kodecabang = "999";
                                  }
                                });
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 80),
                                child: RoundedButton(
                                  text: "Register",
                                  color: Color(0xff004993),
                                  textColor: Colors.white,
                                  c_width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  press: () async {
                                    EasyLoading.show(
                                      status: 'Loading...',
                                      maskType: EasyLoadingMaskType.black,
                                    );
                                    nNama     = myNameController.text;
                                    nUsername = myUsernameController.text;
                                    nEmail    = myEmailController.text;
                                    nNomorhp  = myNomorhpController.text;
                                    nPassword = myPasswordController.text;

                                    print(nNama);
                                    print(nUsername);
                                    print(nEmail);
                                    print(nNomorhp);
                                    print(nPassword);
                                    print(aplikasilos);
                                    


                                      register(nNama!,nUsername!, nEmail!,nNomorhp!, nPassword!,
                                              context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
      // <Widget>[
      //   _entryField("Nama"),
      //   _entryField("Email"),
      //   _entryField("Nomor Hp"),
      //   _entryField("Password", isPassword: true),
      // ],
    );
  }
  
  

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            // Positioned(
            //   top: -MediaQuery.of(context).size.height * .15,
            //   right: -MediaQuery.of(context).size.width * .4,
            //   child: BezierContainer(),
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .1),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 5,
                    ),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 30, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
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
  

