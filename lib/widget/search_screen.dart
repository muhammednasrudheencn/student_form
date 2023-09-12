import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentform/providers/student_provider.dart';
import 'package:studentform/screens/editstd_screen.dart';
import 'package:studentform/screens/profile.dart';

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final student = Provider.of<StudentProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ListView.builder(
          itemBuilder: (context, index) {
            final data = student.studentio[index];
            if (data.name!.toLowerCase().contains(query.toLowerCase().trim())) {
              return Column(
                children: [
                  ListTile(
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
                      backgroundImage: FileImage(
                        File(data.profile!),
                      ),
                    ),
                    title:
                        Text(data.name!, style: const TextStyle(fontSize: 20)),
                  ),
                  const Divider()
                ],
              );
            } else {
              return const Text('');
            }
          },
          itemCount: student.studentio.length),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final student = Provider.of<StudentProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ListView.builder(
          itemBuilder: (context, index) {
            final data = student.studentio[index];
            if (data.name!.toLowerCase().contains(query.toLowerCase().trim())) {
              return Column(
                children: [
                  ListTile(
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
                      backgroundImage: FileImage(
                        File(data.profile!),
                      ),
                    ),
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
                    title:
                        Text(data.name!, style: const TextStyle(fontSize: 20)),
                  ),
                  const Divider()
                ],
              );
            } else {
              return const Text('');
            }
          },
          itemCount: student.studentio.length),
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
