import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class Studentform {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? age;

  @HiveField(3)
  String? number;

  @HiveField(4)
  String? mark;

  @HiveField(5)
  String? profile;

  Studentform(
      {required this.name,
      required this.number,
      required this.age,
      required this.mark,
      required this.profile});
}
