import 'package:agro/dieases.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:agro/splash.dart';
import 'package:agro/camerascreen.dart';

const String camerahome = '/camera';
const String dieases = '/dieases';

List<CameraDescription>? camers = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  camers = await availableCameras();

  runApp(MaterialApp(
    title: "Camera App",
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: <String, WidgetBuilder>{
      camerahome: (BuildContext context) => CameraHomeScreen(camers),
      dieases: (BuildContext context) => DiseaseCategory(),
    },
  ));
}
