import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mi_card/LoginPage.dart';
import 'package:mi_card/StreamPage.dart';

List cameras;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  cameras = await availableCameras();
  print('hello');
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yellow Class',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: LoginPage(),
    );
  }
}
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Player'),
//       ),
//       body: ListView(
//         children: <Widget>[
//           ChewieListItem(
//             videoPlayerController: VideoPlayerController.asset('videos/4. The Anatomy of a Flutter App.mp4'),
//             looping: true,
//           )
//         ],
//       ),
//     );
//   }
// }

