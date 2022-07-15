import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:std/db/models.dart';
import '../../bloc/search/search_bloc.dart';
import '../../db/functions.dart';
part 'studentlist_state.dart';

class StudentListCubit extends Cubit<StudentListState> {
  final List<StudentModel> list;
  late StreamSubscription streamSubscription;
  final SearchBloc searchBloc;
  final box = Hive.box<StudentModel>('student');

  StudentListCubit({required this.list, required this.searchBloc})
      : super(StudentCrudCubitInitial()) {
        
    emit(AllStudentState(studentsList: list));
    streamSubscription = searchBloc.stream.listen((event) {
      if (event is SearchInitial) {
        if (event.studentList.isNotEmpty) {
          studentListUpdated(event.studentList);
        } else {
          emit(NoResultsState());
        }
      }
    });
    
  }

  void studentListUpdated(List<StudentModel> list) {
    emit(AllStudentState(studentsList: list));
  }

  void addStudentListUpdated(Box<StudentModel> box, StudentModel student) {
    DatabaseFunctions.addStudent(student);
    emit(AllStudentState(studentsList: box.values.toList()));
  }

  editStudentListUpdated(Box<StudentModel> box, StudentModel student, int key) {
    DatabaseFunctions.updateStudent(key, student);
    emit(AllStudentState(studentsList: box.values.toList()));
  }

  deleteStudentListUpdated(Box<StudentModel> box, int key) {
    DatabaseFunctions.deleteStudent(key);
    emit(AllStudentState(studentsList: box.values.toList()));
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
