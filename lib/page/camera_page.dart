import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/class/app_class.dart';
import 'package:mon_petit_entretien/style/colors.dart';
import 'package:provider/provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.cameras, required this.isVehicle})
      : super(key: key);

  final List<CameraDescription>? cameras;
  final bool isVehicle;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![0]);
  }

  void takePictureLoaded() {
    AppData data;
    data = Provider.of<AppData>(context, listen: false);
    takePicture(data);
  }

  void takePicture(AppData data) async {
    if (!_cameraController.value.isInitialized) {
      return;
    }
    if (_cameraController.value.isTakingPicture) {
      return;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      final XFile picture = await _cameraController.takePicture();
      if (kIsWeb) {
        final Uint8List pickedFileBytes = await picture.readAsBytes();
        if (widget.isVehicle) {
          data.vehicles.last.updatePicketFilesBytes(pickedFileBytes);
        } else {
          data.user.updatePicketFilesBytes(pickedFileBytes);
        }
      } else {
        if (widget.isVehicle) {
          data.vehicles.last.updatePicturePath(picture.path);
        } else {
          data.user.updatePicturePathModif(picture.path);
        }
      }
      if (mounted) {
        Navigator.pop(context);
      }
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return;
    }
  }

  void initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            if (_cameraController.value.isInitialized)
              CameraPreview(_cameraController)
            else
              Container(
                color: Colors.black,
                child: const Center(child: CircularProgressIndicator()),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.10,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  color: navy,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        key: const Key("turn_camera_button"),
                        padding: EdgeInsets.zero,
                        iconSize: 30,
                        icon: Icon(
                          _isRearCameraSelected
                              ? CupertinoIcons.switch_camera
                              : CupertinoIcons.switch_camera_solid,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(
                            () =>
                                _isRearCameraSelected = !_isRearCameraSelected,
                          );
                          initCamera(
                            widget.cameras![_isRearCameraSelected ? 0 : 1],
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        key: const Key("take_picture_button"),
                        onPressed: takePictureLoaded,
                        iconSize: 50,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.circle, color: Colors.white),
                      ),
                    ),
                    const Spacer(),
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
