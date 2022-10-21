import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Style/colors.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';

class PhotoInput extends StatefulWidget {
  const PhotoInput({
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
  PhotoInputState createState() => PhotoInputState();
}

class PhotoInputState extends State<PhotoInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: 130,
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[BoxShadow(blurRadius: 16, color: lightGray)],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 2),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () {
                  print("camera");
                },
              ),
              IconButton(
                icon: const Icon(Icons.photo),
                onPressed: () {
                  print("photo");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
