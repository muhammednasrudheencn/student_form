import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:studentform/model/data_model.dart';
import 'package:studentform/providers/student_provider.dart';

import '../providers/get_image_provider.dart';

File? _image;

// ignore: must_be_immutable
class EditStudent extends StatefulWidget {
  int index;
  EditStudent({super.key, required this.index});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController _namecontroller = TextEditingController();

  TextEditingController _agecontroller = TextEditingController();

  TextEditingController _phonecontroller = TextEditingController();

  TextEditingController _markcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final studentvalue = Provider.of<StudentProvider>(context, listen: false);

    _namecontroller =
        TextEditingController(text: studentvalue.studentio[widget.index].name);
    _agecontroller =
        TextEditingController(text: studentvalue.studentio[widget.index].age);
    _phonecontroller = TextEditingController(
        text: studentvalue.studentio[widget.index].number);
    _markcontroller =
        TextEditingController(text: studentvalue.studentio[widget.index].mark);

    final imagepath = Provider.of<Imageprovider>(context, listen: false);
    imagepath.tempimagepath = studentvalue.studentio[widget.index].profile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_namecontroller.text),
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
                                      AssetImage('assets/images/gallery.png'),
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
                            getImage();
                          },
                          icon: const Icon(Icons.photo),
                          label: const Text("Add Photo")),
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
                              icon: const Icon(Icons.cancel),
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
                                          if (_image?.path == null) {
                                            addingFailed();
                                          } else {
                                            updateSuccess(widget.index);
                                          }
                                        }
                                      },
                                      icon: const Icon(Icons.save),
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

  Future<void> getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    final imageTemporary = File(image.path);

    setState(() {
      _image = imageTemporary;
    });
  }

  void addingFailed() {
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

  void updateSuccess(int index) {
    final value = Provider.of<StudentProvider>(context, listen: false);
    final value1 = Provider.of<Imageprovider>(context, listen: false);
    Studentform std = Studentform(
        name: _namecontroller.text.trim(),
        age: _agecontroller.text.trim(),
        number: _phonecontroller.text.trim(),
        mark: _markcontroller.text.trim(),
        profile: value1.tempimagepath!);
    value.editstudent(index, std);
    value1.tempimagepath = null;
    value1.notify();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${_namecontroller.text}'s details edittted successfully!"),
      backgroundColor: Colors.green,
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 2),
    ));
    value1.tempimagepath = null;
    Navigator.of(context).pop();
  }
}
