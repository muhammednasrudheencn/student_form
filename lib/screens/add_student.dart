import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:studentform/model/data_model.dart';
import 'package:studentform/providers/get_image_provider.dart';
import 'package:studentform/providers/student_provider.dart';

File? _image;

class AddStudentScreen extends StatelessWidget {
  AddStudentScreen({super.key});

  final _namecontroller = TextEditingController();

  final _agecontroller = TextEditingController();

  final _phonecontroller = TextEditingController();

  final _markcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Consumer<Imageprovider>(
                  builder: (context, value1, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.topCenter,
                          child: value1.tempimagepath == null
                              ? const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/3158176.png'),
                                  backgroundColor: Colors.white,
                                  radius: 65,
                                )
                              : CircleAvatar(
                                  radius: 65,
                                  backgroundImage: FileImage(
                                    File(value1.tempimagepath!),
                                  ),
                                )),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                          onPressed: () {
                            getimage(value1);
                          },
                          icon: const Icon(Icons.photo_camera),
                          label: const Text("Add Profile")),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _namecontroller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            label: Text("Student's Name"),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            prefixIcon: Icon(Icons.person)),
                        validator: (value) {
                          if (_namecontroller.text.isEmpty) {
                            return 'Name Field is Empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _agecontroller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            label: Text("Student's Age"),
                            prefixIcon: Icon(Icons.calendar_month_outlined)),
                        maxLength: 2,
                        validator: (value) {
                          if (_agecontroller.text.isEmpty) {
                            return 'Age Field is Empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _phonecontroller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            label: Text("Guardian's Phone"),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            prefixIcon: Icon(Icons.phone)),
                        maxLength: 10,
                        validator: (value) {
                          if (_phonecontroller.text.isEmpty) {
                            return 'Phone Field is Empty';
                          } else if (_phonecontroller.text.length < 10) {
                            return 'Enter a valid Phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _markcontroller,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            label: Text("Total Mark"),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            prefixIcon: Icon(Icons.score)),
                        validator: (value) {
                          if (_markcontroller.text.isEmpty) {
                            return 'Total Mark Field is Empty';
                          } else if (int.parse(_markcontroller.text) > 100) {
                            return 'Enter a valid Mark';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(130, 55),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Colors.grey[800]),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.cancel_outlined),
                              label: const Text("Cancel")),
                          Consumer<Imageprovider>(
                            builder: (context, value1, child) =>
                                Consumer<StudentProvider>(
                              builder: (context, value, child) =>
                                  ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(130, 55),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          backgroundColor: Colors.green[600]),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          if (value1.tempimagepath == null) {
                                            addingFailed(context);
                                          } else {
                                            addingSuccess(
                                                value, context, value1);
                                          }
                                        }
                                      },
                                      icon: const Icon(Icons.save_alt),
                                      label: const Text("Save")),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addingFailed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Please add the pofile picture!"),
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 2),
    ));
  }

  void addingSuccess(
      StudentProvider value, BuildContext context, Imageprovider value1) {
    Studentform st = Studentform(
        name: _namecontroller.text.trim(),
        age: _agecontroller.text.trim(),
        number: _phonecontroller.text.trim(),
        mark: _markcontroller.text.trim(),
        profile: value1.tempimagepath!);
    value.addstudent(st);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Text('${_namecontroller.text} is added to database successfully'),
      backgroundColor: Colors.green,
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 2),
    ));
    value1.tempimagepath = null;
    value1.notify();
    Navigator.of(context).pop();
  }

  getimage(Imageprovider value) async {
    await value.getimagepath();
  }
}
