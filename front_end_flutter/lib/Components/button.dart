import 'package:flutter/material.dart';
import '../Style/colors.dart';

class Button extends StatefulWidget {
  const Button({
    super.key,
    required this.text,
    required this.onPress,
    this.secondary,
  });

  final String text;
  final void Function()? onPress;
  final bool? secondary;

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
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: widget.secondary != null ? white : grisfoncer,
          boxShadow: const <BoxShadow>[
            BoxShadow(blurRadius: 16, color: grisclairetextfield)
          ],
        ),
        child: TextButton(
          onPressed: _onButtonPress,
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.secondary != null ? grisfoncer : white,
              fontFamily: "bold",
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
