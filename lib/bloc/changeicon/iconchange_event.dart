part of 'iconchange_bloc.dart';

abstract class IconchangeEvent extends Equatable {
  const IconchangeEvent();
}

class ChangeIconEvent extends IconchangeEvent {
  final IconData iconData;

  const ChangeIconEvent({required this.iconData});
  @override
  List<Object> get props => [];
}
