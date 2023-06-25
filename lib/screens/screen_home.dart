import 'dart:io';

import 'package:flutter/material.dart';
import 'package:studentform/functions/db_function.dart';
import 'package:studentform/screens/add_student.dart';
import 'package:studentform/screens/editstd_screen.dart';
import 'package:studentform/screens/profile.dart';
import 'package:studentform/widget/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getstudent();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Form'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => AddStudentScreen(),
          ));
        },
        child: const Icon(Icons.person_add_alt_sharp),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ValueListenableBuilder(
              valueListenable: students,
              builder: (context, studentlist, child) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return Profilescreen(
                              index: index,
                            );
                          }));
                        },
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              FileImage(File(studentlist[index].profile!)),
                        ),
                        title: Text(studentlist[index].name!,
                            style: const TextStyle(fontSize: 20)),
                        trailing: FittedBox(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
                                    return EditStudent(index: index);
                                  }));
                                },
                                icon: const Icon(Icons.edit_note),
                                color: Colors.grey,
                              ),
                              IconButton(
                                onPressed: () {
                                  showalert(context, index);
                                },
                                icon: const Icon(Icons.delete_sweep),
                                color: Colors.red,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: students.value.length);
              }),
        ),
      ),
    );
  }

  void showalert(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('delete ${students.value[index].name}'),
            content: const Text('all the related datas will clear '),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('no')),
              TextButton(
                  onPressed: () {
                    deletestudent(index);
                    Navigator.of(context).pop();
                  },
                  child: const Text('yes'))
            ],
          );
        });
  }
}
