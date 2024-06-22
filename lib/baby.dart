// ignore_for_file: prefer_const_constructors, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:math';

void main() {
  String token = generateToken();
  runApp(MaterialApp(
    home: BabyView(token: token),
  ));
}

String generateToken() {
  Random random = Random();
  String token = '';
  for (int i = 0; i < 6; i++) {
    token += random.nextInt(10).toString();
  }
  return token;
}

class BabyView extends StatefulWidget {
  final String token;

  const BabyView({Key? key, required this.token}) : super(key: key);

  @override
  _BabyViewState createState() => _BabyViewState();
}

class _BabyViewState extends State<BabyView> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  late bool _isRecording = false;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      _cameras = await availableCameras();
      _cameraController = CameraController(
        _cameras[_selectedCameraIndex],
        ResolutionPreset.medium,
      );

      await _cameraController.initialize();

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Error initializing cameras: $e');
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  String generateToken() {
    Random random = Random();
    String token = '';
    for (int i = 0; i < 6; i++) {
      token += random.nextInt(10).toString();
    }
    return token;
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: Text(generateToken()),
        ),
        body: Column(
          children: [
            Expanded(
              child: CameraPreview(_cameraController),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _isRecording ? stopRecording() : startRecording();
                  },
                  child:
                      Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    switchCamera();
                  },
                  child: Icon(Icons.switch_camera),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Future<void> startRecording() async {
    try {
      await _cameraController.startVideoRecording();
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      print('Error starting video recording: $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      final XFile videoFile = await _cameraController.stopVideoRecording();
      print('Video recorded: ${videoFile.path}');
      setState(() {
        _isRecording = false;
      });
    } catch (e) {
      print('Error stopping video recording: $e');
    }
  }

  void switchCamera() async {
    setState(() {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
      initializeCamera();
    });
  }
}
