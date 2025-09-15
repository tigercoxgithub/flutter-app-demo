import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class Viewer3DPage extends StatefulWidget {
  const Viewer3DPage({super.key});

  @override
  State<Viewer3DPage> createState() => _Viewer3DPageState();
}

class _Viewer3DPageState extends State<Viewer3DPage> {
  Flutter3DController controller = Flutter3DController();
  String srcGlb = 'assets/assets/models/astronaut.glb';

  @override
  void initState() {
    super.initState();
    controller.onModelLoaded.addListener(() {
      debugPrint('model is loaded : ${controller.onModelLoaded.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0d2039),
        title: const Text(
          '3D Viewer Tiger',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xffffffff),
              Colors.grey,
            ],
            stops: [0.1, 1.0],
            radius: 0.7,
            center: Alignment.center,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Flutter3DViewer(
                activeGestureInterceptor: true,
                progressBarColor: Colors.orange,
                enableTouch: true,
                onProgress: (double progressValue) {
                  debugPrint('model loading progress : $progressValue');
                },
                onLoad: (String modelAddress) {
                  debugPrint('model loaded : $modelAddress');
                },
                onError: (String error) {
                  debugPrint('model failed to load : $error');
                },
                controller: controller,
                src: srcGlb,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
