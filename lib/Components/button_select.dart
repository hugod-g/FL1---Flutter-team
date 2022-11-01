import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Style/colors.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';

class ButtonSelect extends StatefulWidget {
  const ButtonSelect({
    super.key,
    required this.text,
    required this.onPress,
    this.isSelect,
  });

  final String text;
  final void Function()? onPress;
  final bool? isSelect;

  @override
  ButtonSelectState createState() => ButtonSelectState();
}

class ButtonSelectState extends State<ButtonSelect> {
  void _onButtonPress() {
    if (widget.onPress != null) {
      widget.onPress!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: white,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Container(
        width: 85,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: widget.isSelect == true ? navy : white,
          boxShadow: const <BoxShadow>[
            BoxShadow(blurRadius: 16, color: lightGray)
          ],
        ),
        child: TextButton(
          onPressed: _onButtonPress,
          child: Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.isSelect == true ? white : navy,
                    fontFamily: appFont,
                    fontWeight: fontMedium,
                    fontSize: 16,
                  ),
                )
              
        ),
      ),
    );
  }
}
