// // lib/features/help_support/presentation/view/about_us_view.dart

// import 'package:flutter/material.dart';
// import 'package:icons_plus/icons_plus.dart';

// class AboutUsView extends StatelessWidget {
//   const AboutUsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('About Us'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildMissionSection(),
//                   const SizedBox(height: 24),
//                   _buildValuesSection(),
//                   const SizedBox(height: 24),
//                   _buildTeamSection(),
//                   const SizedBox(height: 24),
//                   _buildSocialSection(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       height: 200,
//       width: double.infinity,
//       color: Colors.black,
//       child: const Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             BoxIcons.bxs_dog,
//             size: 64,
//             color: Colors.white,
//           ),
//           SizedBox(height: 16),
//           Text(
//             'Pet Care',
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           Text(
//             'Connecting Pets with Loving Homes',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.white70,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMissionSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Our Mission',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(
//           'At Pet Care, we\'re dedicated to creating meaningful connections between pets and their future families. Our platform serves as a bridge, ensuring every pet finds a loving home while providing support and resources to pet owners.',
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey[600],
//             height: 1.5,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildValuesSection() {
//     final values = [
//       {
//         'icon': BoxIcons.bx_heart,
//         'title': 'Care',
//         'description': 'Ensuring the well-being of every pet',
//       },
//       {
//         'icon': BoxIcons.bx_check_shield,
//         'title': 'Trust',
//         'description': 'Building reliable connections',
//       },
//       {
//         'icon': BoxIcons.bx_network_chart,
//         'title': 'Community',
//         'description': 'Creating a supportive pet-loving network',
//       },
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Our Values',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         ...values.map((value) => Card(
//               elevation: 0,
//               color: Colors.grey[100],
//               margin: const EdgeInsets.only(bottom: 12),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     Icon(value['icon'] as IconData, size: 32),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             value['title'],
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             value['description'],
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )),
//       ],
//     );
//   }

//   Widget _buildTeamSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Our Team',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(
//           'We\'re a team of dedicated animal lovers, veterinarians, and tech experts working together to make pet adoption and care accessible to everyone.',
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey[600],
//             height: 1.5,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSocialSection() {
//     final socials = [
//       {'icon': BoxIcons.bxl_facebook, 'name': 'Facebook'},
//       {'icon': BoxIcons.bxl_instagram, 'name': 'Instagram'},
//       {'icon': BoxIcons.bxl_twitter, 'name': 'Twitter'},
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Connect With Us',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: socials
//               .map(
//                 (social) => Column(
//                   children: [
//                     IconButton(
//                       icon: Icon(social['icon'] as IconData),
//                       onPressed: () {
//                         // Handle social media link
//                       },
//                       iconSize: 32,
//                     ),
//                     Text(social['name']!),
//                   ],
//                 ),
//               )
//               .toList(),
//         ),
//       ],
//     );
//   }
// }
