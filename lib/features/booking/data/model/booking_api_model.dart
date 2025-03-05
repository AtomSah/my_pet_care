import 'package:pet_care/features/booking/domain/entity/booking_entity.dart';
import 'package:pet_care/features/dashboard/data/model/pet_api_model.dart';

class BookingApiModel {
  final String? id;
  final PetApiModel pet;
  final String userId;
  final String name;
  final String contact;
  final String address;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BookingApiModel({
    this.id,
    required this.pet,
    required this.userId,
    required this.name,
    required this.contact,
    required this.address,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory BookingApiModel.fromJson(Map<String, dynamic> json) {
    return BookingApiModel(
      id: json['_id'],
      pet: PetApiModel.fromJson(json['pet']),
      userId: json['user'],
      name: json['name'],
      contact: json['contact'],
      address: json['address'],
      status: json['status'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pet': pet.id,
      'name': name,
      'contact': contact,
      'address': address,
      'status': status,
    };
  }

  BookingEntity toEntity() => BookingEntity(
        id: id,
        pet: pet.toEntity(),
        userId: userId,
        name: name,
        contact: contact,
        address: address,
        status: status,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  static List<BookingEntity> toEntityList(List<BookingApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
}