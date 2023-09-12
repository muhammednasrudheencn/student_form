import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:studentform/providers/student_provider.dart';
import 'package:studentform/screens/add_student.dart';
import 'package:studentform/screens/editstd_screen.dart';
import 'package:studentform/screens/profile.dart';
import 'package:studentform/widget/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentprovider = Provider.of<StudentProvider>(context);
    studentprovider.getstudent();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Form'),
        centerTitle: true,
        leading: const Icon(Icons.menu),
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
          child: Consumer<StudentProvider>(
            builder: (context, value, child) => ListView.separated(
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
                          FileImage(File(value.studentio[index].profile!)),
                    ),
                    title: Text(value.studentio[index].name!,
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
                itemCount: value.studentio.length),
          ),
        ),
      ),
    );
  }

  void showalert(BuildContext context, int index) {
    final value = Provider.of<StudentProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'delete ${value.studentio[index].name}',
              style: const TextStyle(fontSize: 25),
            ),
            content: const Text('all the related datas will clear '),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text(
                        'no',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                  TextButton(
                      onPressed: () {
                        value.deletestudent(index);
                        Navigator.of(context).pop();
                      },
                      child: const Text('yes',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)))
                ],
              ),
            ],
          );
        });
  }
}
