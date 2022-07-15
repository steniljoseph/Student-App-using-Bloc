// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:std/db/models.dart';
import 'package:std/widgets/view_details.dart';
import 'package:std/widgets/update_student.dart';
import '../bloc/changeicon/iconchange_bloc.dart';
import '../bloc/search/search_bloc.dart';
import '../cubit/studentlist/studentlist_cubit.dart';
import '../db/functions.dart';

class ListStudent extends StatelessWidget {
  ListStudent({Key? key}) : super(key: key);

  IconData? _iconData;
  String searchInput = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        child: BlocBuilder<IconchangeBloc, IconChangeState>(
          builder: (context, state) {
            _iconData = state.props[0] as IconData;
            return AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    context
                        .read<IconchangeBloc>()
                        .add(ChangeIconEvent(iconData: _iconData!));
                    if (_iconData == Icons.search) {
                      title = TextField(
                        // autofocus: true,
                        onChanged: (value) {
                          context
                              .read<SearchBloc>()
                              .add(SearchInputEvent(searchInput: value));
                         
                        },
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Search Students",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      );
                    } else {
                      context.read<SearchBloc>().add(ClearSeachEvent());
                      title = const Text('Student Management');
                    }
                  },
                  icon: Icon(_iconData),
                )
              ],
              title: title,
            );
          },
        ),
        preferredSize: const Size(double.infinity, 60),
      ),
      body: BlocBuilder<StudentListCubit, StudentListState>(
        builder: (context, state) {
          if (state is AllStudentState) {
            if (state.studentsList.isEmpty) {
              return const Center(
                child: Text('List is empty add some students'),
              );
            } else {
              final List<StudentModel> stdata = state.studentsList;
              return ListView.separated(
                 physics: const BouncingScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return ListTile(
                    leading: stdata[index].imagePath == null
                        ? const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.green,
                          )
                        : CircleAvatar(
                            radius: 30,
                            child: ClipOval(
                              child: Image.file(
                                File(stdata[index].imagePath),
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    title: Text(stdata[index].name),
                    subtitle: Text(stdata[index].cls),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ViewDetails(
                            student: stdata,
                            index: index,
                          ),
                        ),
                      );
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => UpdateStudent(
                                  student: stdata,
                                  index: index,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Are you sure? '),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No')),
                                      TextButton(
                                        onPressed: () {
                                          int deleteKey = stdata[index].key;
                                          context
                                              .read<StudentListCubit>()
                                              .deleteStudentListUpdated(
                                                DatabaseFunctions.getBox(),
                                                deleteKey,
                                              );
                                          context
                                              .read<SearchBloc>()
                                              .add(ClearSeachEvent());
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Yes'),
                                      )
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const SizedBox();
                },
                itemCount: stdata.length,
              );
            }
          } else if (state is NoResultsState) {
            return const Center(
              child: Text('No Results found'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget title = const Text(
    "Student Management",
  );
}
