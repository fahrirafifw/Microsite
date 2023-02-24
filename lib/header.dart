import 'package:flutter/material.dart';
import 'package:microsite/constant.dart';

class Header extends StatelessWidget {
  final String nama, position, uk, image_src;
  Color? ring_color;

  Header(
      {Key? key,
      required this.nama,
      required this.position,
      required this.uk,
      required this.image_src,
      this.ring_color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 25, bottom: 10),
      child: Row(
        children: [
          image_src == "monkey"
              ? CircleAvatar(
                  backgroundColor: ring_color,
                  radius: 35,
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/monkey.jpg"), //NetworkImage
                    radius: 30,
                  ), //CircleAvatar
                )
              : CircleAvatar(
                  backgroundColor: ring_color,
                  radius: 35,
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage("${image_url}${image_src}"), //NetworkImage
                    radius: 30,
                  ), //CircleAvatar
                ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(50),
          //   child: Image.asset(
          //     image_src,
          //     width: 60,
          //     height: 60,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 240,
                  child: Text(
                    nama.toString().toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "SF",
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 230,
                  child: Text(
                    position.toString().toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                    style: TextStyle(
                        fontFamily: "SF", fontSize: 14, color: Colors.white),
                  ),
                ),
                Text(
                  uk.toString().toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  softWrap: false,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "SF",
                      fontSize: 14,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
