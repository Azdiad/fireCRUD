import 'package:flutter/material.dart';

class textfieldwidg extends StatelessWidget {
  final labeltext;
  final controller;
  final numberofline;
  final textlength;
  final suffixicon;
  final validator;
  final readonly;
  const textfieldwidg(
      {super.key,
      this.labeltext,
      this.controller,
      this.numberofline,
      this.textlength,
      this.suffixicon,
      this.validator,
      this.readonly});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: textlength,
      maxLines: numberofline,
      style: TextStyle(color: Colors.black, fontSize: 25),
      controller: controller,
      decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: TextStyle(color: Colors.black, fontSize: 20),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          suffixIcon: suffixicon),
      validator: validator,
      readOnly: readonly,
    );
  }
}
