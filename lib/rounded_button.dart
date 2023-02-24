import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final double c_width;
  final Function()? press;
  final Color? color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    required this.c_width,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: c_width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          shadowColor: Colors.red,
          elevation: 10,
          primary: color,
          onSurface: Color(0xffcccccc),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          textStyle: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: "SF")),
    );
  }
}
