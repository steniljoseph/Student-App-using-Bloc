import 'package:hive_flutter/hive_flutter.dart';
import 'package:std/db/models.dart';

class DatabaseFunctions {
  static Box<StudentModel> getBox() {
    final box = Hive.box<StudentModel>('student');
    return box;
  }

  static List<StudentModel> getStudentsList() {
    final List<StudentModel> studentsList =
        Hive.box<StudentModel>('student').values.toList();
    return studentsList;
  }

  static void addStudent(StudentModel student) {
    Hive.box<StudentModel>('student').add(student);
  }

  static StudentModel getStudent(int key) {
    StudentModel student = Hive.box<StudentModel>('student').get(key)!;
    return student;
  }

  static int updateStudent(int key, StudentModel student) {
    Hive.box<StudentModel>('student').put(key, student);
    return key;
  }

  static int deleteStudent(int key) {
    Hive.box<StudentModel>('student').delete(key);
    return key;
  }
}
