import 'package:flutter/material.dart';
import 'package:pet_care/features/dashboard/domain/entity/pet_entity.dart';
import 'package:pet_care/features/booking/presentation/view/BookingConfirmationDialog.dart';

class PetDetailsView extends StatelessWidget {
  final PetEntity pet;

  const PetDetailsView({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pet Details"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPetImage(),
            const SizedBox(height: 16),
            _buildPetInfo(),
            const SizedBox(height: 20),
            _buildActionButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPetImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        pet.image.isNotEmpty
            ? 'http://10.0.2.2:5000${pet.image}'
            : 'https://via.placeholder.com/150',
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 250,
          color: Colors.grey[300],
          child: const Center(
            child: Icon(Icons.pets, size: 50, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildPetInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pet.name,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Text(
          "Rs ${pet.price}",
          style: TextStyle(fontSize: 20, color: Colors.blue[700]),
        ),
        const SizedBox(height: 12),
        _buildInfoRow("Type", pet.type),
        _buildInfoRow("Breed", pet.breed),
        _buildInfoRow("Age", "${pet.age} years"),
        _buildInfoRow("Gender", pet.gender),
        _buildInfoRow("Color", pet.color),
        _buildInfoRow("Weight", "${pet.weight} kg"),
        _buildInfoRow("Location", pet.location),
        const SizedBox(height: 12),
        _buildVaccinationStatus(),
        const SizedBox(height: 12),
        _buildDescription(),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Widget _buildVaccinationStatus() {
    return Row(
      children: [
        Icon(
          pet.vaccinated ? Icons.check_circle : Icons.cancel,
          color: pet.vaccinated ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(
          pet.vaccinated ? "Vaccinated" : "Not Vaccinated",
          style: TextStyle(
              fontSize: 16, color: pet.vaccinated ? Colors.green : Colors.red),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          pet.description,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => BookingConfirmationDialog(
              onConfirm: (name, phone, location) {
                // Handle booking logic here (e.g., save to database or update state)
                print("Booking Confirmed: $name, $phone, $location");
              },
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text(
          "Book Now",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
