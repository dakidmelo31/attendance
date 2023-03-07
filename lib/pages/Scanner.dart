import 'dart:io';

import 'package:attendance/utility/Globals.dart';
import 'package:dio/dio.dart';
import 'package:aws_rekognition_api/rekognition-2016-06-27.dart' as aws;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:lottie/lottie.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key, this.login = false}) : super(key: key);
  final bool login;

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  bool capturing = false;
  final rekognition = aws.Rekognition(region: 'us-east-2',credentials:aws.AwsClientCredentials(accessKey: 'AKIAUNRA2X7AYEAUE2WS', secretKey: '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') );

  final TextEditingController _textController = TextEditingController();

  final picker = ImagePicker();
bool readyToUpload = false;
  XFile? _image;
final dio = Dio();
  Future<void> loginFace()async{

  }
  Future<void> registerFace() async{
    debugPrint("registering user");
    // arn:aws:rekognition:us-east-2:303937798081:project/attendance_mariama/1678153269547
    // var response = await rekognition.createProject(projectName: "attendance_mariama");

    final Image image = Image.file( File(_image!.path));

    debugPrint("Now adding face");
    // var res = await rekognition.indexFaces(collectionId: "attendance_mariama", );
    // debugPrint("${response.projectArn}");


  }

  Future<void> getFace() async{
    HapticFeedback.heavyImpact();
    final img = await picker.pickImage(source: ImageSource.camera, imageQuality: 90, maxHeight: 500, maxWidth: 500, preferredCameraDevice: CameraDevice.front, requestFullMetadata: false);

    if(img != null){
      debugPrint("Image grabbed");

      setState(() {
        _image = img;
      });

      Future.delayed(const Duration(seconds: 2), (){
        setState(() {
          readyToUpload = true;
        });
      });
    }
    else{
      debugPrint("No Image found");
    }


  }

  // final _mlService= MLService();
  Future<void> runFace(CameraImage inputImage) async {
    // await faceDetector.processImage(inputImage)
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Globals.backgroundColor,
      body:Column(
              children: [
                const Spacer(),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  elevation: 20.0,
                  shadowColor: Colors.black.withOpacity(.12),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 4),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Your Name",
                        label: const Text("Name"),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        filled: false),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Enter your name before taking picture"),
                ),
                Card(
                  margin:const EdgeInsets.symmetric(horizontal: 55, vertical: 55),
                   elevation: 20.0,
                  shadowColor: Colors.black.withOpacity(.4),
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: getFace,
                    child: AnimatedPadding(
                      duration:const Duration(milliseconds: 2400),
                      curve: Curves.fastLinearToSlowEaseIn,
                      padding: EdgeInsets.all(readyToUpload? 70: 28.0),
                      child: Lottie.asset(_image != null? "assets/image1.json" : "assets/face1.json",
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      filterQuality: FilterQuality.high,),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          HapticFeedback.heavyImpact();
                          Navigator.pop(context, false);
                        },
                        backgroundColor: Globals.primaryColor,
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19.0)),
                          elevation: 15.0,
                          shadowColor: Colors.teal.withOpacity(.3),
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(19.0)),
                            onTap:widget.login? loginFace :registerFace,
                            child: Padding(
                              padding:const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 14.0),
                              child: Text(widget.login? "Verify User" : "Register account"),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 15.0)
              ],
            ),
      extendBodyBehindAppBar: true,
    );
  }

  Future<void> detectFacesFromImage(CameraImage image) async {

  }
}
