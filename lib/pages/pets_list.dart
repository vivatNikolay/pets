import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pets/entities/pet.dart';
import 'package:pets/pages/edit_pet.dart';
import '../services/db/pet_db_service.dart';

class PetsList extends StatefulWidget {
  const PetsList({Key? key}) : super(key: key);

  @override
  State<PetsList> createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> {
  final PetDBService _petDBService = PetDBService();
  late List<Pet> _pets;

  @override
  initState() {
    _pets = _petDBService.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _pets.length,
          itemBuilder: (_, index) {
            return Card(
              shadowColor: Colors.amber,
              elevation: 4.0,
              child: ListTile(
                leading: buildImage(_pets[index]),
                title: Text('${_pets[index].name}'),
                subtitle: Text('${_pets[index].dateOfBirth}'),
                isThreeLine: true,
                onTap: () async {
                  await Navigator.push(
                      context, MaterialPageRoute(builder: (context) => EditPet(pet: _pets[index])));
                  setState(() {
                    _pets = _petDBService.getAll();
                  });
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => EditPet(pet: Pet(name: ''))));
          setState(() {
            _pets = _petDBService.getAll();
          });
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
    );
  }

  Widget buildImage(Pet pet) {
    ImageProvider imageProvider = const AssetImage("assets/images/cat.jpeg");
    if (pet.imagePath != null) {
      imageProvider = FileImage(File(pet.imagePath!));
    }
    return CircleAvatar(
      radius: 30.0,
      backgroundImage: imageProvider,
    );
  }
}
