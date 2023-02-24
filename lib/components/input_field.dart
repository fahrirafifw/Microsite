import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Widget InputField(
//     final String? hintText,
//     final ValueChanged<String>? onChanged,
//     final Function(String?)? onSaved,
//     final String? Function(String?)? validator,
//     final TextEditingController? controller,
//     final TextInputType? type,
//     final Color? fieldColor) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 16, right: 16),
//     child: Container(
//       margin: EdgeInsets.symmetric(vertical: 3),
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: fieldColor,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: TextFormField(
//         onChanged: onChanged,
//         onSaved: onSaved,
//         validator: validator,
//         controller: controller,
//         inputFormatters: [UpperCaseTextFormatter()],
//         cursorColor: Color(0xff004993),
//         keyboardType: type,
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: TextStyle(
//               fontSize: 12,
//               fontFamily: "SF",
//               fontStyle: FontStyle.italic,
//               color: Color(0xffd3d3d3)),
//           border: InputBorder.none,
//         ),
//       ),
//     ),
//   );
// }
class InputField extends StatelessWidget {
  final String? hintText, label;
  final ValueChanged<String>? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? type;
  final Color? fieldColor;
  const InputField(
      {Key? key,
      this.fieldColor,
      this.hintText,
      this.onChanged,
      this.onSaved,
      this.type,
      this.controller,
      this.validator,
      required this.label,
      InputDecoration? decoration,
      text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: fieldColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextFormField(
          onChanged: onChanged,
          onSaved: onSaved,
          validator: validator,
          controller: controller,
          inputFormatters: [UpperCaseTextFormatter()],
          cursorColor: Color(0xff004993),
          keyboardType: type,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 12,
              fontFamily: "SF",
              fontStyle: FontStyle.italic,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: 12,
                fontFamily: "SF",
                fontStyle: FontStyle.italic,
                color: Color(0xffd3d3d3)),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
