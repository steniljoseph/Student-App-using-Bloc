import 'package:hive/hive.dart';
part 'models.g.dart';

@HiveType(typeId: 0)
class StudentModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String age;

  @HiveField(2)
  final String cls;

  @HiveField(3)
  final String mobile;

  @HiveField(4)
  final dynamic imagePath;

  StudentModel(
      {required this.name,
      required this.age,
      required this.cls,
      required this.mobile,
      required this.imagePath});
}
