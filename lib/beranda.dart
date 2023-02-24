// import 'dart:convert';
// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:microsite/components/input_field.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:microsite/akumulasi.dart';
// import 'package:microsite/header.dart';
// import 'package:microsite/login.dart';
// import 'package:microsite/rounded_button.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../constant.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:image_picker/image_picker.dart';

// import 'components/new_dropdown.dart';

// class Beranda extends StatefulWidget {
//   String? nik, branch_code, order_number, old_order_number, role_code;
  
//   Beranda({Key? key, this.branch_code,})
//       : super(key: key);

//   @override
//   State<Beranda> createState() => _BerandaState();
// }

// class _BerandaState extends State<Beranda> {
  

//   List? notes_and_summary_list;
//   int? data_count;
//   bool? isAllEngineCheck, is_edit_data;
//   String? nilai_area_domisili;
//   String? username;
//   String? kategori_id, brand_id, model_id, tipe_id, tipe_code, temp_asset1;
//   String? nilai_jk,
//       input_nilaijk,
//       nilai_kategori_asset,
//       nilai_ab,
//       nilai_am,
//       nilai_ta,
//       nilai_tp,
//       nilai_dp_type,
//       nilai_kondisi_asset,
//       nilai_tenor,
//       nilai_cb,
//       nilai_rate,
//       nilai_produk,
//       namalengkap,
//       alamatrumah,
//       kodepos,
//       nomorktp,
//       tanggallahir,
//       nomorhp;
//   File? imgSelfie;
//   Image? img_selfie;
//   final areaDomisili = [
//     'Sumatera',
//     'Jawa Tengah & Jawa Timur',
//     'DKI Jakarta & Jawa Barat',
//     'Lainnya'
//   ];
//   final _formKey = GlobalKey<FormState>();
//   bool isSelectedKomprehensif = false;
//   bool isSelectedKombinasi = false;
//   bool isSelectedTLO = false;
//   bool isSelectedCicil = false;
//   bool isSelectedTunai = false;
  
  
//   var kategoriAssetController = TextEditingController();
//   var assetBrandController = TextEditingController();
//   var assetModelController = TextEditingController();
//   var assetTipeController = TextEditingController();
//   var productController = TextEditingController();
//   var kondisiAssetController = TextEditingController();
//   var tahunAssetController = TextEditingController();
//   var assetPriceController = TextEditingController();
//   var dpAmountController = TextEditingController();
//   var dpPercentageController = TextEditingController();
//   var ntfController = TextEditingController();
//   var rateController = TextEditingController();
//   var installmentController = TextEditingController();
//   var productTypeController = TextEditingController();
//   var hargaKendaraanController = TextEditingController();
//   var persenDpController = TextEditingController();
//   var dpController = TextEditingController();
//   var usr_name,
//       role_name,
//       employee_name,
//       office_name,
//       monthly,
//       yearly,
//       profile_picture;
//   final myNomorhpsalesController = TextEditingController();
//   final myNamasalesController = TextEditingController();
//   final  myDealernameController = TextEditingController();
//   final myNameController = TextEditingController();
//   final myAlamatrumahController = TextEditingController();
//   final myKodeposController = TextEditingController();
//   final myNomorktpController  = TextEditingController();
//   final myTanggallahirController = TextEditingController();
//   final myNomorhpController = TextEditingController();

//   final kondisi_asset = ['USED', 'NEW'];
//   final jenis_kendaraan = ['MOTOR', 'MOBIL'];
//   final jenis_kelamin = ['Female', 'Male'];
//   final tipe_aplikasi = ['New Car', 'Used Car', 'Refinancing'];
//   final tahun_kendaraan = ['2023', '2022', '2021', '2020', '2019', '2018', '2017', '2016', '2015', '2014', '2013', '2012'];
//   final dp_type = ['AMOUNT', 'PERCENTAGE'];
//   final tenor = ['12', '24', '36', '48', '60', '72'];
//   final cara_bayar = [
//     'Transfer Bank',
//     'Aplikasi myBRIF',
//     'BRIVA BRI',
//     'Direct Debit BRI'
//   ];
//   final rate = ['Effective', 'Flat'];
//   final currencyFormatter = NumberFormat.currency(locale: 'ID');
//   bool showNotifBadge = true;
//    List<String> kategori_asset = [];
//   List<String> kategori_asset_id = [];
//   List<String> asset_brand = [];
//   List<String> asset_brand_id = [];
//   List<String> asset_model = [];
//   List<String> asset_model_id = [];
//   List<String> tipe_asset = [];
//   List<String> tipe_asset_id = [];
//   List<String> tipe_asset_code = [];
//   List<String> produk = [];
//   List<String> prod_offering_id = [];
//   List<String> prod_offering_h_id = [];
//   List<String> prod_offering_code = [];

//   final List<Map<String, dynamic>> product_search = [];
//   final List<Map<String, dynamic>> prod_offering_id_search = [];
//   final List<Map<String, dynamic>> prod_offering_h_id_search = [];
//   final List<Map<String, dynamic>> prod_offering_code_search = [];
//   List<Map<String, dynamic>> _foundProduct = [];
//    String get _currency =>
//       NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
//   String _formatNumber(String s) =>
//       NumberFormat.decimalPattern(_locale).format(int.parse(s));
//   static const _locale = 'id';

//   bool isCategoryFilled = false;
//   bool isBrandFilled = false;
//   bool isModelFilled = false;
//   bool isTipeFilled = false;
//   bool isProductFilled = false;
//   bool selfUsage = false;
//   bool isTambah = false;
//   bool isPercentage = false;
//   bool isUsed = false;
//   bool is_inputan2_edit = false;
//   bool dpamount = false;
//   double percentDP = 0;
//   double amountDP = 0;
//   double hargaKendaraan = 0;

//   void initState() {
//     super.initState();
//     getPref();
//   }

//   getPref() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(() {
//       usr_name = preferences.getString("username");
//       role_name = preferences.getString("role_name");
//       employee_name = preferences.getString("employee_name");
//       office_name = preferences.getString("office_name");
//       monthly = preferences.getString("monthly_achievement");
//       yearly = preferences.getString("yearly_achievement");
//       username = preferences.getString("username");
//       profile_picture = preferences.getString("profile_picture");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//           bottomSheetTheme:
//               BottomSheetThemeData(backgroundColor: Colors.white)),
//       home: Scaffold(
//         resizeToAvoidBottomInset: false,
//           body: Stack(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.1,
//                 decoration: BoxDecoration(color: Color(0xff004993)),
//                 child: background(),
                
//               ),
//               // SafeArea(
//               //   child: Container(
//               //     width: double.infinity,
//               //     child: Padding(
//               //       padding: EdgeInsets.only(
//               //           top: MediaQuery.of(context).size.height * 0.5),
//               //       child: Column(
//               //         crossAxisAlignment: CrossAxisAlignment.center,
//               //         children: [
//               //           Container(
//               //             width: MediaQuery.of(context).size.width * 0.5,
//               //             child: Text(
//               //               "Pengajuan Form",
//               //               textAlign: TextAlign.center,
//               //               style: TextStyle(
//               //                   fontWeight: FontWeight.bold,
//               //                   fontFamily: "SF",
//               //                   fontSize: 16,
//               //                   color: const Color(0xff575757)),
//               //             ),
//               //           )
//               //         ],
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 340, top: 25),
//                 child: Positioned(
//                   top: MediaQuery.of(context).padding.top,
//                   child: IconButton(
//                     icon: Icon(Icons.logout),
//                     color: Color.fromARGB(255, 255, 255, 255),
//                     onPressed: () {
//                       Navigator.push(context, MaterialPageRoute (builder: (context) => LoginScreen()));
//                     },
//                   ),
//                 ),
//               )
//             ],
//           ),
//           bottomSheet: Container(
//             decoration: BoxDecoration(
//               color: Color(0xff004993),
//               boxShadow: [
//                 BoxShadow(
//                   offset: Offset(0, -3),
//                   blurRadius: 6,
//                   color: Colors.black54,
//                 ),
//               ],
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(30),
//                 topRight: Radius.circular(30),
//               ),
//             ),
//             height: MediaQuery.of(context).size.height * 0.8,
//             width: double.infinity,
//             child: form(),
//           )),
//       builder: EasyLoading.init(),
//     );
//   }
 
//   Widget form() {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.only(top: 5),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey, 
//           child: Container(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
//                   child: Container(decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   ),
//             ),
//             NewDropdown(
//                   validator: (value) {
//                     if (value == null) {
//                       return "Application Type isRequired!";
//                     } else {
//                       return null;
//                     }
//                   },
//                   val: nilai_jk,
//                   items: tipe_aplikasi,
//                   dd_label: "-- Tipe Aplikasi --",
//                   label: "-- Tipe Aplikasi --",
//                   onChanged: (value) async {
//                     try {
//                       kategori_asset.clear();
//                       kategori_asset_id.clear();
//                       asset_brand.clear();
//                       asset_brand_id.clear();
//                       asset_model.clear();
//                       asset_model_id.clear();
//                       tipe_asset.clear();
//                       tipe_asset_id.clear();
//                       tipe_asset_code.clear();

//                       product_search.clear();
//                       productController.clear();
//                       if (value == 'MOTOR') {
//                         temp_asset1 = '12';
//                       } else if (value == 'MOBIL') {
//                         temp_asset1 = '11';
//                       }
//                       if (nilai_jk == "New Car"){
//                         input_nilaijk ="1";
//                       } else if (nilai_jk == "Used Car"){
//                         input_nilaijk = "2";
//                       }
//                       else if(nilai_jk == "Refinancing"){
//                         input_nilaijk ="3";
//                       }

//                       print("temp asset: " + temp_asset1!);
//                       print(widget.branch_code);

//                       //LOAD ASSET CATEGORY
//                       final response = await http.post(
//                         Uri.parse("${confins_controller}getAssetCategory"),
//                         headers: {
//                           "x-api-key": "$api_key",
//                           "Content-Type": "application/json"
//                         },
//                         body: jsonEncode(
//                             {"asset_type_id": int.parse(temp_asset1!)}),
//                       );

//                       final data = jsonDecode(response.body);

//                       for (int i = 0; i < data!.length; i++) {
//                         kategori_asset.add(data[i]['ASSET_CATEGORY_NAME']);
//                         kategori_asset_id.add(data[i]['ASSET_CATEGORY_ID']);
//                       }
//                       setState(() {
//                         isCategoryFilled = false;
//                         isProductFilled = false;
//                         nilai_kategori_asset = null;
//                         nilai_produk = null;
//                       });

//                       //LOAD PRODUCT
//                       final response_product = await http.post(
//                         Uri.parse("${confins_controller}getProduct"),
//                         headers: {
//                           "x-api-key": "$api_key",
//                           "Content-Type": "application/json"
//                         },
//                         body: jsonEncode({
//                           "branch_code": widget.branch_code,
//                           "asset_type_id": temp_asset1
//                         }),
//                       );

//                       final data_product = jsonDecode(response_product.body);
                      
//                       setState(() {
//                         for (int i = 0; i < data_product!.length; i++) {
//                         product_search.add(data_product[i]);
//                         // prod_offering_id_search
//                         //     .add(data_product[i]['PROD_OFFERING_ID']);
//                         // prod_offering_h_id_search
//                         //     .add(data_product[i]['PROD_OFFERING_H_ID']);
//                         // prod_offering_code_search
//                         //     .add(data_product[i]['PROD_OFFERING_CODE']);
//                       }
//                         _foundProduct = product_search;
//                         print(_foundProduct);
                        
//                         nilai_jk = value;
//                         nilai_kategori_asset = null;
//                         nilai_ab = null;
//                         nilai_am = null;
//                         nilai_ta = null;
//                         nilai_produk = null;


//                         isCategoryFilled = false;
//                         isBrandFilled = false;
//                         isModelFilled = false;
//                         isTipeFilled = false;
//                       });
//                     } catch (e) {
//                       _showToast(context, e.toString());
//                     }
//                   },
//                 ),
//                 InputField(
//               label:"Nomor HandPhone Sales",
//               hintText: "Nomor HandPhone Sales",
//               onChanged: (value){},
//               type: TextInputType.text,
//               fieldColor: Colors.white,
//               validator: (value){
//                 if(value!.isEmpty){
//                   return "Nomor Handphones Sales is Required!";
//                 }else{
//                   return null;
//                 }
//               },
//               controller: myNomorhpsalesController,

//             ),
//             InputField(
//               label:"Nama Sales",
//               hintText: "Nama Sales",
//               onChanged: (value){},
//               type: TextInputType.text,
//               fieldColor: Colors.white,
//               validator: (value){
//                 if(value!.isEmpty){
//                   return "Nama Sales is Required!";
//                 }else{
//                   return null;
//                 }
//               },
//               controller: myNamasalesController,

//             ),
//             InputField(
//               label:"Nama Dealer",
//               hintText: "Nama Dealer",
//               onChanged: (value){},
//               type: TextInputType.text,
//               fieldColor: Colors.white,
//               validator: (value){
//                 if(value!.isEmpty){
//                   return "Nama Dealer is Required!";
//                 }else{
//                   return null;
//                 }
//               },
//               controller: myDealernameController,

//             ),
//             InputField(
//               label:"Nama Lengkap",
//               hintText: "Nama....",
//               onChanged: (value){},
//               type: TextInputType.text,
//               fieldColor: Colors.white,
//               validator: (value){
//                 if(value!.isEmpty){
//                   return "Name is Required!";
//                 }else{
//                   return null;
//                 }
//               },
//               controller: myNameController,

//             ),
            
//             //Karyawan bri group?

//             InputField(
//                     label: "Alamat Rumah",
//                     hintText: "Alamat Rumah",
//                     onChanged: (value) {},
//                     type: TextInputType.text,
//                     fieldColor: Colors.white,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Alamat is Required!";
//                       } else {
//                         return null;
//                       }
//                     },
//                     controller: myAlamatrumahController,
//                   ),
//                   InputField(
//                     label: "Kode Pos Alamat Rumah ",
//                     hintText: "Kode Pos Alamat Rumah",
//                     onChanged: (value) {},
//                     type: TextInputType.number,
//                     fieldColor: Colors.white,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Kode Pos Alamat Rumah is Required!";
//                       } else {
//                         return null;
//                       }
//                     },
//                     controller: myKodeposController,
//                   ),

//                   InputField(
//                     label: "Nomor KTP ",
//                     hintText: "Nomor KTP",
//                     onChanged: (value) {},
//                     type: TextInputType.number,
//                     fieldColor: Colors.white,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "KTP is Required!";
//                       } else {
//                         return null;
//                       }
//                     },
//                     controller: myNomorktpController,
//                   ),
//                   InputField(
//                     label: "Tanggal Lahir (YYYY-MM-DD) ",
//                     hintText: "Tanggal Lahir",
//                     onChanged: (value) {},
//                     type: TextInputType.text,
//                     fieldColor: Colors.white,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Tanggal Lahir is Required!";
//                       } else {
//                         return null;
//                       }
//                     },
                    
//                   ),

                  
//                   InputField(
//                     label: "Nomor Handphone",
//                     hintText: "Nomor Handphone",
//                     onChanged: (value) {},
//                     type: TextInputType.phone,
//                     fieldColor: Colors.white,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Nomor Handphone is Required!";
//                       } else {
//                         return null;
//                       }
//                     },
//                     controller: myNomorhpController,
//                   ),
//                   SizedBox(height: 20),
//                    SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.14,
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.only(left: 16, top: 10, right: 16),
//                     child: GridView(
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 1,
//                             crossAxisSpacing: 5,
//                             mainAxisSpacing: 5,
//                             mainAxisExtent: 100,
//                             childAspectRatio: 1),
//                         children: [
//                           imgSelfie == null
//                               ? GestureDetector(
//                                   onTap: () async {
//                                     try {
//                                       final image = await ImagePicker()
//                                           .pickImage(
//                                               source: ImageSource.camera,
//                                               imageQuality: 25);
//                                       if (image == null) return;

//                                       final imgTmp = File(image.path);
//                                       setState(() {
//                                         imgSelfie = imgTmp;
//                                       });
//                                     } on PlatformException catch (e) {
//                                       print(e);
//                                     }
//                                   },
//                                   child: Card(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             color: Color(0xffe2e2e2),
                                            
//                                             borderRadius:
//                                                 BorderRadius.circular(20)),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Icon(
//                                               Icons.camera_alt_rounded,
//                                               color: Color(0xff575757),
//                                               size: 20,
//                                             ),
//                                             Text(
//                                               "Take a Selfie",
//                                               style: TextStyle(
//                                                   color: Color(0xff575757),
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 12,
//                                                   fontFamily: "SF"),
//                                             ),
//                                           ],
//                                         ),
//                                       )),
//                                 )
//                               : Center(
//                                   // child: Image(image: img_rumahDepan,
//                                   //     width: 200),
//                                   child: Stack(
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {},
//                                         child: Image.file(
//                                           imgSelfie!,
//                                           width: 100,
//                                         ),
//                                       ),
                                      
//                                     ],
//                                   ),
//                                 ),
//                         ]),
//                   ),
//                 ),
//                   // Container(
//                   //   child: Column(
//                   //     children: [Padding(padding: const EdgeInsets.only(top: 12),
//                   //     child: Text("Jenis Kelamin",
//                   //         style: TextStyle(
//                   //             fontWeight: FontWeight.bold,
//                   //             fontFamily: "SF",
//                   //             fontSize: 15,
//                   //             color: Colors.white),),)]),
//                   // ),
//                   NewDropdown(
//                   validator: (value) {
//                     if (value == null) {
//                       return "Jenis Kelamin is Required!";
//                     } else {
//                       return null;
//                     }
//                   },
//                   val: nilai_jk,
//                   items: jenis_kelamin,
//                   dd_label: "-- Jenis Kelamin --",
//                   label: "-- Jenis Kelamin --",
//                   onChanged: (value) async {
//                     try {
//                       kategori_asset.clear();
//                       kategori_asset_id.clear();
//                       asset_brand.clear();
//                       asset_brand_id.clear();
//                       asset_model.clear();
//                       asset_model_id.clear();
//                       tipe_asset.clear();
//                       tipe_asset_id.clear();
//                       tipe_asset_code.clear();

//                       product_search.clear();
//                       productController.clear();
//                       if (value == 'MOTOR') {
//                         temp_asset1 = '12';
//                       } else if (value == 'MOBIL') {
//                         temp_asset1 = '11';
//                       }

//                       print("temp asset: " + temp_asset1!);
//                       print(widget.branch_code);

//                       //LOAD ASSET CATEGORY
//                       final response = await http.post(
//                         Uri.parse("${confins_controller}getAssetCategory"),
//                         headers: {
//                           "x-api-key": "$api_key",
//                           "Content-Type": "application/json"
//                         },
//                         body: jsonEncode(
//                             {"asset_type_id": int.parse(temp_asset1!)}),
//                       );

//                       final data = jsonDecode(response.body);

//                       for (int i = 0; i < data!.length; i++) {
//                         kategori_asset.add(data[i]['ASSET_CATEGORY_NAME']);
//                         kategori_asset_id.add(data[i]['ASSET_CATEGORY_ID']);
//                       }
//                       setState(() {
//                         isCategoryFilled = false;
//                         isProductFilled = false;
//                         nilai_kategori_asset = null;
//                         nilai_produk = null;
//                       });

//                       //LOAD PRODUCT
//                       final response_product = await http.post(
//                         Uri.parse("${confins_controller}getProduct"),
//                         headers: {
//                           "x-api-key": "$api_key",
//                           "Content-Type": "application/json"
//                         },
//                         body: jsonEncode({
//                           "branch_code": widget.branch_code,
//                           "asset_type_id": temp_asset1
//                         }),
//                       );

//                       final data_product = jsonDecode(response_product.body);
                      
//                       setState(() {
//                         for (int i = 0; i < data_product!.length; i++) {
//                         product_search.add(data_product[i]);
//                         // prod_offering_id_search
//                         //     .add(data_product[i]['PROD_OFFERING_ID']);
//                         // prod_offering_h_id_search
//                         //     .add(data_product[i]['PROD_OFFERING_H_ID']);
//                         // prod_offering_code_search
//                         //     .add(data_product[i]['PROD_OFFERING_CODE']);
//                       }
//                         _foundProduct = product_search;
//                         print(_foundProduct);
                        
//                         nilai_jk = value;
//                         nilai_kategori_asset = null;
//                         nilai_ab = null;
//                         nilai_am = null;
//                         nilai_ta = null;
//                         nilai_produk = null;


//                         isCategoryFilled = false;
//                         isBrandFilled = false;
//                         isModelFilled = false;
//                         isTipeFilled = false;
//                       });
//                     } catch (e) {
//                       _showToast(context, e.toString());
//                     }
//                   },
//                 ),
//                   NewDropdown(
//                   validator: (value) {
//                     if (value == null) {
//                       return "Jenis Kendaraan is Required!";
//                     } else {
//                       return null;
//                     }
//                   },
//                   val: nilai_jk,
//                   items: jenis_kendaraan,
//                   dd_label: "-- Jenis Kendaraan --",
//                   label: "-- Jenis Kendaraan --",
//                   onChanged: (value) async {
//                     try {
//                       kategori_asset.clear();
//                       kategori_asset_id.clear();
//                       asset_brand.clear();
//                       asset_brand_id.clear();
//                       asset_model.clear();
//                       asset_model_id.clear();
//                       tipe_asset.clear();
//                       tipe_asset_id.clear();
//                       tipe_asset_code.clear();

//                       product_search.clear();
//                       productController.clear();
//                       if (value == 'MOTOR') {
//                         temp_asset1 = '12';
//                       } else if (value == 'MOBIL') {
//                         temp_asset1 = '11';
//                       }

//                       print("temp asset: " + temp_asset1!);
//                       print(widget.branch_code);

//                       //LOAD ASSET CATEGORY
//                       final response = await http.post(
//                         Uri.parse("${confins_controller}getAssetCategory"),
//                         headers: {
//                           "x-api-key": "$api_key",
//                           "Content-Type": "application/json"
//                         },
//                         body: jsonEncode(
//                             {"asset_type_id": int.parse(temp_asset1!)}),
//                       );

//                       final data = jsonDecode(response.body);

//                       for (int i = 0; i < data!.length; i++) {
//                         kategori_asset.add(data[i]['ASSET_CATEGORY_NAME']);
//                         kategori_asset_id.add(data[i]['ASSET_CATEGORY_ID']);
//                       }
//                       setState(() {
//                         isCategoryFilled = false;
//                         isProductFilled = false;
//                         nilai_kategori_asset = null;
//                         nilai_produk = null;
//                       });

//                       //LOAD PRODUCT
//                       final response_product = await http.post(
//                         Uri.parse("${confins_controller}getProduct"),
//                         headers: {
//                           "x-api-key": "$api_key",
//                           "Content-Type": "application/json"
//                         },
//                         body: jsonEncode({
//                           "branch_code": widget.branch_code,
//                           "asset_type_id": temp_asset1
//                         }),
//                       );

//                       final data_product = jsonDecode(response_product.body);
                      
//                       setState(() {
//                         for (int i = 0; i < data_product!.length; i++) {
//                         product_search.add(data_product[i]);
//                         // prod_offering_id_search
//                         //     .add(data_product[i]['PROD_OFFERING_ID']);
//                         // prod_offering_h_id_search
//                         //     .add(data_product[i]['PROD_OFFERING_H_ID']);
//                         // prod_offering_code_search
//                         //     .add(data_product[i]['PROD_OFFERING_CODE']);
//                       }
//                         _foundProduct = product_search;
//                         print(_foundProduct);
                        
//                         nilai_jk = value;
//                         nilai_kategori_asset = null;
//                         nilai_ab = null;
//                         nilai_am = null;
//                         nilai_ta = null;
//                         nilai_produk = null;


//                         isCategoryFilled = false;
//                         isBrandFilled = false;
//                         isModelFilled = false;
//                         isTipeFilled = false;
//                       });
//                     } catch (e) {
//                       _showToast(context, e.toString());
//                     }
//                   },
//                 ),
//                  NewDropdown(
//                         validator: (value) {
//                           if (value == null) {
//                             return "Asset Category is Required!";
//                           } else {
//                             return null;
//                           }
//                         },
//                         val: nilai_kategori_asset,
//                         items: kategori_asset,
//                         dd_label: "-- Kategori Kendaraan --",
//                         label: "-- Kategori Kendaraan --",
//                         onChanged: (value) async {
//                           try {
//                             print("asset category: " + value.toString());
//                             asset_brand.clear();
//                             asset_brand_id.clear();
//                             asset_model.clear();
//                             asset_model_id.clear();
//                             tipe_asset.clear();
//                             tipe_asset_id.clear();
//                             tipe_asset_code.clear();

//                             setState(() {
//                               nilai_kategori_asset = value;
//                               var index_kategori =
//                                   kategori_asset.indexOf(nilai_kategori_asset!);
//                               kategori_id = kategori_asset_id[index_kategori];
//                               nilai_ab = null;
//                               nilai_am = null;
//                               nilai_ta = null;
//                             });

//                             print('selected category id: ' +
//                                 kategori_id.toString());

//                             final response = await http.post(
//                               Uri.parse("${confins_controller}getAssetBrand"),
//                               headers: {
//                                 "x-api-key": "$api_key",
//                                 "Content-Type": "application/json"
//                               },
//                               body: jsonEncode(
//                                   {"asset_category_id": "${kategori_id}"}),
//                             );

//                             final data = jsonDecode(response.body);

//                             print(data);

//                             for (int i = 0; i < data!.length; i++) {
//                               asset_brand.add(data[i]['BRAND_NAME']);
//                               asset_brand_id.add(data[i]['BRAND_ID']);
//                             }

//                             setState(() {
//                               isBrandFilled = false;
//                               nilai_ab = null;
//                             });
//                           } catch (e) {
//                             _showToast(context, e.toString());
//                           }
//                           print(nilai_kategori_asset);
//                           print(kategori_id);
//                         },
//                       ),
//                        NewDropdown(
//                         validator: (value) {
//                           if (value == null) {
//                             return "Asset Brand/Asset Name is Required!";
//                           } else {
//                             return null;
//                           }
//                         },
//                         val: nilai_ab,
//                         items: asset_brand,
//                         dd_label: "-- Merk Kendaraan --",
//                         label: "-- Merk Kendaraan --",
//                         onChanged: (value) async {
//                           try {
//                             print("asset brand: " + value.toString());
//                             asset_model.clear();
//                             asset_model_id.clear();
//                             tipe_asset.clear();
//                             tipe_asset_id.clear();
//                             tipe_asset_code.clear();

//                             setState(() {
//                               nilai_ab = value;
//                               var index_brand = asset_brand.indexOf(nilai_ab!);
//                               brand_id = asset_brand_id[index_brand];
//                               nilai_am = null;
//                               nilai_ta = null;
//                             });

//                             print('selected brand id: ' + brand_id.toString());

//                             final response = await http.post(
//                               Uri.parse("${confins_controller}getAssetModel"),
//                               headers: {
//                                 "x-api-key": "$api_key",
//                                 "Content-Type": "application/json"
//                               },
//                               body: jsonEncode({
//                                 "asset_category_id": "${kategori_id}",
//                                 "brand_id": "${brand_id}"
//                               }),
//                             );

//                             final data = jsonDecode(response.body);

//                             print(data);

//                             for (int i = 0; i < data!.length; i++) {
//                               asset_model.add(data[i]['MODEL_NAME']);
//                               asset_model_id.add(data[i]['MODEL_ID']);
//                             }

//                             setState(() {
//                               isModelFilled = false;
//                               nilai_am = null;
//                             });
//                           } catch (e) {
//                             _showToast(context, e.toString());
//                           }
//                           print(nilai_ab);
//                           print(brand_id);
//                         },
//                       ),
//  NewDropdown(
//                         validator: (value) {
//                           if (value == null) {
//                             return "Asset Model is Required!";
//                           } else {
//                             return null;
//                           }
//                         },
//                         val: nilai_am,
//                         items: asset_model,
//                         dd_label: "-- Model Kendaraan --",
//                         label: "-- Model Kendaraan --",
//                         onChanged: (value) async {
//                           try {
//                             print("asset brand: " + value.toString());
//                             tipe_asset.clear();
//                             tipe_asset_id.clear();
//                             tipe_asset_code.clear();

//                             setState(() {
//                               nilai_am = value;
//                               var index_model = asset_model.indexOf(nilai_am!);
//                               model_id = asset_model_id[index_model];
//                               nilai_ta = null;
//                             });

//                             print('selected model id: ' + model_id.toString());

//                             final response = await http.post(
//                               Uri.parse("${confins_controller}getAssetTipe"),
//                               headers: {
//                                 "x-api-key": "$api_key",
//                                 "Content-Type": "application/json"
//                               },
//                               body: jsonEncode({
//                                 "asset_category_id": "${kategori_id}",
//                                 "brand_id": "${brand_id}",
//                                 "model_id": "${model_id}"
//                               }),
//                             );

//                             final data = jsonDecode(response.body);

//                             print(data);

//                             for (int i = 0; i < data!.length; i++) {
//                               tipe_asset.add(data[i]['ASSET_TYPE']);
//                               tipe_asset_id.add(data[i]['ASSET_MASTER_ID']);
//                               tipe_asset_code.add(data[i]['ASSET_CODE']);
//                             }

//                             setState(() {
//                               isTipeFilled = false;
//                               nilai_ta = null;
//                             });
//                           } catch (e) {
//                             _showToast(context, e.toString());
//                           }
//                           print(nilai_am);
//                           print(model_id);
//                         },
//                       ),
//                       NewDropdown(
//                         validator: (value) {
//                           if (value == null) {
//                             return "Asset Type is Required!";
//                           } else {
//                             return null;
//                           }
//                         },
//                         val: nilai_ta,
//                         items: tipe_asset,
//                         dd_label: "-- Tipe Kendaraan --",
//                         label: "-- Tipe Kendaraan --",
//                         onChanged: (value) {
//                           try {
//                             print("asset model: " + value.toString());

//                             setState(() {
//                               nilai_ta = value;
//                               var index_tipe = tipe_asset.indexOf(nilai_ta!);
//                               tipe_id = tipe_asset_id[index_tipe];
//                               tipe_code = tipe_asset_code[index_tipe];
//                             });

//                             print('selected tipe id: ' + tipe_id.toString());
//                           } catch (e) {
//                             _showToast(context, e.toString());
//                           }
                          
//                           print(nilai_ta);
//                           print(tipe_id);
//                           print(tipe_code);
                          
//                         },
//                       ),
//                       NewDropdown(
//                         validator: (value) {
//                           if (value == null) {
//                             return "Tahun Kendaraan is Required!";
//                           } else {
//                             return null;
//                           }
//                         },
//                         val: nilai_tp,
//                         items: tahun_kendaraan,
//                         dd_label: "-- Tahun Kendaraan --",
//                         label: "-- Tahun Kendaraan --",
//                         onChanged: (value) {
//                           try {
//                             print("asset model: " + value.toString());

//                             setState(() {
//                               nilai_tp = value;
//                               var index_tipe = tipe_asset.indexOf(nilai_tp!);
//                               tipe_id = tipe_asset_id[index_tipe];
//                               tipe_code = tipe_asset_code[index_tipe];
//                             });

//                             print('selected tipe id: ' + tipe_id.toString());
//                           } catch (e) {
//                             _showToast(context, e.toString());
//                           }
//                           print(nilai_tp);
//                           print(tipe_id);
//                           print(tipe_code);
//                         },
//                       ),
//                 InputField(
//                   label: "Harga Kendaraan",
//                   hintText: "Harga Kendaraan",
//                   decoration: InputDecoration(prefixText: _currency),
//                   onChanged: (value) {
//                     value = '${_formatNumber(value.replaceAll('.', ''))}';

//                     hargaKendaraanController.value = TextEditingValue(
//                       text: value,
//                       selection: TextSelection.collapsed(offset: value.length),
//                     );

//                     String temp_val = value.replaceAll(".", "");
//                     setState(() {
//                       print("temp val: " + temp_val);
//                       hargaKendaraan = double.parse(temp_val);
//                     });
//                     if (amountDP != 0) {
//                       print("amount DP: " + amountDP.toString());
//                       calculateAmount(double.parse(persenDpController.text));
//                     }
//                   },
//                   fieldColor: Colors.white,
//                   type: TextInputType.number,
//                   validator: (value) {},
//                   controller: hargaKendaraanController,
//                 ),
//                 Container(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Expanded(
//                         flex: 3,
//                         child: InputField(
//                           label: "DP (%)",
//                           hintText: "DP (%)",
//                           onChanged: (value) {
//                             print("value persen: " + value);
//                             calculateAmount(double.parse(value));
//                           },
//                           fieldColor: Colors.white,
//                           type: TextInputType.number,
//                           controller: persenDpController,
//                         ),
//                       ),
//                       Expanded(
//                           flex: 5,
//                           child: InputField(
//                             label: "DP Amount",
//                             hintText: "DP Amount",
//                             onChanged: (value) {
//                               value =
//                                   '${_formatNumber(value.replaceAll('.', ''))}';
//                               dpController.value = TextEditingValue(
//                                 text: value,
//                                 selection: TextSelection.collapsed(
//                                     offset: value.length),
//                               );
                              
//                               String temp_val = value.replaceAll(".", "");
//                               calculatePercent(double.parse(temp_val));
//                               dpamount = true;
//                             },
//                             fieldColor: Colors.white,
//                             type: TextInputType.number,
//                             controller: dpAmountController,
                            
//                             // controller: dpController,
//                           ),
//                           ),
//                     ],
//                   ),
//                 ),
//                 //       NewDropdown(
//                 //   val: nilai_area_domisili,
//                 //   items: areaDomisili,
//                 //   dd_label: "-- Domicile Area --",
//                 //   label: "-- Domicile Area --",
//                 //   onChanged: (value) {
//                 //     try {
//                 //       setState(() {
//                 //         nilai_area_domisili = value;
//                 //       });
//                 //     } catch (e) {
//                 //       _showToast(context, e.toString());
//                 //     }
//                 //   },
//                 // ),

//                 //       //Jangka waktu bulan
//                 //       // Harga kendaraan
//                 //       //DP
//                 //     Container(
//                 //   child: Column(
//                 //     children: [
//                 //       Padding(
//                 //         padding: const EdgeInsets.only(top: 12),
//                 //         child: Text(
//                 //           "Insurance Type",
//                 //           style: TextStyle(
//                 //               fontWeight: FontWeight.bold,
//                 //               fontFamily: "SF",
//                 //               fontSize: 15,
//                 //               color: Colors.white),
//                 //         ),
//                 //       ),
//                 //       Row(
//                 //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //         children: [
//                 //           Padding(
//                 //             padding: const EdgeInsets.only(left: 16),
//                 //             child: ChoiceChip(
//                 //               backgroundColor: Colors.white,
//                 //               label: Text(
//                 //                 "Comprehensive",
//                 //                 style: TextStyle(fontSize: 12),
//                 //               ),
//                 //               selected: isSelectedKomprehensif,
//                 //               onSelected: (bool value) {
//                 //                 isSelectedKomprehensif = value;
//                 //                 setState(() {
//                 //                   isSelectedKombinasi = false;
//                 //                   isSelectedTLO = false;
//                 //                 });
//                 //               },
//                 //               selectedColor: orange_brifinance,
//                 //             ),
//                 //           ),
//                 //           ChoiceChip(
//                 //             backgroundColor: Colors.white,
//                 //             label: Text(
//                 //               "TLO",
//                 //               style: TextStyle(fontSize: 12),
//                 //             ),
//                 //             selected: isSelectedTLO,
//                 //             onSelected: (bool value) {
//                 //               isSelectedTLO = value;
//                 //               setState(() {
//                 //                 isSelectedKomprehensif = false;
//                 //                 isSelectedKombinasi = false;
//                 //               });
//                 //             },
//                 //             selectedColor: orange_brifinance,
//                 //           ),
//                 //           Padding(
//                 //             padding: const EdgeInsets.only(right: 16),
//                 //             child: ChoiceChip(
//                 //               backgroundColor: Colors.white,
//                 //               label: Text(
//                 //                 "Combination",
//                 //                 style: TextStyle(fontSize: 12),
//                 //               ),
//                 //               selected: isSelectedKombinasi,
//                 //               onSelected: (bool value) {
//                 //                 isSelectedKombinasi = value;
//                 //                 setState(() {
//                 //                   isSelectedKomprehensif = false;
//                 //                   isSelectedTLO = false;
//                 //                 });
//                 //               },
//                 //               selectedColor: orange_brifinance,
//                 //             ),
//                 //           ),
//                 //         ],
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 //  Container(
//                 //   child: Column(
//                 //     children: [
//                 //       Padding(
//                 //         padding: const EdgeInsets.only(top: 12),
//                 //         child: Text(
//                 //           "Insurance Payment",
//                 //           textAlign: TextAlign.start,
//                 //           style: TextStyle(
//                 //               fontWeight: FontWeight.bold,
//                 //               fontFamily: "SF",
//                 //               fontSize: 15,
//                 //               color: Colors.white),
//                 //         ),
//                 //       ),
//                 //       Padding(
//                 //         padding: const EdgeInsets.only(left: 100, right: 100),
//                 //         child: Row(
//                 //           children: [
//                 //             ChoiceChip(
//                 //               backgroundColor: Colors.white,
//                 //               label: Text(
//                 //                 "Installment",
//                 //                 style: TextStyle(fontSize: 12),
//                 //               ),
//                 //               selected: isSelectedCicil,
//                 //               onSelected: (bool value) {
//                 //                 isSelectedCicil = value;
//                 //                 setState(() {
//                 //                   isSelectedTunai = false;
//                 //                 });
//                 //               },
//                 //               selectedColor: orange_brifinance,
//                 //             ),
//                 //             Padding(
//                 //               padding: const EdgeInsets.only(left: 12),
//                 //               child: ChoiceChip(
//                 //                 backgroundColor: Colors.white,
//                 //                 label: Text(
//                 //                   "Cash",
//                 //                   style: TextStyle(fontSize: 12),
//                 //                 ),
//                 //                 selected: isSelectedTunai,
//                 //                 onSelected: (bool value) {
//                 //                   isSelectedTunai = value;
//                 //                   setState(() {
//                 //                     isSelectedCicil = false;
//                 //                   });
//                 //                 },
//                 //                 selectedColor: orange_brifinance,
//                 //               ),
//                 //             ),
//                 //           ],
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 Container(
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 20, left: 16, right: 16),
//                     child: RoundedButton(
//                       text: "PROSES",
//                       c_width: double.infinity,
//                       press: () {
//                         print("test");
//                         // print (input_nilaijk);
//                         // print(myNomorhpsalesController);
//                         // print(myNamasalesController);
//                         // print(myDealernameController);
//                         // print(myNameController);
//                         // print(myAlamatrumahController);
//                         // print(myKodeposController);
//                         // print(myNomorktpController);
//                         // print(myTanggallahirController);
//                         // print(myNomorhpController);
//                         // print(jenis_kelamin);
//                         // print(nilai_ab);
//                         // print(hargaKendaraan);
//                         // print(dpAmountController);
//                         // if (_formKey.currentState!.validate()) {
//                         //   // calculateAllData(context);
//                         // }
//                       },
//                       color: orange_brifinance,
//                       textColor: Colors.white,
//                     ),
//                   ),
//                 ),
//             ]),
//           )
//             ,)
//             ,)
//             ,)
//             ,
//     );
//   }

//   Widget background() {
//     return Container(
//         height: MediaQuery.of(context).size.height * 0.3,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: blue_brifinance,
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(40),
//             bottomRight: Radius.circular(40),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(top: 30, left: 16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//             ],
//           ),
//         ));
//   }
//   inputAssetData(BuildContext context) async {
//     int asset_price = int.parse(assetPriceController.text.replaceAll('.', ''));

//     try {
//       final response = await http.post(
//         Uri.parse("${credit_approval_controller}formMyBrif"),
//         headers: {"x-api-key": "$api_key", "Content-Type": "application/json"},
//         body: jsonEncode({
//           "aplicationType": input_nilaijk,
//           "nomorHpSales": myNomorhpsalesController,
//           "namaSales": myNamasalesController,
//           "namaDealer": myDealernameController,
//           "customerName": myNameController,
//           "homeAddress": myAlamatrumahController,
//           "homeAddressPostalCode": myKodeposController,
//           "ktpNumber": myNomorktpController,
//           "dateOfBirth": myTanggallahirController,
//           "phone": myNomorhpController,
//           "username": "fwaskito",
//           "gender": jenis_kelamin,
//           "brandCode": nilai_ab,
//           "amount": hargaKendaraanController,
//           "downPayment": dpAmountController,
//           "assetName": ""
//         }),
//       );

//       final data = jsonDecode(response.body);
//       print("ini data:" + data.toString());

//       if (data == "success_insert_asset_data") {
//         print("isTambah: " + isTambah.toString());
//         if (isTambah == true) {
//           EasyLoading.dismiss();
//           Alert(
//             context: context,
//             type: AlertType.success,
//             title: "SUCCESS",
//             desc: "Data successfully saved",
//             buttons: [
//               DialogButton(
//                 child: Text(
//                   "OK",
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//                 onPressed: () => Navigator.pop(this.context),
//                 color: blue_brifinance,
//               ),
//             ],
//           ).show();
//         } 
//         // else {
//         //   EasyLoading.dismiss();
//         //   Alert(
//         //     context: context,
//         //     type: AlertType.success,
//         //     title: "SUCCESS",
//         //     desc: "Data successfully saved",
//         //     buttons: [
//         //       DialogButton(
//         //         child: Text(
//         //           "OK",
//         //           style: TextStyle(color: Colors.white, fontSize: 20),
//         //         ),
//         //         onPressed: () => Navigator.push(
//         //           context,
//         //           MaterialPageRoute(
//         //               builder: (context) => widget.is_edit_data == true
//         //                       ? NewOrderEditDataReturn(
//         //                           value: widget.nik,
//         //                           order_number: widget.order_number,
//         //                           branch_code: widget.branch_code,
//         //                           is_inputan2_edit: true,
//         //                           classDataDokumenReturn:
//         //                               widget.classDataDokumenReturn,
//         //                           classNotesAndSummary:
//         //                               widget.classNotesAndSummary,
//         //                           notes_and_summary_list:
//         //                               widget.notes_and_summary_list,
//         //                           role_code: widget.role_code,
//         //                         )
//         //                       : NewOrder(
//         //                           value: widget.nik,
//         //                           order_number: widget.order_number,
//         //                           branch_code: widget.branch_code,
//         //                         )),
//         //         ),
//         //         color: blue_brifinance,
//         //       ),
//         //     ],
//         //   ).show();
//         // }
//       } else {
//         EasyLoading.dismiss();
//         Alert(
//           context: context,
//           type: AlertType.error,
//           title: "FAILED",
//           desc: "Data gagal disimpan",
//           buttons: [
//             DialogButton(
//               child: Text(
//                 "OK",
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//               onPressed: () => Navigator.pop(context),
//               color: blue_brifinance,
//             ),
//           ],
//         ).show();
//       }
//     } catch (e) {
//       _showToast(context, e.toString());
//     }
//   }

  
//   void calculatePercent(double amount) {
//     RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

//     setState(() {
//       percentDP = (amount / hargaKendaraan) * 100;
//       persenDpController.text =
//           "${percentDP.toString().replaceAll(regex, "")}%";
//       print("persen DP: " + percentDP.toString());
//     });
//   }
//   void calculateAmount(double percent) {
//     RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
//     print("harga kendaraan: " + hargaKendaraan.toString());
//     print("persen yg diinput: " + percent.toString());
//     setState(() {
//       amountDP = (percent / 100) * hargaKendaraan;
//       dpAmountController.text = amountDP.toString().replaceAll(regex, "");
//       print("amount dp: " + amountDP.toString());
//       print("calculate amount: " + amountDP.toString());
//     });
//   }
  

  
// }

// _showToast(BuildContext context, String msg) async {
//   final scaffold = ScaffoldMessenger.of(context);
//   scaffold.showSnackBar(
//     SnackBar(
//       content: Text(msg),
//     ),
//   );
// }
