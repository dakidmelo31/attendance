// import 'dart:io';
// import 'dart:math';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/foundation.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
//
// import '../models/Student.dart';
//
// class MLService{
//   late Interpreter interpreter;
//   List? predictedArray;
//
//   Future<Student?> predict(CameraImage image, Face face, bool login, String name) async{
//     List input = _preProcess(image, face);
//
//     input = input.reshape([1,112,112,3]);
//     List output = List.generate(1, (index) => List.filled(192,0));
//     await initializeInterpreter();
//
//     interpreter.run(input, output);
//     output = output.reshape([192]);
//
//     predictedArray = List.from(output);
//
//     if(!login){
//       debugPrint("Save user to db");
//
//     }
//     else{
//       debugPrint("Compare user");
//       Student student = Student(id: 2, location: 'location', name: 'name');
//       double threshold = 1.5;
//       int minDist = 999;
//       var distance = euclideanDistance(predictedArray!, student.faceArray!);
//       if(distance <= minDist && distance <= threshold){
//         debugPrint("User found");
//       }
//       else{
//         debugPrint("No user found");
//       }
//     }
//
//
//   }
// euclideanDistance(List l1, List l2){
//     double sum = 0;
//     for(int i = 0; i < l1.length; i++){
//       sum += pow((l1[i] - l2[i]), 2);
//     }
//     return pow(sum, .5);
// }
//   Future<void> initializeInterpreter() async{
//     Delegate? delegate;
//     try{
//       if(Platform.isAndroid){
//         delegate = GpuDelegateV2(
//           options: GpuDelegateOptionsV2(
//             isPrecisionLossAllowed: false,
//             inferencePreference: TfLiteGpuInferenceUsage.fastSingleAnswer,
//             inferencePriority1: TfLiteGpuInferencePriority.minLatency,
//             inferencePriority2: TfLiteGpuInferencePriority.auto,
//             inferencePriority3: TfLiteGpuInferencePriority.auto,
//           )
//         );
//       }
//       var interpreterOptions = InterpreterOptions()..addDelegate(delegate!);
//
//       interpreter = await Interpreter.fromAsset("model.tflite", options: interpreterOptions);
//     } catch (e){
//       debugPrint("Error initializing interpreter: $e");
//     }
//
//   }
// }