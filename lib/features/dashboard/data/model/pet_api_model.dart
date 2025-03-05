// lib/features/dashboard/data/model/pet_api_model.dart

import 'package:json_annotation/json_annotation.dart';
import 'package:pet_care/features/dashboard/domain/entity/pet_entity.dart';

@JsonSerializable()
class PetApiModel {
  @JsonKey(name: '_id')
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
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  PetApiModel({
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

  factory PetApiModel.fromJson(Map<String, dynamic> json) {
    return PetApiModel(
      id: json['_id'],
      name: json['name'],
      type: json['type'],
      breed: json['breed'],
      age: json['age'],
      gender: json['gender'],
      weight: json['weight'],
      color: json['color'],
      location: json['location'],
      price: json['price'],
      description: json['description'],
      vaccinated: json['vaccinated'] ?? false,
      image: json['image'],
      available: json['available'] ?? true,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'breed': breed,
      'age': age,
      'gender': gender,
      'weight': weight,
      'color': color,
      'location': location,
      'price': price,
      'description': description,
      'vaccinated': vaccinated,
      'image': image,
      'available': available,
    };
  }

  PetEntity toEntity() => PetEntity(
        id: id,
        name: name,
        type: type,
        breed: breed,
        age: age,
        gender: gender,
        weight: weight,
        color: color,
        location: location,
        price: price,
        description: description,
        vaccinated: vaccinated,
        image: image,
        available: available,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  static List<PetEntity> toEntityList(List<PetApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
}