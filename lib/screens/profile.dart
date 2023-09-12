import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentform/providers/student_provider.dart';
import 'package:studentform/screens/editstd_screen.dart';

// ignore: must_be_immutable
class Profilescreen extends StatelessWidget {
  int index;
  Profilescreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text('Profile Of ${value.studentio[index].name}'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                  width: 100,
                  child: Image.asset(
                      'assets/football-illustration-file-sports-design-logo-free-png.webp'),
                ),
                FittedBox(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Color.fromARGB(255, 31, 28, 28)),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: FileImage(
                                File(value.studentio[index].profile!)),
                            radius: 65,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "Student'sName",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "Student's Age",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "Phone Number",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Total mark',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    ":",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    ":",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(":", style: TextStyle(fontSize: 17)),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(":", style: TextStyle(fontSize: 17)),
                                ],
                              ),
                              SizedBox(
                                width: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      value.studentio[index].name!,
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      value.studentio[index].age!,
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(value.studentio[index].number!,
                                        style: const TextStyle(fontSize: 17)),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(value.studentio[index].mark!,
                                        style: const TextStyle(fontSize: 17)),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 50)),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return EditStudent(index: index);
                      }));
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text(
                      'Edit',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
          ),
        )),
      ),
    );
  }
}
