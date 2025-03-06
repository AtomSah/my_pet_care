import 'package:equatable/equatable.dart';
import 'package:pet_care/features/dashboard/domain/entity/pet_entity.dart';

class BookingEntity extends Equatable {
  final String? id;
  final PetEntity pet;
  final String userId;
  final String name;
  final String contact;
  final String address;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BookingEntity({
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

  @override
  List<Object?> get props => [
        id,
        pet,
        userId,
        name,
        contact,
        address,
        status,
        createdAt,
        updatedAt,
      ];
}