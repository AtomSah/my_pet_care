// lib/features/booking_popups/presentation/view/booking_confirmation_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/core/common/snackbar/my_snackbar.dart';
import 'package:pet_care/features/booking/presentation/view_model/booking_confirmation_bloc.dart';
import 'package:pet_care/features/booking/presentation/view_model/booking_confirmation_event.dart';
import 'package:pet_care/features/booking/presentation/view_model/booking_confirmation_state.dart';
import 'package:pet_care/features/booked_pets/presentation/view/bookings_list_view.dart';
import 'package:pet_care/features/dashboard/domain/entity/pet_entity.dart';

class BookingConfirmationDialog extends StatefulWidget {
  final PetEntity pet;

  const BookingConfirmationDialog({
    Key? key,
    required this.pet,
  }) : super(key: key);

  @override
  State<BookingConfirmationDialog> createState() => _BookingConfirmationDialogState();
}

class _BookingConfirmationDialogState extends State<BookingConfirmationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    // Add phone number validation if needed
    return null;
  }

  String? _validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Location is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingConfirmationBloc, BookingConfirmationState>(
      listener: (context, state) {
        if (state is BookingConfirmationSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BookingsListView()),
            (route) => false,
          );
          showMySnackBar(
            context: context,
            message: 'Booking confirmed successfully!',
            color: Colors.green,
          );
        }
        if (state is BookingConfirmationError) {
          showMySnackBar(
            context: context,
            message: state.message,
            color: Colors.red,
          );
        }
      },
      child: AlertDialog(
        title: const Text('Confirm Booking'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: _validateName,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: _validatePhone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: _validateLocation,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          BlocBuilder<BookingConfirmationBloc, BookingConfirmationState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: state is BookingConfirmationLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          context.read<BookingConfirmationBloc>().add(
                                ConfirmBookingEvent(
                                  petId: widget.pet.id!,
                                  name: _nameController.text,
                                  phone: _phoneController.text,
                                  location: _locationController.text,
                                ),
                              );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: state is BookingConfirmationLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Confirm Booking'),
              );
            },
          ),
        ],
      ),
    );
  }
}