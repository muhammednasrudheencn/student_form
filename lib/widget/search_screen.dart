import 'dart:io';

import 'package:flutter/material.dart';
import 'package:studentform/functions/db_function.dart';
import 'package:studentform/model/data_model.dart';
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
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ValueListenableBuilder(
        valueListenable: students,
        builder: (BuildContext context, List<Studentform> studentlist,
            Widget? child) {
          return ListView.builder(
              itemBuilder: (context, index) {
                final data = studentlist[index];
                if (data.name!
                    .toLowerCase()
                    .contains(query.toLowerCase().trim())) {
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
                        title: Text(data.name!,
                            style: const TextStyle(fontSize: 20)),
                      ),
                      const Divider()
                    ],
                  );
                } else {
                  return const Text('');
                }
              },
              itemCount: studentlist.length);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ValueListenableBuilder(
        valueListenable: students,
        builder: (BuildContext context, List<Studentform> studentlist,
            Widget? child) {
          return ListView.builder(
              itemBuilder: (context, index) {
                final data = studentlist[index];
                if (data.name!
                    .toLowerCase()
                    .contains(query.toLowerCase().trim())) {
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
                        title: Text(data.name!,
                            style: const TextStyle(fontSize: 20)),
                      ),
                      const Divider()
                    ],
                  );
                } else {
                  return const Text('');
                }
              },
              itemCount: studentlist.length);
        },
      ),
    );
  }
}
