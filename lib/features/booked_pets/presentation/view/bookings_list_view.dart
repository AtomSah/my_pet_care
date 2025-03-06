import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pet_care/core/common/snackbar/my_snackbar.dart';
import 'package:pet_care/features/booked_pets/domain/entity/booking_entity.dart';
import 'package:pet_care/features/booked_pets/presentation/view_model/booking_bloc.dart';
import 'package:pet_care/features/booked_pets/presentation/view_model/booking_event.dart';
import 'package:pet_care/features/booked_pets/presentation/view_model/booking_state.dart';

class BookingsListView extends StatefulWidget {
  const BookingsListView({super.key});

  @override
  State<BookingsListView> createState() => _BookingsListViewState();
}

class _BookingsListViewState extends State<BookingsListView> {
  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(GetUserBookingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingError) {
            showMySnackBar(
              context: context,
              message: state.message,
              color: Colors.red,
            );
          }
          if (state is BookingStatusUpdated) {
            showMySnackBar(
              context: context,
              message: 'Booking status updated successfully!',
              color: Colors.green,
            );
            // Refresh the bookings list
            context.read<BookingBloc>().add(GetUserBookingsEvent());
          }
        },
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserBookingsLoaded) {
            if (state.bookings.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      BoxIcons.bx_calendar_x,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No bookings found',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your booking history will appear here',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.bookings.length,
              itemBuilder: (context, index) {
                return _buildBookingCard(state.bookings[index]);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildBookingCard(BookingEntity booking) {
    Color statusColor;
    IconData statusIcon;

    switch (booking.status.toLowerCase()) {
      case 'pending':
        statusColor = Colors.orange;
        statusIcon = BoxIcons.bx_time_five;
        break;
      case 'confirmed':
        statusColor = Colors.green;
        statusIcon = BoxIcons.bx_check_circle;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        statusIcon = BoxIcons.bx_x_circle;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = BoxIcons.bx_help_circle;
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Pet Image and Basic Info
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                ),
                child: Image.network(
                  'http://10.0.2.2:5000/api${booking.pet.image}',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey[200],
                    child: const Icon(Icons.pets, size: 40, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            booking.pet.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                statusIcon,
                                size: 16,
                                color: statusColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                booking.status.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${booking.pet.breed} • ${booking.pet.age} years',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rs${booking.pet.price}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          const Divider(),
          // Booking Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildDetailRow(
                  Icons.person_outline,
                  'Name',
                  booking.name,
                ),
                const SizedBox(height: 8),
                _buildDetailRow(
                  Icons.phone_outlined,
                  'Contact',
                  booking.contact,
                ),
                const SizedBox(height: 8),
                _buildDetailRow(
                  Icons.location_on_outlined,
                  'Address',
                  booking.address,
                ),
                if (booking.status.toLowerCase() == 'pending') ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _updateBookingStatus(
                            booking.id!,
                            'cancelled',
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _updateBookingStatus(
                            booking.id!,
                            'confirmed',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Confirm'),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  void _updateBookingStatus(String bookingId, String status) {
    context.read<BookingBloc>().add(
          UpdateBookingStatusEvent(
            bookingId: bookingId,
            status: status,
          ),
        );
  }
}
