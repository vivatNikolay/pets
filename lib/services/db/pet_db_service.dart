import 'package:hive/hive.dart';
import '../../entities/pet.dart';
import 'db_service.dart';

class PetDBService extends DBService<Pet> {
  final boxPet = Hive.box<Pet>('pets');

  @override
  void saveOrUpdate(Pet pet) {
    if (pet.isInBox) {
      pet.save();
    } else {
      boxPet.add(pet);
    }
  }

  @override
  void delete(Pet pet) {
    if (pet.isInBox) {
      pet.delete();
    }
  }

  @override
  List<Pet> getAll() {
    return boxPet.values.toList();
  }
}
