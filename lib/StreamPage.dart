import 'package:camera/camera.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mi_card/main.dart';
import 'package:video_player/video_player.dart';
import 'package:volume/volume.dart';
import '';

class StreamPage extends StatefulWidget {
  @override
  _StreamPageState createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  FlickManager flickManager;
  CameraController cameraController;
  bool cameraOn = false;

  double sliderValue = 20.0;
  int maxVol,currentVol;
  Offset position = Offset(0,0);
  bool changedVal = false;

  Future<void> initPlatformState() async{
    await Volume.controlVolume(AudioManager.STREAM_MUSIC);
  }

  updateVolumes() async{
    maxVol = await Volume.getMaxVol;
    currentVol = await Volume.getVol;
  }

  setVol(int i) async{
    await Volume.setVol(i);
  }


  @override
  void initState() {
    // TODO: implement initState
    cameraController = CameraController(cameras[1],ResolutionPreset.medium);
    initPlatformState();
    cameraController.initialize().then((value){
      if(!mounted){
        setState(() {
          cameraOn = false;
        });
      }
      else{
        setState(() {
          cameraOn = true;
        });
      }
    });
    super.initState();
    flickManager = FlickManager(videoPlayerController: VideoPlayerController.asset('videos/temp.mp4'));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController.dispose();
    flickManager.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return cameraOn?Scaffold(
      body: GestureDetector(
        onPanStart: (val){
          setState(() {
            changedVal = true;
          });
        },
        onPanUpdate: (value){
          var temp = position;
          setState(() {
            position = value.globalPosition;
            if(position.dy<117 || position.dx<116){
                position = temp;
            }
            else if((position.dy - temp.dy).abs()<1.0 && (position.dx-temp.dx).abs()<1.0){
              position = temp;
            }
          });
          print(position);
        },
        child: Stack(
          children: [
            FlickVideoPlayer(
              flickManager: flickManager,
              preferredDeviceOrientation: [
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ],
              systemUIOverlay: [],
            ),
            Positioned(
              bottom: changedVal?MediaQuery.of(context).size.height - position.dy:MediaQuery.of(context).size.height*0.02,
              right: changedVal?MediaQuery.of(context).size.width - position.dx:MediaQuery.of(context).size.width*0.03,
              child: RotatedBox(
                quarterTurns: 3,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.347,
                  width: MediaQuery.of(context).size.width*0.11,
                  color: Colors.black,
                  child: AspectRatio(
                    aspectRatio: cameraController.value.aspectRatio,
                    child: CameraPreview(cameraController),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height*0.01,
              left: MediaQuery.of(context).size.width*0.05,
              child: Slider(
                activeColor: Colors.amberAccent,
                min: 0.0,
                max: 20.0,
                onChanged: (newValue) async{
                  setState(() {
                    sliderValue = newValue;
                  });
                  await setVol(sliderValue.toInt());
                  await updateVolumes();
                },
                value: sliderValue,
              ),
            )
          ],
        ),
      ),
    ):
    Material(
      child: Container(
        child: Center(
          child: Text(
            'Please wait until we get the Camera Feed'
          ),
        ),
      ),
    );
  }
}
