// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:std/db/models.dart';

class ViewDetails extends StatelessWidget {
  final int index;
  final List<StudentModel> student;
  ViewDetails({Key? key, required this.student, required this.index})
      : super(key: key);

  var box = Hive.box<StudentModel>('student');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: const Text('Student Details'),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child: student[index].imagePath == null
                    ? null
                    : ClipOval(
                        child: Image.file(
                          File(student[index].imagePath),
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      )),
            const SizedBox(
              height: 10,
            ),
            Text(
              'NAME: ${student[index].name.toUpperCase()}',
              style: const TextStyle(color: Colors.blue, fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'AGE: ${student[index].age}',
              style: const TextStyle(color: Colors.blue, fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'CLASS :${student[index].cls}',
              style: const TextStyle(color: Colors.blue, fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'MOBILE: ${student[index].mobile}',
              style: const TextStyle(color: Colors.blue, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
