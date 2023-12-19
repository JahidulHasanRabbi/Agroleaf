import 'package:agro/drawer.dart';
import 'package:flutter/material.dart';
import 'package:agro/imagedisplay.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CameraHomeScreen extends StatefulWidget {
  final List<CameraDescription>? cameras;

  CameraHomeScreen(this.cameras);

  @override
  _CameraHomeScreenState createState() => _CameraHomeScreenState();
}

class _CameraHomeScreenState extends State<CameraHomeScreen> {
  CameraController? controller;
  File? imageFile;
  bool _isCameraReady = false;
  late ImagePicker _imagePicker;
  bool isViewingImage = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
    _imagePicker = ImagePicker();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _takepicture() async {
    if (!controller!.value.isTakingPicture) {
      try {
        final imageFile = await controller!.takePicture();
        setState(() {
          isViewingImage = true;
          this.imageFile = File(imageFile.path);
        });
        // Navigate to the ImageDisplayScreen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ImageDisplayScreen(this.imageFile!),
          ),
        );
      } catch (e) {
        print("Error taking picture: $e");
      }
    }
  }

  void _pickimagegallary() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        isViewingImage = true;
      });
      // Navigate to the ImageDisplayScreen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ImageDisplayScreen(imageFile!),
        ),
      );
    }
  }

  void _initCamera() async {
    controller = CameraController(widget.cameras![0], ResolutionPreset.max);
    controller!.addListener(() {
      if (mounted) setState(() {});
      if (controller!.value.hasError) {
        print('Camera error ${controller!.value.errorDescription}');
      }
    });
    try {
      await controller!.initialize();
    } on CameraException catch (e) {
      print('*********** $e');
    }
    if (mounted) {
      setState(() {
        _isCameraReady = true;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    if (!_isCameraReady) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      drawer: SideDrawer(),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: CameraPreview(controller!),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 120.0,
              padding: EdgeInsets.all(20.0),
              color: Color.fromRGBO(0, 0, 0, 0.7),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        onTap: () {
                          _takepicture();
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          child: Image.asset(
                            'assets/image/ic_shutter_1.png',
                            width: 72.0,
                            height: 72.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        onTap: () {
                          _pickimagegallary();
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          child: Image.asset(
                            'assets/image/ic_no_image.png',
                            color: Colors.grey[200],
                            width: 42.0,
                            height: 42.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Builder(
            builder: (BuildContext context) {
              return Align(
                alignment: Alignment(-0.9, -0.9),
                child: IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
