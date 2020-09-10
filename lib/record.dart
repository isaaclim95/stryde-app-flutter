import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

List<CameraDescription> cameras = [];

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() {
    return _CameraAppState();
  }
}

class _CameraAppState extends State<CameraApp>
    with WidgetsBindingObserver {
  CameraController controller;
  int camera = 0;
  String videoPath;
  VideoPlayerController videoController;
  VoidCallback videoPlayerListener;
  int duration = 5;
  bool playback = false;

  // Look at this -----------------------------------------------
  /*@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        //onNewCameraSelected(controller.description);
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: _cameraPreviewWidget(),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: controller != null && controller.value.isRecordingVideo
                      ? Colors.redAccent
                      : Colors.grey,
                  width: 3.0,
                ),
              ),
            ),
          ),
          _captureControlRowWidget(),
        ],
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      if(!playback){
        return AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: CameraPreview(controller),
        );
      }else{
        return AspectRatio(
            aspectRatio:
            videoController.value.size != null
                ? videoController.value.aspectRatio
                : 1.0,
            child: VideoPlayer(videoController));
      }
    }
  }

  void changePlayback(){
    setState(() {
      print(videoController);
      playback ? playback = false : playback = true;
    });
  }

  /// Camera buttons
  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.cached),
          color: Colors.blue,
          onPressed: playback || videoController != null ? changePlayback : null,
        ),
        IconButton(
          icon: const Icon(Icons.switch_camera),
          color: Colors.blue,
          onPressed: cameras.isEmpty ? null : onNewCameraSelected,
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          color: Colors.blue,
          onPressed: controller != null &&
              controller.value.isInitialized && !playback
              ? onVideoRecordButtonPressed
              : null,
        ),
        Text(duration.toString())
      ],
    );
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void onNewCameraSelected() async {
    CameraDescription cameraDescription;
    int cameraNumbers = 0;
    cameras.forEach((element) => cameraNumbers++);
    camera++;
    if(camera >= cameraNumbers){
      camera = 0;
    }
    cameraDescription = cameras[camera];
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
        cameraDescription,
        ResolutionPreset.medium,
        enableAudio: false
    );

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        //showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print("Error onNewCameraSelected");
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onVideoRecordButtonPressed() {
    Timer timer;
    playback = false;
    if(!controller.value.isRecordingVideo){
      duration = 5;
      startVideoRecording().then((String filePath) {
        if (mounted) setState(() {});
        //if (filePath != null) showInSnackBar('Saving video to $filePath');
      });
      timer = Timer.periodic(Duration(seconds: 1), (timer){
        setState(() {
          duration--;
          if(duration == 0){
            timer.cancel();
            stopVideoRecording().then((_) {
              //////////////////////////////////////////////////////////////////
              // Firebase code here using videoPath as directory
              if (mounted) setState(() {});
              // print('Video recorded to: $videoPath');
            });
          }
        });

      });
    }else{
      print("onVideoRecordButtonPressed Error");
    }

  }

  Future<String> startVideoRecording() async {

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Stryde_Videos';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    if (controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return null;
    }

    try {
      videoPath = filePath;
      await controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      print("Error startVideoRecording");
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording();
    } on CameraException catch (e) {
      print("Error stopVideoRecording");
      return null;
    }

    await _startVideoPlayer();
  }

  Future<void> _startVideoPlayer() async {
    final VideoPlayerController vcontroller =
    VideoPlayerController.file(File(videoPath));
    videoPlayerListener = () {
      if (videoController != null && videoController.value.size != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (mounted) setState(() {});
        videoController.removeListener(videoPlayerListener);
      }
    };
    vcontroller.addListener(videoPlayerListener);
    await vcontroller.setLooping(true);
    await vcontroller.initialize();
    await videoController?.dispose();
    if (mounted) {
      setState(() {
        videoController = vcontroller;
      });
    }
    await vcontroller.play();
    playback = true;
  }
}

class Record extends StatelessWidget {
  Record(){
    start();
  }

  Future<void> start() async{
    try {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
    } on CameraException catch (e) {
      print("Error starting camera");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: CameraApp()),
    );
  }
}