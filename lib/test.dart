import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:microsite/components/input_field.dart';
import 'package:microsite/components/new_dropdown.dart';
import 'package:microsite/constant.dart';
import 'package:microsite/login.dart';
import 'package:microsite/read_only.dart';
import 'package:microsite/rounded_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Beranda extends StatefulWidget {
  String? nik, order_number, old_order_number, role_code, branch_code;
  List? notes_and_summary_list;
  bool? is_edit_data;
  Beranda(
      {Key? key,
      this.branch_code,
      this.nik,
      this.order_number,
      this.old_order_number,
      this.is_edit_data,
      this.notes_and_summary_list,
      this.role_code})
      : super(key: key);

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  String? nilai_hc, nilai_hc_input;
  final _formKey = GlobalKey<FormState>();
  var ecNameController = TextEditingController();
  var ecAlamatController = TextEditingController();
  var ecPhoneController = TextEditingController();
  var nikController = TextEditingController();
  var namacadebController = TextEditingController();
  var tempatlahirController = TextEditingController();
  var rwSpouseController = TextEditingController();
  var rtSpouseController = TextEditingController();
  var kotaCadebController = TextEditingController();
  var maskFormatter =
      new MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});

  bool is_edit_data = false;
  Uint8List? _imgSelfieBase64;

  List<String> hubungan_cadeb = [];
  List<String> hubungan_cadeb_code = [];
  String? province_value,
      city_value,
      district_value,
      subdistrict_value,
      input_zip_code,
      spouse_subdistrict_id,
      input_spouse_zip_code,
      base64Image,
      Tenor,
      installmentype,
      installmentypecategory;
  String? nilai_area_domisili, dt_cadeb;
  String? username, jk_spouse, input_jk_spouse;
  String? provinceId, cityId, districtId, subdistrictId;
  String? kategori_id, brand_id, model_id, tipe_id, tipe_code, temp_asset1;
  String? nilai_jk,
      nilai_sp,
      input_nilaijk,
      nilai_kategori_asset,
      nilai_ab,
      nilai_am,
      nilai_ta,
      nilai_tp,
      nilai_dp_type,
      nilai_kondisi_asset,
      nilai_tenor,
      nilai_cb,
      nilai_rate,
      nilai_produk,
      nilai_tipe,
      input_nilai_tipe,
      namalengkap,
      alamatrumah,
      kodepos,
      nomorktp,
      tanggallahir,
      nomorhp,
      nilai_jenis_kelamin;
  File? imgSelfie, imgTmp;
  Image? img_selfie;
  final areaDomisili = [
    'Sumatera',
    'Jawa Tengah & Jawa Timur',
    'DKI Jakarta & Jawa Barat',
    'Lainnya'
  ];
  List<String> province = [];
  List<String> province_id = [];
  List<String> city = [];
  List<String> district = [];
  List<String> subdistrict = [];
  List<String> zip_code = [];
  bool isSelectedKomprehensif = false;
  bool isSelectedKombinasi = false;
  bool isSelectedTLO = false;
  bool isSelectedCicil = false;
  bool isSelectedTunai = false;
  bool isCityFilled = false;
  bool isDistrictFilled = false;
  bool isSubdistrictFilled = false;
  bool isSpouseCityFilled = false;
  bool isSpouseDistrictFilled = false;
  bool isSpouseSubdistrictFilled = false;
  bool showNotifBadge = false;

  var kategoriAssetController = TextEditingController();
  var assetBrandController = TextEditingController();
  var assetModelController = TextEditingController();
  var assetTipeController = TextEditingController();
  var productController = TextEditingController();
  var kondisiAssetController = TextEditingController();
  var tahunAssetController = TextEditingController();
  var assetPriceController = TextEditingController();
  var dpAmountController = TextEditingController();
  var dpPercentageController = TextEditingController();
  var ntfController = TextEditingController();
  var rateController = TextEditingController();
  var installmentController = TextEditingController();
  var productTypeController = TextEditingController();
  var hargaKendaraanController = TextEditingController();
  var persenDpController = TextEditingController();
  var dpController = TextEditingController();
  var namagadisibuCadebController = TextEditingController();
  var usr_name,
      role_name,
      employee_name,
      office_name,
      monthly,
      yearly,
      profile_picture;
  final myNomorhpsalesController = TextEditingController();
  final myNamasalesController = TextEditingController();
  final myDealernameController = TextEditingController();
  final myNameController = TextEditingController();
  final myAlamatrumahController = TextEditingController();
  var kecamatanCadebController = TextEditingController();
  final myKodeposController = TextEditingController();
  var kelurahanCadebController = TextEditingController();
  final myNomorktpController = TextEditingController();
  final myTanggallahirController = TextEditingController();
  final myNomorhpController = TextEditingController();

  final kondisi_asset = ['USED', 'NEW'];
  final jenis_kendaraan = ['MOTOR', 'MOBIL'];
  final tipe_aplikasi = ['New Car', 'Used Car', 'Refinancing'];
  final tahun_kendaraan = [
    '2023',
    '2022',
    '2021',
    '2020',
    '2019',
    '2018',
    '2017',
    '2016',
    '2015',
    '2014',
    '2013',
    '2012'
  ];
  final tenor_range = ['12', '24', '36', '48', '60', '72'];
  final dp_type = ['AMOUNT', 'PERCENTAGE'];
  final tenor = ['12', '24', '36', '48', '60', '72'];
  final jenis_kelamin = ['Male', 'Female'];
  final cara_bayar = [
    'Transfer Bank',
    'Aplikasi myBRIF',
    'BRIVA BRI',
    'Direct Debit BRI'
  ];
  final installmenttypecat = ['Advance', 'Arrear'];
  final status_pernikahan = [
    '-- Status Perkawinan --',
    'KAWIN',
    'BELUM KAWIN',
    'WIDOW/WIDOWER',
    'CERAI MATI'
  ];
  final rate = ['Effective', 'Flat'];
  final currencyFormatter = NumberFormat.currency(locale: 'ID');
  List<String> kategori_asset = [];
  List<String> kategori_asset_id = [];
  List<String> asset_brand = [];
  List<String> asset_brand_id = [];
  List<String> asset_model = [];
  List<String> asset_model_id = [];
  List<String> tipe_asset = [];
  List<String> tipe_asset_id = [];
  List<String> tipe_asset_code = [];
  List<String> produk = [];
  List<String> prod_offering_id = [];
  List<String> prod_offering_h_id = [];
  List<String> prod_offering_code = [];

  final List<Map<String, dynamic>> product_search = [];
  final List<Map<String, dynamic>> prod_offering_id_search = [];
  final List<Map<String, dynamic>> prod_offering_h_id_search = [];
  final List<Map<String, dynamic>> prod_offering_code_search = [];
  List<Map<String, dynamic>> _foundProduct = [];
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  static const _locale = 'id';
  bool isnamadealer = false;
  bool isHandphoneSales = false;
  bool isCategoryFilled = false;
  bool isBrandFilled = false;
  bool isModelFilled = false;
  bool isTipeFilled = false;
  bool isProductFilled = false;
  bool selfUsage = false;
  bool isTambah = false;
  bool isPercentage = false;
  bool isMarried = false;
  bool isUsed = false;
  bool is_inputan2_edit = false;
  bool dpamount = false;
  double percentDP = 0;
  double amountDP = 0;
  double hargaKendaraan = 0;

  @override
  void initState() {
    getProvince();
    getPref();
  }

  @override
  void dispose() {
    ecNameController.dispose();
    ecAlamatController.dispose();
    ecPhoneController.dispose();

    super.dispose();
  }

  getProvince() async {
    final response = await http
        .get(Uri.parse("${confins_controller}getProvinsi"), headers: {
      "x-api-key": "{$api_key}",
      "Content-Type": "application/json"
    });
    final data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      province.add(data[i]['NAMA_PROVINSI']);
      province_id.add(data[i]['REF_PROV_DISTRICT_ID']);
    }
    print(province);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.white)),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Formulir"),
          leading: GestureDetector(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              setState(
                () {
                  // preferences.remove("result");
                  preferences.remove("username");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext ctx) => LoginScreen()));
                },
              );
            },
            child: Icon(
              Icons.logout,
              size: 26.0, // add custom icons also
            ),
          ),
          backgroundColor: Color(0xff004993), // default is 56
        ),
        body: Stack(
          children: [],
        ),
        bottomSheet: Container(
          decoration: BoxDecoration(
            color: Color(0xff004993),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -3),
                blurRadius: 6,
                color: Colors.black54,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.85,
          width: double.infinity,
          child: form(),
        ),
      ),
      builder: EasyLoading.init(),
    );
  }

  Widget form() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                NewDropdown(
                  validator: (value) {
                    if (value == null) {
                      return "Application Type isRequired!";
                    } else {
                      return null;
                    }
                  },
                  val: nilai_tipe,
                  items: tipe_aplikasi,
                  dd_label: "-- Tipe Aplikasi --",
                  label: "-- Tipe Aplikasi --",
                  onChanged: (value) async {
                    setState(() {
                      nilai_tipe = value;
                      if (nilai_tipe == "New Car") {
                        input_nilai_tipe = "1";
                      } else if (nilai_tipe == "Used Car") {
                        input_nilai_tipe = "2";
                      } else {
                        input_nilai_tipe = "3";
                      }
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 3),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      controller: myNomorhpsalesController,
                      onChanged: (value) {},
                      readOnly: false,
                      cursorColor: Color(0xff004993),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Nomor Handphone Sales is Required!";
                        } else if (!RegExp(
                                r"^0[1-9]{1}\d{1}[\s-]?\d{4}[\s-]?\d{0,6}$")
                            .hasMatch(value)) {
                          return "Nomor Handphone Sales is not valid!";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () async {
                              try {
                                final response = await http.post(
                                  Uri.parse(
                                      "${credit_approval_controller}getInformationSales"),
                                  headers: {"Content-Type": "application/json"},
                                  body: jsonEncode({
                                    "nomorHp": myNomorhpsalesController.text,
                                  }),
                                );

                                final data = jsonDecode(response.body);
                                print("ini data:" + data.toString());

                                if (data['result'] == 1) {
                                  EasyLoading.dismiss();
                                  setState(() {
                                    isnamadealer = true;
                                    isHandphoneSales = true;
                                    myNomorhpController.text = data['nomor_hp'];
                                    myNamasalesController.text =
                                        data['nama_sales'];
                                    myDealernameController.text =
                                        data['nama_dealer'];
                                  });
                                } else {
                                  EasyLoading.dismiss();
                                  Alert(
                                    context: context,
                                    type: AlertType.error,
                                    title: "FAILED",
                                    desc:
                                        "Dealer Tidak di temukan silahkan input data",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        color: blue_brifinance,
                                      ),
                                    ],
                                  ).show();
                                }
                              } catch (e) {
                                _showToast(context, e.toString());
                              }
                              print("berhasil");
                            }),
                        hintText: "Nomor Handphone Sales",
                        hintStyle: TextStyle(
                            fontSize: 12,
                            fontFamily: "SF",
                            fontStyle: FontStyle.italic,
                            color: Color(0xffd3d3d3)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                //     InputField(
                //   label:"Nomor HandPhone Sales",
                //   hintText: "Nomor HandPhone Sales",
                //   onChanged: (value){},
                //   type: TextInputType.phone,
                //   fieldColor: Colors.white,
                //   validator: (value){
                //     if(value!.isEmpty){
                //       return "Nomor Handphones Sales is Required!";
                //     }else{
                //       return null;
                //     }
                //   },

                //   controller: myNomorhpsalesController,

                // ),
                isHandphoneSales
                    ? ReadOnlyField(
                        hintText: "Nama Sales",
                        controller: myNamasalesController)
                    : InputField(
                        label: "Nama Sales",
                        hintText: "Nama Sales",
                        onChanged: (value) {},
                        type: TextInputType.text,
                        fieldColor: Colors.white,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Nama Sales is Required!";
                          } else {
                            return null;
                          }
                        },
                        controller: myNamasalesController,
                      ),
                isnamadealer
                    ? ReadOnlyField(
                        hintText: "Nama Dealer",
                        controller: myDealernameController,
                      )
                    : InputField(
                        label: "Nama Dealer",
                        hintText: "Nama Dealer",
                        onChanged: (value) {},
                        type: TextInputType.text,
                        fieldColor: Colors.white,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Nama Dealer is Required!";
                          } else {
                            return null;
                          }
                        },
                        controller: myDealernameController,
                      ),
                InputField(
                  label: "Nomor KTP ",
                  hintText: "Nomor KTP",
                  onChanged: (value) {},
                  type: TextInputType.number,
                  fieldColor: Colors.white,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "KTP is Required!";
                    } else if (value.length < 16) {
                      return "Minimum input length is 16!";
                    } else {
                      return null;
                    }
                  },
                  controller: myNomorktpController,
                ),
                InputField(
                  label: "Nama Lengkap",
                  hintText: "Nama....",
                  onChanged: (value) {},
                  type: TextInputType.text,
                  fieldColor: Colors.white,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name is Required!";
                    } else {
                      return null;
                    }
                  },
                  controller: myNameController,
                ),

                //Karyawan bri group?
                InputField(
                  label: "Tempat Lahir",
                  hintText: "Tempat Lahir",
                  onChanged: (value) {},
                  type: TextInputType.text,
                  fieldColor: Colors.white,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Tempat Lahir is Required!";
                    } else {
                      return null;
                    }
                  },
                  controller: tempatlahirController,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 3),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      controller: myTanggallahirController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                1800), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now());

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          DateTime currentDate = DateTime.now();
                          print("Current Date: " + currentDate.toString());
                          print("Year: " + currentDate.year.toString());

                          setState(() {
                            myTanggallahirController.text =
                                formattedDate; //set output date to TextField value.

                            dt_cadeb =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(dt_cadeb);
                            var split = dt_cadeb!.split("-");
                            DateTime birthday = DateTime(int.parse(split[0]),
                                int.parse(split[1]), int.parse(split[2]));
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                      cursorColor: Color(0xff004993),
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.date_range_outlined,
                          color: Color(0xff004993),
                          size: 20,
                        ),
                        hintText: "Birth Date",
                        hintStyle: TextStyle(
                            fontSize: 12,
                            fontFamily: "SF",
                            fontStyle: FontStyle.italic,
                            color: Color(0xffd3d3d3)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                NewDropdown(
                  validator: (value) {
                    if (value == null) {
                      return "Jenis Kelamin is Required!";
                    } else {
                      return null;
                    }
                  },
                  val: jk_spouse,
                  items: jenis_kelamin,
                  dd_label: "-- Jenis Kelamin --",
                  label: "-- Jenis Kelamin --",
                  onChanged: (value) {
                    try {
                      setState(() {
                        jk_spouse = value;
                        if (jk_spouse == "PEREMPUAN") {
                          input_jk_spouse = "F";
                        } else if (nilai_jk == "LAKI-LAKI") {
                          input_jk_spouse = "M";
                        }
                      });
                    } catch (e) {
                      _showToast(context, e.toString());
                    }
                  },
                ),
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
                  controller: myAlamatrumahController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "RT is Required!";
                              } else {
                                return null;
                              }
                            },
                            controller: rtSpouseController,
                            inputFormatters: [maskFormatter],
                            cursorColor: Color(0xff004993),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "RT",
                              labelStyle: TextStyle(
                                fontSize: 12,
                                fontFamily: "SF",
                                fontStyle: FontStyle.italic,
                              ),
                              hintText: "RT",
                              hintStyle: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "SF",
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xffd3d3d3)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "/",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "SF",
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "RW is Required!";
                              } else {
                                return null;
                              }
                            },
                            controller: rwSpouseController,
                            inputFormatters: [maskFormatter],
                            cursorColor: Color(0xff004993),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "RW",
                              labelStyle: TextStyle(
                                fontSize: 12,
                                fontFamily: "SF",
                                fontStyle: FontStyle.italic,
                              ),
                              hintText: "RW",
                              hintStyle: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "SF",
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xffd3d3d3)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                NewDropdown(
                  validator: (value) {
                    if (value == null) {
                      return "Province is Required!";
                    } else {
                      return null;
                    }
                  },
                  val: province_value,
                  items: province,
                  dd_label: "-- Provinsi --",
                  label: "-- Provinsi --",
                  onChanged: (value) async {
                    try {
                      setState(() {
                        province_value = value;
                        var index_province = province.indexOf(province_value!);
                        provinceId = province_id[index_province];

                        isCityFilled = false;
                        isDistrictFilled = false;
                        isSubdistrictFilled = false;

                        city_value = null;
                        district_value = null;
                        subdistrict_value = null;
                        // kodepos.clear();

                        city.clear();
                        district.clear();
                        subdistrict.clear();
                        zip_code.clear();
                      });
                      final response = await http.post(
                        Uri.parse("${confins_controller}getKabupaten"),
                        headers: {
                          "x-api-key": "$api_key",
                          "Content-Type": "application/json"
                        },
                        body: jsonEncode({"provinsi_id": provinceId}),
                      );

                      final data = jsonDecode(response.body);

                      setState(() {
                        province_value = value;
                        for (int i = 0; i < data!.length; i++) {
                          city.add(data[i]['CITY']);
                        }
                      });
                    } catch (e) {
                      _showToast(this.context, e.toString());
                    }
                    print(province_value);
                  },
                ),
                isCityFilled
                    ? ReadOnlyField(
                        hintText: "-- City --",
                        controller: kotaCadebController,
                      )
                    : NewDropdown(
                        validator: (value) {
                          if (value == null) {
                            return "Kota is Required!";
                          } else {
                            return null;
                          }
                        },
                        val: city_value,
                        items: city,
                        dd_label: "-- Kota --",
                        label: "-- Kota --",
                        onChanged: (value) async {
                          try {
                            setState(() {
                              city_value = value;

                              district_value = null;
                              subdistrict_value = null;
                              myKodeposController.clear();

                              district.clear();
                              subdistrict.clear();
                              zip_code.clear();
                            });
                            final response = await http.post(
                              Uri.parse("${confins_controller}getKecamatan"),
                              headers: {
                                "x-api-key": "$api_key",
                                "Content-Type": "application/json"
                              },
                              body: jsonEncode({"nama_kabupaten": city_value}),
                            );

                            final data = jsonDecode(response.body);

                            setState(() {
                              city_value = value;
                              for (int i = 0; i < data!.length; i++) {
                                district.add(data[i]['KECAMATAN']);
                              }
                            });
                          } catch (e) {
                            _showToast(this.context, e.toString());
                          }

                          print(city_value);
                        },
                      ),
                isDistrictFilled
                    ? ReadOnlyField(
                        hintText: "-- Kecamatan --",
                        controller: kecamatanCadebController,
                      )
                    : NewDropdown(
                        validator: (value) {
                          if (value == null) {
                            return "Kecamatan is Required!";
                          } else {
                            return null;
                          }
                        },
                        val: district_value,
                        items: district,
                        dd_label: "-- Kecamatan --",
                        label: "-- Kecamatan --",
                        onChanged: (value) async {
                          try {
                            setState(() {
                              district_value = value;

                              subdistrict_value = null;
                              myKodeposController.clear();

                              subdistrict.clear();
                              zip_code.clear();
                            });
                            final response = await http.post(
                              Uri.parse("${confins_controller}getKelurahan"),
                              headers: {
                                // ignore: unnecessary_string_interpolations
                                "x-api-key": "$api_key",
                                "Content-Type": "application/json"
                              },
                              body: jsonEncode({
                                "nama_kabupaten": city_value,
                                "nama_kecamatan": district_value
                              }),
                            );

                            final data = jsonDecode(response.body);

                            setState(() {
                              district_value = value;
                              for (int i = 0; i < data!.length; i++) {
                                subdistrict.add(data[i]['KELURAHAN']);
                                zip_code.add(data[i]['ZIPCODE']);
                              }
                              print(subdistrict);
                            });
                          } catch (e) {
                            _showToast(this.context, e.toString());
                          }
                        },
                      ),
                isSubdistrictFilled
                    ? ReadOnlyField(
                        hintText: "-- Subdistrict --",
                        controller: kelurahanCadebController,
                      )
                    : NewDropdown(
                        validator: (value) {
                          if (value == null) {
                            return "Kelurahan is Required!";
                          } else {
                            return null;
                          }
                        },
                        val: subdistrict_value,
                        items: subdistrict,
                        dd_label: "-- Kelurahan --",
                        label: "-- Kelurahan --",
                        onChanged: (value) {
                          try {
                            setState(() {
                              subdistrict_value = value;

                              var index_subdistrict =
                                  subdistrict.indexOf(subdistrict_value!);
                              input_zip_code = zip_code[index_subdistrict];
                              myKodeposController.text =
                                  input_zip_code.toString();
                            });
                          } catch (e) {
                            _showToast(this.context, e.toString());
                          }
                        }),
                InputField(
                  label: "Kode Pos Alamat Rumah ",
                  hintText: "Kode Pos Alamat Rumah",
                  onChanged: (value) {},
                  type: TextInputType.number,
                  fieldColor: Colors.white,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Kode Pos Alamat Rumah is Required!";
                    } else {
                      return null;
                    }
                  },
                  controller: myKodeposController,
                ),
                NewDropdown(
                  validator: (value) {
                    if (value == null) {
                      return "Status Pernikahan is Required!";
                    } else {
                      return null;
                    }
                  },
                  val: nilai_sp,
                  items: status_pernikahan,
                  dd_label: "-- Status Pernikahan --",
                  label: "-- Status Pernikahan --",
                  onChanged: (value) {
                    try {
                      setState(() {
                        nilai_sp = value;
                        if (nilai_sp == 'KAWIN') {
                          isMarried = true;
                        } else {
                          isMarried = false;
                        }
                      });
                    } catch (e) {
                      _showToast(context, e.toString());
                    }
                  },
                ),
                InputField(
                  label: "Nama Ibu Kandung",
                  hintText: "Nama Ibu Kandung",
                  onChanged: (value) {},
                  fieldColor: Colors.white,
                  type: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nama Ibu Kandung is Required!";
                    } else {
                      return null;
                    }
                  },
                  controller: namagadisibuCadebController,
                ),

                InputField(
                  label: "Nomor Handphone",
                  hintText: "Phone Number (0851xxxx)",
                  onChanged: (value) {},
                  type: TextInputType.phone,
                  fieldColor: Colors.white,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nomor Handphone is Required!";
                    } else if (!RegExp(
                            r"^0[1-9]{1}\d{1}[\s-]?\d{4}[\s-]?\d{0,6}$")
                        .hasMatch(value)) {
                      return "Format Nomor Hp Salah!";
                    } else {
                      return null;
                    }
                  },
                  controller: myNomorhpController,
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 10, right: 16),
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        mainAxisExtent: 100,
                        childAspectRatio: 1,
                      ),
                      children: [
                        imgSelfie == null
                            ? GestureDetector(
                                onTap: () async {
                                  try {
                                    final image = await ImagePicker().pickImage(
                                        source: ImageSource.camera,
                                        imageQuality: 25);
                                    if (image == null) return;

                                    // crop the image
                                    final croppedImage =
                                        await ImageCropper().cropImage(
                                      sourcePath: image.path,
                                      aspectRatioPresets: [
                                        CropAspectRatioPreset.square,
                                        CropAspectRatioPreset.ratio3x2,
                                        CropAspectRatioPreset.original,
                                        CropAspectRatioPreset.ratio4x3,
                                        CropAspectRatioPreset.ratio16x9
                                      ],
                                      androidUiSettings: AndroidUiSettings(
                                          toolbarTitle: 'Crop Image',
                                          toolbarColor: Colors.deepOrange,
                                          toolbarWidgetColor: Colors.white,
                                          initAspectRatio:
                                              CropAspectRatioPreset.original,
                                          lockAspectRatio: false),
                                      iosUiSettings: IOSUiSettings(
                                        title: 'Crop Image',
                                      ),
                                    );

                                    final imgTmp = croppedImage != null
                                        ? File(croppedImage.path)
                                        : null;
                                    setState(() {
                                      imgSelfie = imgTmp;
                                      print(imgSelfie.toString());
                                    });
                                  } on PlatformException catch (e) {
                                    print(e);
                                  }
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffe2e2e2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.camera_alt_rounded,
                                          color: Color(0xff575757),
                                          size: 20,
                                        ),
                                        Text(
                                          "Foto KTP",
                                          style: TextStyle(
                                            color: Color(0xff575757),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            fontFamily: "SF",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Stack(
                                children: [
                                  Image.file(
                                    imgSelfie!,
                                    width: 400,
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          imgSelfie = null;
                                        });
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   child: Column(
                //     children: [Padding(padding: const EdgeInsets.only(top: 12),
                //     child: Text("Jenis Kelamin",
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "SF",
                //             fontSize: 15,
                //             color: Colors.white),),)]),
                // ),
                NewDropdown(
                  validator: (value) {
                    if (value == null) {
                      return "Jenis Kelamin is Required!";
                    } else {
                      return null;
                    }
                  },
                  val: nilai_jenis_kelamin,
                  items: jenis_kelamin,
                  dd_label: "-- Jenis Kelamin --",
                  label: "-- Jenis Kelamin --",
                  onChanged: (value) async {
                    setState(() {
                      nilai_jenis_kelamin = value;
                    });
                  },
                ),
                NewDropdown(
                  validator: (value) {
                    if (value == null) {
                      return "Jenis Kendaraan is Required!";
                    } else {
                      return null;
                    }
                  },
                  val: nilai_jk,
                  items: jenis_kendaraan,
                  dd_label: "-- Jenis Kendaraan --",
                  label: "-- Jenis Kendaraan --",
                  onChanged: (value) async {
                    try {
                      kategori_asset.clear();
                      kategori_asset_id.clear();
                      asset_brand.clear();
                      asset_brand_id.clear();
                      asset_model.clear();
                      asset_model_id.clear();
                      tipe_asset.clear();
                      tipe_asset_id.clear();
                      tipe_asset_code.clear();

                      product_search.clear();
                      productController.clear();
                      if (value == 'MOTOR') {
                        temp_asset1 = '12';
                      } else if (value == 'MOBIL') {
                        temp_asset1 = '11';
                      }

                      print("temp asset: " + temp_asset1!);
                      print(widget.branch_code);

                      //LOAD ASSET CATEGORY
                      final response = await http.post(
                        Uri.parse("${confins_controller}getAssetCategory"),
                        headers: {
                          "x-api-key": "$api_key",
                          "Content-Type": "application/json"
                        },
                        body: jsonEncode(
                            {"asset_type_id": int.parse(temp_asset1!)}),
                      );

                      final data = jsonDecode(response.body);

                      for (int i = 0; i < data!.length; i++) {
                        kategori_asset.add(data[i]['ASSET_CATEGORY_NAME']);
                        kategori_asset_id.add(data[i]['ASSET_CATEGORY_ID']);
                      }
                      setState(() {
                        isCategoryFilled = false;
                        isProductFilled = false;
                        nilai_kategori_asset = null;
                        nilai_produk = null;
                      });

                      //LOAD PRODUCT
                      final response_product = await http.post(
                        Uri.parse("${confins_controller}getProduct"),
                        headers: {
                          "x-api-key": "$api_key",
                          "Content-Type": "application/json"
                        },
                        body: jsonEncode({
                          "branch_code": widget.branch_code,
                          "asset_type_id": temp_asset1
                        }),
                      );

                      final data_product = jsonDecode(response_product.body);

                      setState(() {
                        for (int i = 0; i < data_product!.length; i++) {
                          product_search.add(data_product[i]);
                          // prod_offering_id_search
                          //     .add(data_product[i]['PROD_OFFERING_ID']);
                          // prod_offering_h_id_search
                          //     .add(data_product[i]['PROD_OFFERING_H_ID']);
                          // prod_offering_code_search
                          //     .add(data_product[i]['PROD_OFFERING_CODE']);
                        }
                        _foundProduct = product_search;
                        print(_foundProduct);

                        nilai_jk = value;
                        nilai_kategori_asset = null;
                        nilai_ab = null;
                        nilai_am = null;
                        nilai_ta = null;
                        nilai_produk = null;

                        isCategoryFilled = false;
                        isBrandFilled = false;
                        isModelFilled = false;
                        isTipeFilled = false;
                      });
                    } catch (e) {
                      _showToast(context, e.toString());
                    }
                  },
                ),
                NewDropdown(
                  validator: (value) {
                    if (value == null) {
                      return "Asset Category is Required!";
                    } else {
                      return null;
                    }
                  },
                  val: nilai_kategori_asset,
                  items: kategori_asset,
                  dd_label: "-- Kategori Kendaraan --",
                  label: "-- Kategori Kendaraan --",
                  onChanged: (value) async {
                    try {
                      print("asset category: " + value.toString());
                      asset_brand.clear();
                      asset_brand_id.clear();
                      asset_model.clear();
                      asset_model_id.clear();
                      tipe_asset.clear();
                      tipe_asset_id.clear();
                      tipe_asset_code.clear();

                      setState(() {
                        nilai_kategori_asset = value;
                        var index_kategori =
                            kategori_asset.indexOf(nilai_kategori_asset!);
                        kategori_id = kategori_asset_id[index_kategori];
                        nilai_ab = null;
                        nilai_am = null;
                        nilai_ta = null;
                      });

                      print('selected category id: ' + kategori_id.toString());

                      final response = await http.post(
                        Uri.parse("${confins_controller}getAssetBrand"),
                        headers: {
                          "x-api-key": "$api_key",
                          "Content-Type": "application/json"
                        },
                        body:
                            jsonEncode({"asset_category_id": "${kategori_id}"}),
                      );

                      final data = jsonDecode(response.body);

                      print(data);

                      for (int i = 0; i < data!.length; i++) {
                        asset_brand.add(data[i]['BRAND_NAME']);
                        asset_brand_id.add(data[i]['BRAND_ID']);
                      }

                      setState(() {
                        isBrandFilled = false;
                        nilai_ab = null;
                      });
                    } catch (e) {
                      _showToast(context, e.toString());
                    }
                    print(nilai_kategori_asset);
                    print(kategori_id);
                  },
                ),
                NewDropdown(
                  validator: (value) {
                    if (value == null) {
                      return "Asset Brand/Asset Name is Required!";
                    } else {
                      return null;
                    }
                  },
                  val: nilai_ab,
                  items: asset_brand,
                  dd_label: "-- Merk Kendaraan --",
                  label: "-- Merk Kendaraan --",
                  onChanged: (value) async {
                    try {
                      print("asset brand: " + value.toString());
                      asset_model.clear();
                      asset_model_id.clear();
                      tipe_asset.clear();
                      tipe_asset_id.clear();
                      tipe_asset_code.clear();

                      setState(() {
                        nilai_ab = value;
                        var index_brand = asset_brand.indexOf(nilai_ab!);
                        brand_id = asset_brand_id[index_brand];
                        nilai_am = null;
                        nilai_ta = null;
                      });

                      print('selected brand id: ' + brand_id.toString());

                      final response = await http.post(
                        Uri.parse("${confins_controller}getAssetModel"),
                        headers: {
                          "x-api-key": "$api_key",
                          "Content-Type": "application/json"
                        },
                        body: jsonEncode({
                          "asset_category_id": "${kategori_id}",
                          "brand_id": "${brand_id}"
                        }),
                      );

                      final data = jsonDecode(response.body);

                      print(data);

                      for (int i = 0; i < data!.length; i++) {
                        asset_model.add(data[i]['MODEL_NAME']);
                        asset_model_id.add(data[i]['MODEL_ID']);
                      }

                      setState(() {
                        isModelFilled = false;
                        nilai_am = null;
                      });
                    } catch (e) {
                      _showToast(context, e.toString());
                    }
                    print(nilai_ab);
                    print(brand_id);
                  },
                ),
                NewDropdown(
                  validator: (value) {
                    if (value == null) {
                      return "Asset Model is Required!";
                    } else {
                      return null;
                    }
                  },
                  val: nilai_am,
                  items: asset_model,
                  dd_label: "-- Model Kendaraan --",
                  label: "-- Model Kendaraan --",
                  onChanged: (value) async {
                    try {
                      print("asset brand: " + value.toString());
                      tipe_asset.clear();
                      tipe_asset_id.clear();
                      tipe_asset_code.clear();

                      setState(() {
                        nilai_am = value;
                        var index_model = asset_model.indexOf(nilai_am!);
                        model_id = asset_model_id[index_model];
                        nilai_ta = null;
                      });

                      print('selected model id: ' + model_id.toString());

                      final response = await http.post(
                        Uri.parse("${confins_controller}getAssetTipe"),
                        headers: {
                          "x-api-key": "$api_key",
                          "Content-Type": "application/json"
                        },
                        body: jsonEncode({
                          "asset_category_id": "${kategori_id}",
                          "brand_id": "${brand_id}",
                          "model_id": "${model_id}"
                        }),
                      );

                      final data = jsonDecode(response.body);

                      print(data);

                      for (int i = 0; i < data!.length; i++) {
                        tipe_asset.add(data[i]['ASSET_TYPE']);
                        tipe_asset_id.add(data[i]['ASSET_MASTER_ID']);
                        tipe_asset_code.add(data[i]['ASSET_CODE']);
                      }

                      setState(() {
                        isTipeFilled = false;
                        nilai_ta = null;
                      });
                    } catch (e) {
                      _showToast(context, e.toString());
                    }
                    print(nilai_am);
                    print(model_id);
                  },
                ),
                NewDropdown(
                  validator: (value) {
                    if (value == null) {
                      return "Asset Type is Required!";
                    } else {
                      return null;
                    }
                  },
                  val: nilai_ta,
                  items: tipe_asset,
                  dd_label: "-- Tipe Kendaraan --",
                  label: "-- Tipe Kendaraan --",
                  onChanged: (value) {
                    try {
                      print("asset model: " + value.toString());

                      setState(() {
                        nilai_ta = value;
                        var index_tipe = tipe_asset.indexOf(nilai_ta!);
                        tipe_id = tipe_asset_id[index_tipe];
                        tipe_code = tipe_asset_code[index_tipe];
                      });

                      print('selected tipe id: ' + tipe_id.toString());
                    } catch (e) {
                      _showToast(context, e.toString());
                    }

                    print(nilai_ta);
                    print(tipe_id);
                    print(tipe_code);
                  },
                ),
                NewDropdown(
                  validator: (value) {
                    if (value == null) {
                      return "Tahun Kendaraan is Required!";
                    } else {
                      return null;
                    }
                  },
                  val: nilai_tp,
                  items: tahun_kendaraan,
                  dd_label: "-- Tahun Kendaraan --",
                  label: "-- Tahun Kendaraan --",
                  onChanged: (value) {
                    try {
                      print("asset model: " + value.toString());

                      setState(() {
                        nilai_tp = value;
                        var index_tipe = tipe_asset.indexOf(nilai_tp!);
                        tipe_id = tipe_asset_id[index_tipe];
                        tipe_code = tipe_asset_code[index_tipe];
                      });

                      print('selected tipe id: ' + tipe_id.toString());
                    } catch (e) {
                      _showToast(context, e.toString());
                    }
                    print(nilai_tp);
                    print(tipe_id);
                    print(tipe_code);
                  },
                ),
                NewDropdown(
                  validator: (value) {
                    if (value == null) {
                      return "Tenor is Required!";
                    } else {
                      return null;
                    }
                  },
                  val: Tenor,
                  items: tenor_range,
                  dd_label: "-- Tenor --",
                  label: "-- Tenor --",
                  onChanged: (value) {
                    Tenor = value;
                    print(Tenor);
                  },
                ),
                NewDropdown(
                  validator: (value) {
                    if (value == null) {
                      return "First Installment Type is Required!";
                    } else {
                      return null;
                    }
                  },
                  val: installmentype,
                  items: installmenttypecat,
                  dd_label: "-- First Installment Type --",
                  label: "-- First Installment Type --",
                  onChanged: (value) {
                    try {
                      if (value == 'Advance') {
                        installmentypecategory = '1';
                      } else {
                        installmentypecategory = '2';
                      }
                    } catch (e) {
                      _showToast(context, e.toString());
                    }
                  },
                ),
                InputField(
                  label: "Harga Kendaraan",
                  hintText: "Harga Kendaraan",
                  decoration: InputDecoration(prefixText: _currency),
                  onChanged: (value) {
                    // value = '${_formatNumber(value.replaceAll('.', ''))}';

                    hargaKendaraanController.value = TextEditingValue(
                      text: value,
                      selection: TextSelection.collapsed(offset: value.length),
                    );

                    String temp_val = value.replaceAll(".", "");
                    setState(() {
                      print("temp val: " + temp_val);
                      hargaKendaraan = double.parse(temp_val);
                    });
                    if (amountDP != 0) {
                      print("amount DP: " + amountDP.toString());
                      calculateAmount(double.parse(persenDpController.text));
                    }
                  },
                  fieldColor: Colors.white,
                  type: TextInputType.number,
                  validator: (value) {},
                  controller: hargaKendaraanController,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: InputField(
                          label: "DP (%)",
                          hintText: "DP (%)",
                          onChanged: (value) {
                            print("value persen: " + value);
                            calculateAmount(double.parse(value));
                          },
                          fieldColor: Colors.white,
                          type: TextInputType.number,
                          controller: persenDpController,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: InputField(
                          label: "DP Amount",
                          hintText: "DP Amount",
                          onChanged: (value) {
                            value =
                                '${_formatNumber(value.replaceAll('.', ''))}';
                            dpController.value = TextEditingValue(
                              text: value,
                              selection:
                                  TextSelection.collapsed(offset: value.length),
                            );

                            String temp_val = value.replaceAll(".", "");
                            calculatePercent(double.parse(temp_val));
                            dpamount = true;
                          },
                          fieldColor: Colors.white,
                          type: TextInputType.number,
                          controller: dpAmountController,

                          // controller: dpController,
                        ),
                      ),
                    ],
                  ),
                ),
                //       NewDropdown(
                //   val: nilai_area_domisili,
                //   items: areaDomisili,
                //   dd_label: "-- Domicile Area --",
                //   label: "-- Domicile Area --",
                //   onChanged: (value) {
                //     try {
                //       setState(() {
                //         nilai_area_domisili = value;
                //       });
                //     } catch (e) {
                //       _showToast(context, e.toString());
                //     }
                //   },
                // ),

                //       //Jangka waktu bulan
                //       // Harga kendaraan
                //       //DP
                //     Container(
                //   child: Column(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(top: 12),
                //         child: Text(
                //           "Insurance Type",
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontFamily: "SF",
                //               fontSize: 15,
                //               color: Colors.white),
                //         ),
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(left: 16),
                //             child: ChoiceChip(
                //               backgroundColor: Colors.white,
                //               label: Text(
                //                 "Comprehensive",
                //                 style: TextStyle(fontSize: 12),
                //               ),
                //               selected: isSelectedKomprehensif,
                //               onSelected: (bool value) {
                //                 isSelectedKomprehensif = value;
                //                 setState(() {
                //                   isSelectedKombinasi = false;
                //                   isSelectedTLO = false;
                //                 });
                //               },
                //               selectedColor: orange_brifinance,
                //             ),
                //           ),
                //           ChoiceChip(
                //             backgroundColor: Colors.white,
                //             label: Text(
                //               "TLO",
                //               style: TextStyle(fontSize: 12),
                //             ),
                //             selected: isSelectedTLO,
                //             onSelected: (bool value) {
                //               isSelectedTLO = value;
                //               setState(() {
                //                 isSelectedKomprehensif = false;
                //                 isSelectedKombinasi = false;
                //               });
                //             },
                //             selectedColor: orange_brifinance,
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(right: 16),
                //             child: ChoiceChip(
                //               backgroundColor: Colors.white,
                //               label: Text(
                //                 "Combination",
                //                 style: TextStyle(fontSize: 12),
                //               ),
                //               selected: isSelectedKombinasi,
                //               onSelected: (bool value) {
                //                 isSelectedKombinasi = value;
                //                 setState(() {
                //                   isSelectedKomprehensif = false;
                //                   isSelectedTLO = false;
                //                 });
                //               },
                //               selectedColor: orange_brifinance,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                //  Container(
                //   child: Column(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(top: 12),
                //         child: Text(
                //           "Insurance Payment",
                //           textAlign: TextAlign.start,
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontFamily: "SF",
                //               fontSize: 15,
                //               color: Colors.white),
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(left: 100, right: 100),
                //         child: Row(
                //           children: [
                //             ChoiceChip(
                //               backgroundColor: Colors.white,
                //               label: Text(
                //                 "Installment",
                //                 style: TextStyle(fontSize: 12),
                //               ),
                //               selected: isSelectedCicil,
                //               onSelected: (bool value) {
                //                 isSelectedCicil = value;
                //                 setState(() {
                //                   isSelectedTunai = false;
                //                 });
                //               },
                //               selectedColor: orange_brifinance,
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.only(left: 12),
                //               child: ChoiceChip(
                //                 backgroundColor: Colors.white,
                //                 label: Text(
                //                   "Cash",
                //                   style: TextStyle(fontSize: 12),
                //                 ),
                //                 selected: isSelectedTunai,
                //                 onSelected: (bool value) {
                //                   isSelectedTunai = value;
                //                   setState(() {
                //                     isSelectedCicil = false;
                //                   });
                //                 },
                //                 selectedColor: orange_brifinance,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                    child: RoundedButton(
                      text: "PROSES",
                      c_width: double.infinity,
                      press: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          EasyLoading.show(
                            status: 'Loading...',
                            maskType: EasyLoadingMaskType.black,
                          );
                          inputAssetData(context);
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          String? usr_name = preferences.getString("username");
                          String? brch_code =
                              preferences.getString("branch_code");
                          String asset_name =
                              "${nilai_ab} ${nilai_am} ${nilai_ta}";
                          print(namagadisibuCadebController);
                          print(subdistrict_value);
                          print(district_value);
                          print(city_value);
                          print(input_nilai_tipe);
                          print(myNomorhpsalesController.text);
                          print(myNamasalesController.text);
                          print(myDealernameController.text);
                          print(myNameController.text);
                          print(myAlamatrumahController.text);
                          print(myKodeposController.text);
                          print(myNomorktpController.text);
                          print(myTanggallahirController.text);
                          print(myNomorhpController.text);
                          print(usr_name);
                          print(nilai_jenis_kelamin);
                          print(nilai_ab);
                          print(hargaKendaraan);
                          print(dpAmountController.text);
                          print(asset_name);
                          print(brch_code);
                          print(Tenor);
                          print(installmentypecategory);
                          // if (_formKey.currentState!.validate()) {
                          //   // calculateAllData(context);
                          // }
                        }
                      },
                      color: orange_brifinance,
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
  //inputDataCadeb(BuildContext context) async {
  //   String asset_name = "${nilai_ab} ${nilai_am} ${nilai_ta}";
  //   var request = http.MultipartRequest(
  //       "POST", Uri.parse("${credit_approval_controller}formMyBrif"));
  //   request.fields["applicationType"] = input_nilai_tipe.toString();
  //   request.fields["nomorHpSales"] = myNomorhpsalesController.text.toString();
  //   request.fields["namaSales"] = myNamasalesController.text.toString();
  //   request.fields["namaDealer"] = myDealernameController.text.toString();
  //   request.fields["customerName"] = myNameController.text.toString();
  //   request.fields["homeAddress"] = myAlamatrumahController.text.toString();
  //   request.fields["homeAddressPostalCode"] = myKodeposController.text.toString();
  //   request.fields["ktpNumber"] = myNomorktpController.text.toString();
  //   request.fields["dateOfBirth"] = myTanggallahirController.text.toString();
  //   request.fields["phone"] = myNomorhpController.text.toString();
  //   request.fields["username"] = "swijoyo";
  //   request.fields["gender"] = nilai_jenis_kelamin.toString();
  //   request.fields["brandCode"] = nilai_ab.toString();
  //   request.fields["amount"] =  hargaKendaraanController.text;
  //   request.fields["downPayment"] = dpAmountController.text;
  //   request.fields["assetName"] = asset_name;

  //   var response = await request.send();

  //   var responseData = await response.stream.toBytes();
  //   var responseString = String.fromCharCodes(responseData);
  //   print(responseString);
  //   print("test");

  //   if (responseString.contains("1")) {
  //    EasyLoading.dismiss();
  //         Alert(
  //           context: context,
  //           type: AlertType.success,
  //           title: "SUCCESS",
  //           desc: "Data successfully saved",
  //           buttons: [
  //             DialogButton(
  //               child: Text(
  //                 "OK",
  //                 style: TextStyle(color: Colors.white, fontSize: 20),
  //               ),
  //               onPressed: () => Navigator.pop(this.context),
  //               color: blue_brifinance,
  //             ),
  //           ],
  //         ).show();
  //   } else {
  //     EasyLoading.dismiss();
  //     Alert(
  //         context: this.context,
  //         type: AlertType.error,
  //         title: "ERROR",
  //         desc: "Gagal",
  //         buttons: [
  //           DialogButton(
  //             child: Text(
  //               "OK",
  //               style: TextStyle(color: Colors.white, fontSize: 20),
  //             ),
  //             onPressed: () async {
  //               Navigator.pop(context);
  //             },
  //             color: blue_brifinance,
  //           ),
  //         ],
  //       ).show();
  //   }
  // }

  inputAssetData(BuildContext context) async {
    String asset_name = "${nilai_ab} ${nilai_am} ${nilai_ta}";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? usr_name = preferences.getString("username");
    String? brch_code = preferences.getString("branch_code");
    _imgSelfieBase64 = await imgSelfie!.readAsBytes();
    base64Image = base64Encode(_imgSelfieBase64!);
    print(base64Image);

    // int input_dp_amount = int.parse(dpAmountController.text.toString());
    // int input_harga_kendaraan = int.parse(hargaKendaraanController.text.toString());
    try {
      final response = await http.post(
        Uri.parse("${credit_approval_controller}formMyBrif"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "ktpNumber": myNomorktpController.text,
          "customerName": myNameController.text,
          "tempat_lahir": tempatlahirController.text,
          "dateOfBirth": myTanggallahirController.text,
          "gender": nilai_jenis_kelamin,
          "homeAddress": myAlamatrumahController.text,
          "rt": rtSpouseController.text,
          "rw": rwSpouseController.text,
          "provinsi": province_value,
          "kota": city_value,
          "kecamatan": district_value,
          "kelurahan": subdistrict_value,
          "homeAddressPostalCode": myKodeposController.text,
          "maritalStatus": nilai_sp,
          "motherMaiden": namagadisibuCadebController.text,
          "phone": myNomorhpController.text,
          "fotoKtp": base64Image,
          "nomorHpSales": myNomorhpsalesController.text,
          "namaSales": myNamasalesController.text,
          "namaDealer": myDealernameController.text,
          "amount": hargaKendaraanController.text,
          "downPayment": dpAmountController.text,
          "applicationType": input_nilai_tipe,
          "username": usr_name,
          "brandCode": nilai_ab,
          "assetName": asset_name,
          "branch_code": brch_code,
          "installmentPeriod": Tenor,
          "installmentType": installmentypecategory
        }),
      );

      final data = jsonDecode(response.body);
      print("ini data:" + data.toString());

      if (data['result'] == 1) {
        EasyLoading.dismiss();
        Alert(
          context: context,
          type: AlertType.success,
          title: "SUCCESS",
          desc: "Data successfully saved",
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () async {
                preferences.remove("username");
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) => LoginScreen()),
                    (route) => false);
              },
              color: blue_brifinance,
            ),
          ],
        ).show();
      } else if (myNomorktpController.text.toString().length < 16) {
        EasyLoading.dismiss();
        Alert(
          context: context,
          type: AlertType.warning,
          title: "WARNING",
          desc: "KTP Minimal 16 Digit",
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
      } else {
        EasyLoading.dismiss();
        Alert(
          context: context,
          type: AlertType.error,
          title: "FAILED",
          desc: "Data gagal disimpan" + data.toString(),
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
    } catch (e) {
      _showToast(context, e.toString());
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

  void calculateAmount(double percent) {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    print("harga kendaraan: " + hargaKendaraan.toString());
    print("persen yg diinput: " + percent.toString());
    setState(() {
      amountDP = (percent / 100) * hargaKendaraan;
      dpAmountController.text = amountDP.toString().replaceAll(regex, "");
      print("amount dp: " + amountDP.toString());
      print("calculate amount: " + amountDP.toString());
    });
  }

  void calculatePercent(double amount) {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

    setState(() {
      percentDP = (amount / hargaKendaraan) * 100;
      persenDpController.text =
          "${percentDP.toString().replaceAll(regex, "")}%";
      print("persen DP: " + percentDP.toString());
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      usr_name = preferences.getString("username");
    });
  }
}
