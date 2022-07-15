import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:std/db/functions.dart';
import 'package:std/db/models.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc()
      : super(SearchInitial(studentList: DatabaseFunctions.getStudentsList())) {
    on<SearchInputEvent>(
      (event, emit) {
        List<StudentModel> std = DatabaseFunctions.getStudentsList()
            .where((element) => element.name
                .toLowerCase()
                .startsWith(event.searchInput.toLowerCase()))
            .toList();
        emit(SearchInitial(studentList: std));
      },
    );
    on<ClearSeachEvent>(
      (event, emit) {
        emit(SearchInitial(studentList: DatabaseFunctions.getStudentsList()));
      },
    );
  }
}
