part of 'studentlist_cubit.dart';

// class StudentlistState {
//   final String? imageUrl;
//   final List<StudentModel> list;
//   const StudentlistState({this.imageUrl, required this.list});
// }

// class AllStudentState extends StudentlistState {
//   final List<StudentModel> studentsList;
//   const AllStudentState({required this.studentsList})
//       : super(list: studentsList);
// }

// class NoResultState extends StudentlistState {
//   NoResultState({List<StudentModel>? list}) : super(list: []);
// }

abstract class StudentListState extends Equatable {}

class StudentCrudCubitInitial extends StudentListState {
  @override
  List<Object?> get props => [];
}

class AllStudentState extends StudentListState {
  final List<StudentModel> studentsList;
  AllStudentState({required this.studentsList});

  @override
  List<Object?> get props => [studentsList];
}

class NoResultsState extends StudentListState {
  @override
  List<Object?> get props => [];
}
