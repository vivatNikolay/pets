import 'dart:io';
import 'package:hive/hive.dart';

part 'pet.g.dart';

@HiveType(typeId: 0)
class Pet extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String? species;
  @HiveField(2)
  String? breed;
  @HiveField(3)
  DateTime? dateOfBirth;
  @HiveField(4)
  bool? gender;
  @HiveField(5)
  String? imagePath;

  Pet({
    required this.name,
    this.species,
    this.breed,
    this.dateOfBirth,
    this.gender,
    this.imagePath
  });
}
