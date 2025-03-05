import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/features/dashboard/domain/repository/pet_repository.dart';
import 'package:pet_care/features/dashboard/presentation/view_model/dashboard_event.dart';
import 'package:pet_care/features/dashboard/presentation/view_model/dashboard_state.dart';


class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final IPetRepository _petRepository;

  DashboardBloc({
    required IPetRepository petRepository,
  })  : _petRepository = petRepository,
        super(DashboardInitial()) {
    on<LoadPetsEvent>(_onLoadPets);
    on<FilterPetsByTypeEvent>(_onFilterPetsByType);
  }

  Future<void> _onLoadPets(
    LoadPetsEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    final result = await _petRepository.getAllPets();
    result.fold(
      (failure) => emit(DashboardError(message: failure.message)),
      (pets) => emit(DashboardLoaded(pets: pets)),
    );
  }

  Future<void> _onFilterPetsByType(
    FilterPetsByTypeEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    final result = await _petRepository.getPetsByType(event.type);
    result.fold(
      (failure) => emit(DashboardError(message: failure.message)),
      (pets) => emit(DashboardLoaded(pets: pets)),
    );
  }
}
