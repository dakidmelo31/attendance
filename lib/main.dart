import 'package:attendance/pages/SplashScreen.dart';
import 'package:attendance/utility/Data.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'pages/Dashboard.dart';
late List<CameraDescription> cameras;

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> DataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Attendance',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home:SplashScreen(),
      ),
    );
  }
}

