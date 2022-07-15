import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:std/db/models.dart';
import 'package:std/bottomnav.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import '../cubit/studentlist/studentlist_cubit.dart';
import '../db/functions.dart';

// ignore: must_be_immutable
class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  var box = Hive.box<StudentModel>('student');

  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController classController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  XFile? image;

  String? imagePath;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Add Student'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
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
                    if (value.length < 10) {
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
                    if (formKey.currentState!.validate()) {
                      StudentModel student = StudentModel(
                          imagePath: imagePath,
                          name: nameController.text,
                          age: ageController.text,
                          cls: classController.text,
                          mobile: mobileController.text);

                      BlocProvider.of<StudentListCubit>(context)
                          .addStudentListUpdated(
                              DatabaseFunctions.getBox(), student);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ScreenHome(),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Student'),
                )
              ],
            ),
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

  onAddStudentButtonClicked() {}
}
