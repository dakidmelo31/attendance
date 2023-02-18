import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';

import '../models/Student.dart';

class DataProvider with ChangeNotifier{
  List<Student> students = [], verifiedStudents = [];
  DataProvider(){
    getUsers();
  }
  getUsers(){
    final faker = Faker();

    for(var i = 0; i < 10;  i++){
      if(i <=1){
        continue;
      }
      students.add(Student(
          id: Random().nextInt(100),
          location: "assets/faces/face$i${i<4?".jpeg": ".jpg"}",
          name: faker.person.firstName()));
    }
    notifyListeners();
  }
}