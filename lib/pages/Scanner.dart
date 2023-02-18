import 'package:attendance/main.dart';
import 'package:attendance/models/Student.dart';
import 'package:attendance/utility/Globals.dart';
import 'package:attendance/utility/MLService.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:lottie/lottie.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key, this.login = false}) : super(key: key);
  final bool login;

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  late CameraController cameraController;
  late final Vision _googleMlKit;
  bool capturing = false;

  final TextEditingController _textController = TextEditingController();

  // final _mlService= MLService();
  Future<void> googleInit() async {
    _googleMlKit = GoogleMlKit.vision;
    // await faceDetector.processImage(inputImage)
  }

  final List<Face> _faces = [];
  final faceDetector = FaceDetector(
      options: FaceDetectorOptions(
    enableTracking: true,
  ));

  @override
  void initState() {
    googleInit();

    cameraController = CameraController(cameras[1], ResolutionPreset.max);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        debugPrint("Camera mounted");
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case "CameraAccessDenied":
            break;
          default:
            break;
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Globals.backgroundColor,
      body: !cameraController.value.isInitialized
          ? const Center(child: Text("Give permission to camera"))
          : Column(
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
                Padding(
                  padding: const EdgeInsets.all(38.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: CameraPreview(
                      cameraController,
                      child: Material(
                        color: Globals.primaryColor.withOpacity(.6),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Lottie.asset("assets/face4.json",
                                reverse: true,
                                options: LottieOptions(enableMergePaths: true)),
                          ),
                        ),
                      ),
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
                            onTap: () {
                              HapticFeedback.heavyImpact();
                              capturing = false;
                              cameraController
                                  .startImageStream((CameraImage image) async {
                                if (capturing) {
                                  return;
                                }
                                capturing = true;
                                final data = GoogleMlKit.vision.faceDetector().processImage(InputImage.fromBytes(bytes: image.planes[0].bytes, inputImageData: InputImageData(size: Size(image.width.toDouble(), image.height.toDouble(),),
                                    imageRotation: rotationIntToImageRotation(cameraController.description.sensorOrientation),
                                    inputImageFormat: InputImageFormat.bgra8888,
                                    planeData: image.planes
                                        .map((e) => InputImagePlaneMetadata(
                                        bytesPerRow: e.bytesPerRow, height: e.height, width: e.width))
                                        .toList())));

                                debugPrint("${data}");

                                // _predictFacesFromImage(image: image)
                                //     .then((value) {
                                //   capturing = false;
                                // });
                                return null;
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 14.0),
                              child: Text("Take Picture"),
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

  List<Face> facesDetected = [];

  _predictFacesFromImage({required CameraImage image}) async {
    await detectFacesFromImage(image);

    if (facesDetected.isNotEmpty) {

      if (widget.login) {
        debugPrint("Done signing in");
      }
    }
  }

  Future<void> detectFacesFromImage(CameraImage image) async {
    InputImageData _firebaseImageMetadata = InputImageData(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        imageRotation: rotationIntToImageRotation(
            cameraController.description.sensorOrientation),
        inputImageFormat: InputImageFormat.bgra8888,
        planeData: image.planes
            .map((e) => InputImagePlaneMetadata(
                bytesPerRow: e.bytesPerRow, height: e.height, width: e.width))
            .toList());
    InputImage _firebaseVisionImage = InputImage.fromBytes(
        bytes: image.planes[0].bytes, inputImageData: _firebaseImageMetadata);
    var result =
        await _googleMlKit.faceDetector().processImage(_firebaseVisionImage);
    if (result.isNotEmpty) {
      debugPrint("Face Detected");
      facesDetected = result;
    }
  }

  rotationIntToImageRotation(int sensorOrientation) {
    return InputImageRotationValue.fromRawValue(sensorOrientation);
  }
}
