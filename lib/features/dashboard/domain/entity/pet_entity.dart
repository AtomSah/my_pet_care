// lib/features/dashboard/domain/entity/pet_entity.dart

import 'package:equatable/equatable.dart';

class PetEntity extends Equatable {
  final String? id;
  final String name;
  final String type;
  final String breed;
  final String age;
  final String gender;
  final String weight;
  final String color;
  final String location;
  final String price;
  final String description;
  final bool vaccinated;
  final String image;
  final bool available;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PetEntity({
    this.id,
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.gender,
    required this.weight,
    required this.color,
    required this.location,
    required this.price,
    required this.description,
    required this.vaccinated,
    required this.image,
    required this.available,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        breed,
        age,
      ];
}
