import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:strydeapp/services/firebase_service_model.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';

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
  String timeStamp;
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

  void uploadVideo(file, filename) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    String uid = _firebaseAuth.currentUser.uid;
    StorageReference ref = FirebaseStorage.instance.ref().child(uid).child(timeStamp);
    StorageUploadTask uploadTask = ref.putFile(file, StorageMetadata(contentType: 'video/mp4'));

    if (uploadTask.isSuccessful || uploadTask.isComplete) {
      final String url = await ref.getDownloadURL();
      print("The download URL is " + url);
    } else if (uploadTask.isInProgress) {

      uploadTask.events.listen((event) {
        double percentage = 100 *(event.snapshot.bytesTransferred.toDouble()
            / event.snapshot.totalByteCount.toDouble());
        print("THe percentage " + percentage.toString());
      });

      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      var downloadUrl1 = await storageTaskSnapshot.ref.getDownloadURL();

      print("Download URL " + downloadUrl1.toString());

    } else{
      // Failed/ catch
    }
  }

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
      print("Error onNewCameraSelected ");
      print(e);
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
               print('Video recorded to: $videoPath');
               var file = File(videoPath);
               uploadVideo(file, timeStamp);
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
    timeStamp = timestamp();
    final String filePath = '$dirPath/$timeStamp.mp4';

    if (controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return null;
    }

    try {
      videoPath = filePath;
      await controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      print("Error startVideoRecording");
      print(e);
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
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: CameraApp()),
    );
  }
}