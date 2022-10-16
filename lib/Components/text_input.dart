import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Style/colors.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    required this.value,
    required this.placeholder,
    required this.onChangeText,
    this.secure = false,
  });

  final String? value;
  final String? placeholder;
  final bool secure;
  final void Function(String)? onChangeText;

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
        boxShadow: <BoxShadow>[
          BoxShadow(blurRadius: 16, color: grisclairetextfield)
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Container(
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
            ),
            onChanged: widget.onChangeText,
          ),
        ),
      ),
    );
  }
}
