import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pets/pages/widgets/circle_image.dart';
import 'package:pets/pages/widgets/date_picker_field.dart';
import '../entities/pet.dart';
import '../services/db/pet_db_service.dart';
import 'widgets/text_field.dart';

class EditPet extends StatefulWidget {
  final String title = 'Pet';
  final Pet pet;

  const EditPet({required this.pet, Key? key}) : super(key: key);

  @override
  State<EditPet> createState() => _EditPetState(pet);
}

class _EditPetState extends State<EditPet> {
  final DateFormat formatDate = DateFormat('dd.MM.yyyy');
  final PetDBService _petDBService = PetDBService();
  late TextEditingController nameController;
  late ValueNotifier<bool> nameValidation;
  late TextEditingController dateController;
  final ImagePicker _picker = ImagePicker();
  final Pet pet;

  _EditPetState(this.pet);

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    nameController.text = pet.name;
    nameValidation = ValueNotifier(true);

    dateController = TextEditingController();
    if (pet.dateOfBirth != null) {
      dateController.text =
          formatDate.format(pet.dateOfBirth!);
    }
  }

  @override
  void dispose() {
    nameValidation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () {
                  _petDBService.delete(pet);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.clear)),
            IconButton(
                onPressed: () {
                  if (isNotValidFields()) {
                    return;
                  }
                  pet.name = nameController.text;
                  if (dateController.text.isNotEmpty) {
                    pet.dateOfBirth = formatDate.parse(dateController.text);
                  }
                  _petDBService.saveOrUpdate(pet);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ).copyWith(top: 30),
            child: Column(
              children: [
                pet.imagePath != null
                    ? CircleImage(
                        image: FileImage(File(pet.imagePath ?? "assets/images/cat.jpeg")),
                        onTap: () => pickImage(ImageSource.gallery))
                    : CircleImage(
                    image: const AssetImage("assets/images/cat.jpeg"),
                    onTap: () => pickImage(ImageSource.gallery)),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: nameController,
                  hintText: 'Name',
                  validation: nameValidation,
                ),
                  const SizedBox(
                    height: 20,
                  ),
                  DatePickerField(
                    controller: dateController,
                    hintText: 'Date of Birth',
                  ),
              ],
            ),
          ),
        ));
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(source: source);
      if (image == null) return;
      final imageTemp = image.path;
      setState(() => pet.imagePath = imageTemp);
    } on PlatformException catch (e) {
      print('Failed pick image $e');
    }
  }

  bool isNotValidFields() {
    if (nameController.text.trim().isEmpty) {
      setState(() {
        nameValidation.value = false;
      });
      return true;
    }
    return false;
  }
}
