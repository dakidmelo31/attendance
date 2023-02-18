import 'dart:async';
import 'package:animations/animations.dart';
import 'package:attendance/utility/Data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utility/Globals.dart';
import 'Dashboard.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _a = false;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 700), () {
      setState(() {
        _a = !_a;
      });
    });
    Timer(const Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacement(SlideTransitionAnimation(
           const Dashboard(title: 'Home',)));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<DataProvider>(context, listen: false);
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Globals.backgroundColor,
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.fastLinearToSlowEaseIn,
            width: _a ? _width : 0,
            height: _height,
            color: Globals.primaryColor,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'School Attendance',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SlideTransitionAnimation extends PageRouteBuilder {
  final Widget page;

  SlideTransitionAnimation(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: const Duration(milliseconds: 2000),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
              );
              return SlideTransition(
                position: Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                    .animate(animation),
                textDirection: TextDirection.rtl,
                child: page,
              );
            });
}
