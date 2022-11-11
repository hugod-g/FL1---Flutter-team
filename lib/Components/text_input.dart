import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Style/colors.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    required this.value,
    required this.placeholder,
    required this.onChangeText,
    required this.keyTest,
    this.textinput,
    this.secure = false,
  });

  final String? value;
  final String? placeholder;
  final bool secure;
  final void Function(String)? onChangeText;
  final TextInputType? textinput;
  final String keyTest;

  @override
  TextInputState createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: double.infinity,
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[BoxShadow(blurRadius: 16, color: lightGray)],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Container(
        key: Key(widget.keyTest),
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 2),
          child: TextField(
            obscureText: widget.secure,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: black,
              hintText: widget.placeholder,
              hintStyle: const TextStyle(
                color: lightGray,
              ),
            ),
            keyboardType: widget.textinput,
            style: const TextStyle(
              fontFamily: appFont,
              fontWeight: fontRegular,
            ),
            onChanged: widget.onChangeText,
          ),
        ),
      ),
    );
  }
}
