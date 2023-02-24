import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class NewDropdown extends StatelessWidget {
  List<String> items = [];
  final String dd_label, label;
  String? val;
  final String? Function(Object?)? validator;
  Function()? itemTap;
  Function(String?)? onChanged;
  Function(String?)? onSaved;
  NewDropdown(
      {Key? key,
      required this.items,
      required this.dd_label,
      this.validator,
      this.val,
      this.itemTap,
      this.onChanged,
      this.onSaved,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Container(
          width: double.infinity,
          child: DropdownButtonFormField2(
            onSaved: onSaved,
            isExpanded: true,
            validator: validator,
            hint: Row(
              children: [
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    dd_label,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "SF",
                      fontWeight: FontWeight.bold,
                      color: Color(0xff004993),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: GestureDetector(
                        onTap: itemTap,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7c7c7c),
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ))
                .toList(),
            value: val,
            onChanged: onChanged,
            icon: const Icon(
              Icons.arrow_drop_down_circle,
            ),
            iconSize: 16,
            iconEnabledColor: Color(0xff004993),
            iconDisabledColor: Colors.grey,
            buttonHeight: 50,
            buttonWidth: MediaQuery.of(context).size.width * 0.8,
            buttonPadding: const EdgeInsets.only(left: 14, right: 14),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            buttonElevation: 2,
            itemHeight: 40,
            // itemWidth: MediaQuery.of(context).size.width * 0.91,
            itemPadding: const EdgeInsets.only(left: 16, right: 16),
            dropdownMaxHeight: 200,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            dropdownElevation: 8,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 4,
            scrollbarAlwaysShow: true,
            decoration: InputDecoration(
              labelText: "     " + label,
              labelStyle: TextStyle(
                fontSize: 16,
                fontFamily: "SF",
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              border: InputBorder.none,
            ),
            // offset: const Offset(-20, 0),
          ),
        ),
      ),
    );
  }
}
