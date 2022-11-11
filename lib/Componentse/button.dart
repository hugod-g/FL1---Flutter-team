import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/style/colors.dart';
import 'package:mon_petit_entretien/style/fonts.dart';

class Button extends StatefulWidget {
  const Button({
    super.key,
    required this.text,
    required this.onPress,
    required this.keyTest,
    this.secondary,
    this.important,
    this.isLoading,
  });

  final String text;
  final void Function()? onPress;
  final bool? secondary;
  final bool? important;
  final bool? isLoading;
  final String keyTest;

  @override
  ButtonState createState() => ButtonState();
}

class ButtonState extends State<Button> {
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
        key: Key(widget.keyTest),
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: widget.important == true
              ? Colors.red
              : widget.secondary == true
                  ? white
                  : navy,
          boxShadow: const <BoxShadow>[
            BoxShadow(blurRadius: 16, color: lightGray)
          ],
        ),
        child: TextButton(
          onPressed: _onButtonPress,
          child: widget.isLoading == true
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: widget.secondary == true ? navy : white,
                  ),
                )
              : Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.secondary != null ? navy : white,
                    fontFamily: appFont,
                    fontWeight: fontMedium,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}
