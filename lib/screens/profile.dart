import 'dart:io';

import 'package:flutter/material.dart';
import 'package:studentform/functions/db_function.dart';
import 'package:studentform/screens/editstd_screen.dart';

class Profilescreen extends StatelessWidget {
  int index;
  Profilescreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(students.value[index].name!),
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
                    child: ValueListenableBuilder(
                        valueListenable: students,
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: FileImage(
                                    File(students.value[index].profile!)),
                                radius: 65,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
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
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Text(
                                          students.value[index].name!,
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Text(
                                          students.value[index].age!,
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Text(students.value[index].number!,
                                            style:
                                                const TextStyle(fontSize: 17)),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Text(students.value[index].mark!,
                                            style:
                                                const TextStyle(fontSize: 17)),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        }),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return EditStudent(index: index);
                    }));
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'))
            ],
          ),
        ),
      )),
    );
  }
}
