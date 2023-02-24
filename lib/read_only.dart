import 'package:flutter/material.dart';

class ReadOnlyField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  ReadOnlyField({Key? key, this.hintText, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffe4e4e4),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextFormField(
          readOnly: true,
          controller: controller,
          onChanged: (value) {},
          cursorColor: Color(0xff004993),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
                fontFamily: "SF",
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
                color: Colors.black),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
