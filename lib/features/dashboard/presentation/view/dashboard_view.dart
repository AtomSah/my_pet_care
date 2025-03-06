import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pet_care/features/dashboard/domain/entity/pet_entity.dart';
import 'package:pet_care/features/dashboard/presentation/view_model/dashboard_bloc.dart';
import 'package:pet_care/features/dashboard/presentation/view_model/dashboard_event.dart';
import 'package:pet_care/features/dashboard/presentation/view_model/dashboard_state.dart';
import 'package:pet_care/features/petDetails/presentation/view/petdetails.dart';
import 'package:sensors_plus/sensors_plus.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String selectedCategory = 'All';
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  double _previousAcceleration = 0.0;
  final double _threshold = 12.0;
  DateTime? _lastShake;

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(LoadPetsEvent());

    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      double currentAcceleration =
          (event.x.abs() + event.y.abs() + event.z.abs());
      DateTime now = DateTime.now();

      if (_lastShake == null ||
          now.difference(_lastShake!) > const Duration(seconds: 1)) {
        if (currentAcceleration - _previousAcceleration > _threshold) {
          _lastShake = now;
          context.read<DashboardBloc>().add(LoadPetsEvent());

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(Icons.refresh, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Refreshing pets list...'),
                ],
              ),
              backgroundColor: Colors.blueAccent,
              duration: Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          );
        }
      }
      _previousAcceleration = currentAcceleration;
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    super.dispose();
  }

  void _filterPets(String category) {
    setState(() {
      selectedCategory = category;
    });
    if (category == 'All') {
      context.read<DashboardBloc>().add(LoadPetsEvent());
    } else {
      context.read<DashboardBloc>().add(FilterPetsByTypeEvent(category));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildSearchBar(),
                const SizedBox(height: 20),
                _buildCategorySection(),
                const SizedBox(height: 20),
                _buildPetList(state, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find Your',
              style: TextStyle(
                fontSize: 24,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Text(
                  'Perfect Pet ',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '🐾',
                  style: TextStyle(fontSize: 32),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(BoxIcons.bx_search, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search pets...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              BoxIcons.bx_filter,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    final categories = [
      {'icon': '🏠', 'name': 'All'},
      {'icon': '🐕', 'name': 'Dog'},
      {'icon': '🐈', 'name': 'Cat'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategory == category['name'];

              return GestureDetector(
                onTap: () => _filterPets(category['name']!),
                child: Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? Colors.blueAccent : Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          category['icon']!,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category['name']!,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color:
                              isSelected ? Colors.blueAccent : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPetList(DashboardState state, BuildContext context) {
    if (state is DashboardLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state is DashboardError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red[400]),
            const SizedBox(height: 16),
            Text(
              state.message,
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (state is DashboardLoaded) {
      if (state.pets.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.pets, size: 48, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No pets found in this category',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available Pets (${state.pets.length})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              // Shake to refresh hint
              Row(
                children: [
                  const Icon(Icons.phone_android, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Shake to refresh',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: state.pets.length,
            itemBuilder: (context, index) {
              final pet = state.pets[index];
              return _buildPetCard(pet);
            },
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildPetCard(PetEntity pet) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PetDetailsView(pet: pet)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(
                      pet.image.isNotEmpty
                          ? 'http://10.0.2.2:5000${pet.image}'
                          : 'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.pets,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  if (pet.vaccinated)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Vaccinated',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${pet.type} - ${pet.breed}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
