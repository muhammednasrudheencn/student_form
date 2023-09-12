import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studentform/model/data_model.dart';

class StudentProvider extends ChangeNotifier {
  List<Studentform> studentio = [];

  Future<void> addstudent(Studentform student) async {
    final studentdb = await Hive.openBox<Studentform>('student_db');
    studentio.add(student);
    await studentdb.add(student);
    
  }

  Future<void> getstudent() async {
    final studentdb = await Hive.openBox<Studentform>('student_db');
    studentio.clear();
    studentio.addAll(studentdb.values);
   
  }

  Future<void> deletestudent(int index) async {
    final studentdb = await Hive.openBox<Studentform>('student_db');
    await studentdb.deleteAt(index);
    getstudent();
  }

  Future<void> editstudent(int index, Studentform student) async {
    final studentdb = await Hive.openBox<Studentform>('student_db');
    await studentdb.putAt(index, student);
    getstudent();
    
  }
}
