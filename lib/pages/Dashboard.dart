import 'dart:convert';
import 'dart:ui';

import 'package:attendance/pages/Scanner.dart';
import 'package:attendance/utility/Globals.dart';
import 'package:attendance/utility/transitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../models/Student.dart';
import '../utility/Data.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.title});

  final String title;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime selectedDate = DateTime.now();



  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<DataProvider>(context, listen: false);
    final size = Globals.getSize(context);
    final List<Student> studentLists = _data.students;
    final verifiedStudentLists = _data.students;
    return Scaffold(
      backgroundColor: const Color(0xFFE0FBFC),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: 0.0,
            left: 0.0,
            height: size.height,
            width: size.width,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
              SliverList(delegate: SliverChildListDelegate([
                const Padding(
                  padding: EdgeInsets.only(top: 38.0, left: 15.0, bottom: 30.0),
                  child: Text("Attendance", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 38)),
                ),
                AbsorbPointer(
                  absorbing: true,
                  child: SizedBox(
                    height: 80,
                    child: HorizontalCalendar(
                      backgroundColor: Globals.backgroundColor,
                      selectedColor: Globals.primaryColor,
                      textColor: Globals.primaryColor,
                      key: UniqueKey(), date: DateTime.now(),
                      initialDate: DateTime.now(),
                      showMonth: true,
                      onDateSelected: (date){},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: Material(
                    color: const Color(0xFFE0FBFC),
                    shape: const CircleBorder(),
                    elevation: 20.0,
                    shadowColor: Colors.teal.withOpacity(.25),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: (){
                        HapticFeedback.heavyImpact();
                      },
                      child: Padding(
                        padding:const EdgeInsets.all(90.0),
                        child: Center(child: RichText(text:const TextSpan(children: [TextSpan(text: " of ", children: [TextSpan(text: "0")])], text: "0", style: TextStyle(color:Colors.pink, fontSize: 28.0)),)),
                      ),
                    )
                  ),
                ),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        FloatingActionButton.large(
                          backgroundColor: Globals.backgroundColor,
                          elevation: 0.0,
                          focusElevation: 15,
                          hoverElevation: 20.0,
                          enableFeedback: true,
                          disabledElevation: 0.0,
                          onPressed: (){
                          HapticFeedback.heavyImpact();
                          Navigator.push(context, SizeTransition2(const Scanner()));
                        }, child: ClipOval(child: Lottie.asset("assets/face5.json", fit: BoxFit.contain, alignment: Alignment.center)),),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Register", style: TextStyle(color: Globals.primaryColor, fontWeight: FontWeight.w600),),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        FloatingActionButton.large(
                          backgroundColor: Globals.backgroundColor,
                          elevation: 0.0,
                          focusElevation: 15,
                          hoverElevation: 20.0,
                          enableFeedback: true,
                          disabledElevation: 0.0,
                          highlightElevation: 25.0,
                          onPressed: (){
                          HapticFeedback.heavyImpact();
                          Navigator.push(context, SizeTransition2(const Scanner()));
                        }, child: ClipOval(child: Lottie.asset("assets/face2.json", fit: BoxFit.contain, alignment: Alignment.center)),),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Login", style: TextStyle(color: Globals.primaryColor, fontWeight: FontWeight.w600),),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 80),
              ]),)
              ],
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            child: Center(
              child: ClipRRect(
                child: Material(
                  color: Globals.backgroundColor,
                  shadowColor: Globals.primaryColor,
                  elevation: 20.0,
                  child: SizedBox(
                    width: size.width - 25.0,
                    height: 120.0,
                    child: ListView.builder(
                      itemCount: studentLists.length,
                      itemBuilder: (_, index){
                        final std = studentLists[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              ClipOval(child: Image.asset(std.location, width: 65.0, height: 65.0, fit: BoxFit.cover,)),
                              Text(std.name, style:const TextStyle(fontWeight: FontWeight.w700))
                            ],
                          ),
                        );
                      },
                      padding:const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                      scrollDirection: Axis.horizontal,
                      physics:const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    ),
                  ),
                ),
              ),
            ),
          )

        ],
      ) ,
    );
  }
}
