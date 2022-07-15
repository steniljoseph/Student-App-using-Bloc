// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:std/cubit/studentlist/studentlist_cubit.dart';
import '../db/functions.dart';
import '../db/models.dart';

class UpdateStudent extends StatefulWidget {
  var box = Hive.box<StudentModel>('student');
  final List<StudentModel> student;
  final int index;

  UpdateStudent({Key? key, required this.student, required this.index}) : super(key: key);

  @override
  _UpdateStudentState createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  late StudentModel student;
  XFile? image;

  String? imagePath;

  void previousDetails() {
    student = DatabaseFunctions.getStudent(widget.index);
    nameController.text = widget.student[widget.index].name;
    ageController.text = widget.student[widget.index].age;
    classController.text = widget.student[widget.index].cls;
    mobileController.text = widget.student[widget.index].mobile;
    imagePath = widget.student[widget.index].imagePath;
  }

  @override
  void initState() {
    previousDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(nameController.text);
    print(ageController.text);
    print(classController.text);
    print(mobileController.text);
    print(imagePath);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Update Student'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Your Name';
                  }
                  return null;
                },
                controller: nameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Your Age';
                  }
                  return null;
                },
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person_pin),
                  border: OutlineInputBorder(),
                  hintText: 'Age',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Your Class';
                  }
                  return null;
                },
                controller: classController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  icon: Icon(Icons.class_),
                  border: OutlineInputBorder(),
                  hintText: 'Class',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Your Number';
                  }
                  if (value.length < 11) {
                    return 'Please Enter Correct Number';
                  }
                  return null;
                },
                controller: mobileController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  icon: Icon(Icons.call),
                  border: OutlineInputBorder(),
                  hintText: 'Mobile Number',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => getImage(source: ImageSource.gallery),
                child: const Text('Select Image'),
              ),
              const SizedBox(
                height: 10,
              ),
              if (imagePath != null)
                ClipRRect(
                  child: Image.file(
                    File(imagePath!),
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  StudentModel studentModel = StudentModel(
                    name: nameController.text,
                    age: ageController.text,
                    cls: classController.text,
                    mobile: mobileController.text,
                    imagePath: imagePath,
                  );
                  BlocProvider.of<StudentListCubit>(context).editStudentListUpdated(
                    DatabaseFunctions.getBox(),
                    studentModel,
                    widget.index,
                  );
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.update),
                label: const Text('Update'),
              )
            ],
          ),
        ),
      ),
    );
  }

  getImage({required ImageSource source}) async {
    image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        imagePath = (image!.path);
      });
    } else {
      return null;
    }
  }
}
