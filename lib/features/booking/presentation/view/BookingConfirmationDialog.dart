import 'package:flutter/material.dart';

class BookingConfirmationDialog extends StatefulWidget {
  final Function(String name, String phone, String location) onConfirm;

  const BookingConfirmationDialog({Key? key, required this.onConfirm}) : super(key: key);

  @override
  _BookingConfirmationDialogState createState() => _BookingConfirmationDialogState();
}

class _BookingConfirmationDialogState extends State<BookingConfirmationDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Booking"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(labelText: "Phone Number"),
            keyboardType: TextInputType.phone,
          ),
          TextField(
            controller: locationController,
            decoration: const InputDecoration(labelText: "Location"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final name = nameController.text;
            final phone = phoneController.text;
            final location = locationController.text;

            widget.onConfirm(name, phone, location); // Pass the user's info back

            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Confirm Booking"),
        ),
      ],
    );
  }
}
