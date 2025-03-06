// lib/features/pet_details/data/model/pet_details_model.dart


import 'package:pet_care/features/petDetails/domain/entity/pet_details_entity.dart';

class PetDetailsModel {
  final String id;
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

  PetDetailsModel({
    required this.id,
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
  });

  factory PetDetailsModel.fromJson(Map<String, dynamic> json) {
    return PetDetailsModel(
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
      vaccinated: json['vaccinated'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
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
    };
  }

  PetDetailsEntity toEntity() {
    return PetDetailsEntity(
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
    );
  }
}