import 'package:flutter_vision/flutter_vision.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class CameraScreen extends StatefulWidget {
  late CameraController controller;

  CameraScreen({
    super.key,
    required this.controller,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  late var errorState = false;
  FlutterVision vision = FlutterVision();
  late List<Map<String, dynamic>> yoloResults;

  Future<void> yoloOnFrame(CameraImage cameraImage) async {
    final result = await vision.yoloOnFrame(
        bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        iouThreshold: 0.4,
        confThreshold: 0.4,
        classThreshold: 0.5);
    if (result.isNotEmpty) {
      setState(() {
        yoloResults = result;
      });
    }
  }

  @override
  void initState() async {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
    await vision.loadYoloModel(
        labels: 'assets/labels.txt',
        modelPath: 'assets/model.tflite',
        modelVersion: "yolov5",
        quantization: false,
        numThreads: 1,
        useGpu: false);
  }

  @override
  Widget build(BuildContext context) {
    return CameraPreview(controller);
  }
}
