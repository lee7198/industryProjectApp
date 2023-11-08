import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:industry/main.dart';
import 'package:industry/screens/access_screen.dart';

// List<CameraDescription> _cameras = <CameraDescription>[];

class Access extends StatefulWidget {
  final List<CameraDescription> cameras;

  const Access({
    super.key,
    required this.cameras,
  });

  @override
  State<Access> createState() => _AccessState();
}

class _AccessState extends State<Access> {
  late CameraController controller;

  @override
  void initState() {
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AccessScreen(),
              ),
            );
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
