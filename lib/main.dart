import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:industry/wedgets/access_widget.dart';

List<CameraDescription> cameras = <CameraDescription>[];

void main() async {
  cameras = await availableCameras();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Access(cameras: cameras),
    );
  }
}
