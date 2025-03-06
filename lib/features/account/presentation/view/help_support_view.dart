// lib/features/help_support/presentation/view/help_support_view.dart

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HelpSupportView extends StatelessWidget {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFAQSection(),
              const SizedBox(height: 24),
              _buildContactSection(),
              const SizedBox(height: 24),
              _buildPoliciesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Frequently Asked Questions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildFAQItem(
          'How do I book a pet?',
          'To book a pet, simply browse through our available pets, select the one you\'re interested in, and click on the "Book Now" button. Fill in the required details and submit your booking request.',
        ),
        _buildFAQItem(
          'What happens after I make a booking?',
          'After submitting your booking request, our team will review it and contact you within 24 hours to confirm the details and arrange the next steps.',
        ),
        _buildFAQItem(
          'Are all pets vaccinated?',
          'Yes, all pets listed on our platform are vaccinated and health-checked. You can see the vaccination status badge on each pet\'s profile.',
        ),
      ],
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            answer,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Us',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          BoxIcons.bx_phone,
          'Phone Support',
          '+977 98XXXXXXXX',
          'Available 9:00 AM - 6:00 PM',
        ),
        _buildContactItem(
          BoxIcons.bx_envelope,
          'Email Support',
          'support@petcare.com',
          'Response within 24 hours',
        ),
        _buildContactItem(
          BoxIcons.bx_message_rounded_dots,
          'Live Chat',
          'Chat with us',
          'Available on weekdays',
        ),
      ],
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String title,
    String content,
    String subtitle,
  ) {
    return Card(
      elevation: 0,
      color: Colors.grey[100],
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.black),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
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

  Widget _buildPoliciesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Policies & Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListTile(
          leading: const Icon(BoxIcons.bx_shield),
          title: const Text('Privacy Policy'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Navigate to Privacy Policy
          },
        ),
        ListTile(
          leading: const Icon(BoxIcons.bx_file),
          title: const Text('Terms of Service'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Navigate to Terms of Service
          },
        ),
        ListTile(
          leading: const Icon(BoxIcons.bx_book),
          title: const Text('Pet Care Guidelines'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Navigate to Guidelines
          },
        ),
      ],
    );
  }
}