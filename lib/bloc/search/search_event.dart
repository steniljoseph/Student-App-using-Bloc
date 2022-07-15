part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  const SearchEvent();
}

class SearchInputEvent extends SearchEvent {
  final String searchInput;
  const SearchInputEvent({required this.searchInput});
}

class ClearSeachEvent extends SearchEvent {}
