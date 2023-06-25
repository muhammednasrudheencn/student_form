import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:studentform/model/data_model.dart';

ValueNotifier<List<Studentform>> students = ValueNotifier([]);

Future<void> addstudent(Studentform student) async {
  final studentdb = await Hive.openBox<Studentform>('student_db');
  students.value.add(student);
  await studentdb.add(student);
  students.notifyListeners();
}

Future<void> getstudent() async {
  final studentdb = await Hive.openBox<Studentform>('student_db');
  students.value.clear();
  students.value.addAll(studentdb.values);
  students.notifyListeners();
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
  students.notifyListeners();
}
