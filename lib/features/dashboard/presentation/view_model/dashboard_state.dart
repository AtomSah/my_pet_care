import 'package:equatable/equatable.dart';
import 'package:pet_care/features/dashboard/domain/entity/pet_entity.dart';


abstract class DashboardState extends Equatable {
  const DashboardState();
  
  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<PetEntity> pets;

  const DashboardLoaded({required this.pets});

  @override
  List<Object> get props => [pets];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError({required this.message});

  @override
  List<Object> get props => [message];
}