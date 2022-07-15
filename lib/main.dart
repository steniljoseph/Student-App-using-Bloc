import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:std/bloc/search/search_bloc.dart';
import 'package:std/db/models.dart';
import 'package:std/bottomnav.dart';
import 'bloc/changeicon/iconchange_bloc.dart';
import 'cubit/bottom_cubit/bottomnav_cubit.dart';
import 'cubit/studentlist/studentlist_cubit.dart';
import 'db/functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(StudentModelAdapter());
  await Hive.openBox<StudentModel>('student');

  runApp(
    MyApp(
      searchBloc: SearchBloc(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SearchBloc searchBloc;
  const MyApp({Key? key, required this.searchBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => searchBloc,
        ),
        BlocProvider(
          create: (context) => BottomnavCubit(),
        ),
        BlocProvider(
          create: (context) => IconchangeBloc(),
        ),
        BlocProvider(
          create: (context) => StudentListCubit(
            list: DatabaseFunctions.getStudentsList(),
            searchBloc: searchBloc,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            color: Colors.black,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                primary: Colors.grey,
                onPrimary: Colors.black),
          ),
        ),
        home: ScreenHome(),
      ),
    );
  }
}
