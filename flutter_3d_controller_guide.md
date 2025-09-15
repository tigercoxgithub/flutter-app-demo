
# Flutter 3D Controller & Viewer Guide

This document explains how to use the **Flutter3DController** and **Flutter3DViewer** to load and interact with 3D models in Flutter.  

---

## Controller Usage

### Create Controller
```dart
// Create controller object to control 3D model.
Flutter3DController controller = Flutter3DController();
```

### Listen to Model Loading State
```dart
controller.onModelLoaded.addListener(() {
  debugPrint('model is loaded : ${controller.onModelLoaded.value}');
});
```

---

### Animation Controls
```dart
// Play animation (default behavior).
controller.playAnimation();

// Play a specific animation.
controller.playAnimation(animationName: chosenAnimation);

// Play animation only once.
controller.playAnimation(loopCount: 1);

// Play a specific animation with repeat count.
controller.playAnimation(loopCount: 2, animationName: chosenAnimation);

// Pause current animation.
controller.pauseAnimation();

// Reset and play from first frame.
controller.resetAnimation();

// Stop the animation.
controller.stopAnimation();

// Get available animations from the model.
await controller.getAvailableAnimations();
```

---

### Rotation Controls
```dart
// Start rotation (default speed = 10°/second).
controller.startRotation();

// Start rotation with custom speed.
controller.startRotation(rotationSpeed: 30);

// Pause rotation (keeps current orientation).
controller.pauseRotation();

// Stop rotation (resets orientation).
controller.stopRotation();
```

---

### Texture Controls
```dart
// Load desired texture by name.
controller.setTexture(textureName: chosenTexture);

// Get available textures from the model.
await controller.getAvailableTextures();
```

---

### Camera Controls
```dart
// Set custom camera target.
controller.setCameraTarget(0.3, 0.2, 0.4);

// Reset camera target to default.
controller.resetCameraTarget();

// Set custom camera orbit.
controller.setCameraOrbit(20, 20, 5);

// Reset camera orbit to default.
controller.resetCameraOrbit();
```

---

## Loading Models

### Load GLB/GLTF Models
```dart
Flutter3DViewer(
  activeGestureInterceptor: true, // Prevent gesture issues on iOS/Android
  progressBarColor: Colors.orange, // Customize or hide with Colors.transparent
  enableTouch: true, // Enable/disable touch control
  onProgress: (double progressValue) {
    debugPrint('model loading progress : $progressValue');
  },
  onLoad: (String modelAddress) {
    debugPrint('model loaded : $modelAddress');
  },
  onError: (String error) {
    debugPrint('model failed to load : $error');
  },
  controller: controller, // Attach controller
  src: 'assets/business_man.glb', // Local 3D model
  // src: 'assets/sheen_chair.glb',
  // src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb', // From URL
);
```

---

### Load OBJ Models
```dart
Flutter3DViewer.obj(
  src: 'assets/flutter_dash.obj',
  // src: 'https://raw.githubusercontent.com/m-r-davari/content-holder/refs/heads/master/flutter_3d_controller/flutter_dash_model/flutter_dash.obj',
  scale: 5,     // Initial scale
  cameraX: 0,   // Initial camera X
  cameraY: 0,   // Initial camera Y
  cameraZ: 10,  // Initial camera Z
  onProgress: (double progressValue) {
    debugPrint('model loading progress : $progressValue');
  },
  onLoad: (String modelAddress) {
    debugPrint('model loaded : $modelAddress');
  },
  onError: (String error) {
    debugPrint('model failed to load : $error');
  },
);
```

---

## Summary
- Use **Flutter3DController** for animations, rotation, textures, and camera control.  
- Use **Flutter3DViewer** to load **GLB/GLTF** or **OBJ** models.  
- Attach callbacks (`onProgress`, `onLoad`, `onError`) for feedback.  
