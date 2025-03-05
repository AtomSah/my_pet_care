
import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class LoadPetsEvent extends DashboardEvent {}

class FilterPetsByTypeEvent extends DashboardEvent {
  final String type;

  const FilterPetsByTypeEvent(this.type);

  @override
  List<Object> get props => [type];
}
