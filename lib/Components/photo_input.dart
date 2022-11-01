import 'package:camera/camera.dart'
    show CameraDescription, XFile, availableCameras;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Components/comment_text.dart';
import 'package:provider/provider.dart';

import '../Page/camera_page.dart';

class PhotoInput extends StatefulWidget {
  const PhotoInput({
    super.key,
    required this.value,
    required this.placeholder,
    this.secure = false,
  });

  final String? value;
  final String? placeholder;
  final bool secure;

  @override
  PhotoInputState createState() => PhotoInputState();
}

class PhotoInputState extends State<PhotoInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 13),
              child: InkWell(
                onTap: () async {
                  await availableCameras().then(
                    (List<CameraDescription> value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CameraPage(cameras: value),
                      ),
                    ),
                  );
                },
                child: Ink(
                  child: Row(
                    children: const <Widget>[
                      Icon(
                        Icons.camera_alt,
                        size: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: CommonText(
                          text: "Camera",
                          fontSizeText: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                String newPath = '/assets/car.jpg';
                final XFile? file =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (file == null) {
                  Provider.of<AppData>(context, listen: false).addDataVehicle(
                    "tmp",
                    0,
                    newPath,
                    DateTime.now().toString(),
                    '0',
                  );
                } else {
                  newPath = file.path;
                  Provider.of<AppData>(context, listen: false).addDataVehicle(
                    "tmp",
                    0,
                    newPath,
                    DateTime.now().toString(),
                    '0',
                  );
                }
                print("galerie");
              },
              child: Ink(
                child: Row(
                  children: const <Widget>[
                    Icon(
                      Icons.photo,
                      size: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: CommonText(
                        text: "Galerie",
                        fontSizeText: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
