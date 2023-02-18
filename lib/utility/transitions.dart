import 'package:flutter/material.dart';

class VerticalSizeTransition extends PageRouteBuilder {
  VerticalSizeTransition({required this.child})
      : super(
            pageBuilder: (_, animation, anotherAnimation) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn);
              return SizeTransition(
                sizeFactor: animation,
                axis: Axis.vertical,
                axisAlignment: 0.0,
                child: child,
              );
            },
            transitionsBuilder: (_, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn);
              return SizeTransition(
                sizeFactor: animation,
                axis: Axis.vertical,
                axisAlignment: 0.0,
                child: child,
              );
            },
            transitionDuration: const Duration(
              milliseconds: 800,
            ),
            opaque: false,
            barrierColor: Colors.black.withOpacity(.6));

  final Widget child;
}

class HorizontalSizeTransition extends PageRouteBuilder {
  HorizontalSizeTransition({required this.child})
      : super(
            pageBuilder: (_, animation, anotherAnimation) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn);
              return SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                axisAlignment: 0.0,
                child: child,
              );
            },
            transitionsBuilder: (_, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn);
              return SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                axisAlignment: 0.0,
                child: child,
              );
            },
            transitionDuration: const Duration(
              milliseconds: 800,
            ),
            opaque: false,
            barrierColor: Colors.black.withOpacity(.6));

  final Widget child;
}

class CustomFadeTransition extends PageRouteBuilder {
  CustomFadeTransition({required this.child})
      : super(
            pageBuilder: (_, animation, anotherAnimation) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn);
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionsBuilder: (_, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn);
              return SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                axisAlignment: 0.0,
                child: child,
              );
            },
            transitionDuration: const Duration(
              milliseconds: 800,
            ),
            opaque: false,
            barrierColor: Colors.black.withOpacity(.6));

  final Widget child;
}

class SizeTransition1 extends PageRouteBuilder {
  final Widget page;

  SizeTransition1(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
class TransLucentPush extends PageRouteBuilder {
  final Widget page;

  TransLucentPush(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          opaque: false,
          barrierColor: Colors.white.withOpacity(.8),
          barrierDismissible: true,
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

class SizeTransition2 extends PageRouteBuilder {
  final Widget page;

  SizeTransition2(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.topCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

class TransparentSizeTransition2 extends PageRouteBuilder {
  final Widget page;

  TransparentSizeTransition2(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          opaque: false,
          barrierDismissible: true,
          reverseTransitionDuration: const Duration(milliseconds: 200),
          barrierColor: Colors.transparent,
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.topCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

class TransparentSizeTransition1 extends PageRouteBuilder {
  final Widget page;

  TransparentSizeTransition1(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          opaque: false,
          barrierDismissible: true,
          reverseTransitionDuration: const Duration(milliseconds: 200),
          barrierColor: Colors.transparent,
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0,
                child: page,
              ),
            );
          },
        );
}

class SizeTransition3 extends PageRouteBuilder {
  final Widget page;

  SizeTransition3(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.center,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

class SizeTransition4 extends PageRouteBuilder {
  final Widget page;

  SizeTransition4(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.centerLeft,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

class SizeTransition5 extends PageRouteBuilder {
  final Widget page;

  SizeTransition5(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.centerRight,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: const Text('Size Transition'),
      ),
    );
  }
}
