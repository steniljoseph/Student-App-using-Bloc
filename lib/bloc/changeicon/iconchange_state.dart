part of 'iconchange_bloc.dart';

@immutable
abstract class IconChangeState extends Equatable {}

class ChangeIconState extends IconChangeState {
  final IconData iconData;
  ChangeIconState({required this.iconData});
  @override
  List<Object> get props => [iconData];
}
