part of 'search_bloc.dart';

class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  final List<StudentModel> studentList;
  const SearchInitial({required this.studentList});
}
