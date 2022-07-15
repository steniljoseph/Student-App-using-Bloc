// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:std/screens/add_student.dart';
import 'package:std/screens/list_student.dart';
import 'cubit/bottom_cubit/bottomnav_cubit.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);
  int curentindex = 0;

  final List<Widget> screens = <Widget>[
    ListStudent(),
    const AddStudent(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomnavCubit, BottomnavState>(
        builder: (context, state) {
          return Center(
            child: screens.elementAt(curentindex),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        currentIndex: curentindex,
        onTap: (index) {
          curentindex = context.read<BottomnavCubit>().changeIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'View and Edit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Student',
          ),
        ],
      ),
    );
  }
}
