import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'iconchange_event.dart';
part 'iconchange_state.dart';

class IconchangeBloc extends Bloc<IconchangeEvent, IconChangeState> {
  IconchangeBloc() : super(ChangeIconState(iconData: Icons.search)) {
    on<ChangeIconEvent>((event, emit) {
      emit(ChangeIconState(
        iconData: event.iconData == Icons.search ? Icons.close : Icons.search,
      ));
    });
  }
}
