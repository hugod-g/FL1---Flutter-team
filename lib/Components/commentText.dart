import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Style/colors.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';

class CommonText extends StatefulWidget {
  const CommonText({
    super.key,
    required this.text,
    required this.fontSizeText,
    required this.fontWeight,
    this.paddingTop = 0,
    this.paddingBot = 0,
    this.paddingRight = 0,
    this.paddingLeft = 0,
  });

  final String text;
  final double fontSizeText;
  final FontWeight fontWeight;
  final double paddingTop;
  final double paddingBot;
  final double paddingRight;
  final double paddingLeft;

  @override
  CommonTextState createState() => CommonTextState();
}

class CommonTextState extends State<CommonText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: widget.paddingTop,
          bottom: widget.paddingBot,
          right: widget.paddingRight,
          left: widget.paddingLeft),
      child: Text(
        widget.text,
        style: TextStyle(
          color: navy,
          fontSize: widget.fontSizeText,
          fontFamily: appFont,
          fontWeight: widget.fontWeight,
        ),
      ),
    );
  }
}
