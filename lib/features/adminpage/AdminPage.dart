import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pet_care/app/constants/api_endpoints.dart';
import 'package:pet_care/app/di/di.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage>
    with SingleTickerProviderStateMixin {
  late final Dio _dio;
  bool _isLoading = true;
  String? _errorMessage;

  // Data lists
  List<dynamic> _users = [];
  List<dynamic> _pets = [];
  List<dynamic> _bookings = [];

  // Tab controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _dio = getIt<Dio>();
    _tabController = TabController(length: 3, vsync: this);

    // Static Users Data
    _users = [
      {
        'name': 'John Doe',
        'email': 'john@example.com',
        'phone': '9876543210',
        'role': 'admin',
      },
      {
        'name': 'Sarah Smith',
        'email': 'sarah@example.com',
        'phone': '9876543211',
        'role': 'user',
      },
      {
        'name': 'Mike Johnson',
        'email': 'mike@example.com',
        'phone': '9876543212',
        'role': 'user',
      },
      {
        'name': 'Emily Brown',
        'email': 'emily@example.com',
        'phone': '9876543213',
        'role': 'user',
      },
      {
        'name': 'David Wilson',
        'email': 'david@example.com',
        'phone': '9876543214',
        'role': 'admin',
      },
      {
        'name': 'Lisa Anderson',
        'email': 'lisa@example.com',
        'phone': '9876543215',
        'role': 'user',
      },
      {
        'name': 'Tom Harris',
        'email': 'tom@example.com',
        'phone': '9876543216',
        'role': 'user',
      },
      {
        'name': 'Emma Davis',
        'email': 'emma@example.com',
        'phone': '9876543217',
        'role': 'user',
      },
      {
        'name': 'James Miller',
        'email': 'james@example.com',
        'phone': '9876543218',
        'role': 'user',
      },
      {
        'name': 'Sophie Taylor',
        'email': 'sophie@example.com',
        'phone': '9876543219',
        'role': 'user',
      },
    ];

    // Static Bookings Data
    _bookings = [
      {
        'pet': {
          'name': 'Max',
          'image': '/uploads/pets/41cea351beca8e603111007e.jpeg',
        },
        'name': 'John Doe',
        'contact': '9876543210',
        'address': 'Kathmandu, Nepal',
        'status': 'confirmed',
      },
      {
        'pet': {
          'name': 'Luna',
          'image': '/uploads/pets/41cea351beca8e603111007e.jpeg',
        },
        'name': 'Sarah Smith',
        'contact': '9876543211',
        'address': 'Pokhara, Nepal',
        'status': 'pending',
      },
      {
        'pet': {
          'name': 'Buddy',
          'image': '/uploads/pets/41cea351beca8e603111007e.jpeg',
        },
        'name': 'Mike Johnson',
        'contact': '9876543212',
        'address': 'Lalitpur, Nepal',
        'status': 'cancelled',
      },
      {
        'pet': {
          'name': 'Bella',
          'image': '/uploads/pets/41cea351beca8e603111007e.jpeg',
        },
        'name': 'Emily Brown',
        'contact': '9876543213',
        'address': 'Bhaktapur, Nepal',
        'status': 'confirmed',
      },
      {
        'pet': {
          'name': 'Charlie',
          'image': '/uploads/pets/41cea351beca8e603111007e.jpeg',
        },
        'name': 'David Wilson',
        'contact': '9876543214',
        'address': 'Butwal, Nepal',
        'status': 'pending',
      },
      {
        'pet': {
          'name': 'Lucy',
          'image': '/uploads/pets/41cea351beca8e603111007e.jpeg',
        },
        'name': 'Lisa Anderson',
        'contact': '9876543215',
        'address': 'Biratnagar, Nepal',
        'status': 'confirmed',
      },
      {
        'pet': {
          'name': 'Rocky',
          'image': '/uploads/pets/41cea351beca8e603111007e.jpeg',
        },
        'name': 'Tom Harris',
        'contact': '9876543216',
        'address': 'Dharan, Nepal',
        'status': 'pending',
      },
      {
        'pet': {
          'name': 'Milo',
          'image': '/uploads/pets/41cea351beca8e603111007e.jpeg',
        },
        'name': 'Emma Davis',
        'contact': '9876543217',
        'address': 'Chitwan, Nepal',
        'status': 'cancelled',
      },
      {
        'pet': {
          'name': 'Bailey',
          'image': '/uploads/pets/41cea351beca8e603111007e.jpeg',
        },
        'name': 'James Miller',
        'contact': '9876543218',
        'address': 'Hetauda, Nepal',
        'status': 'confirmed',
      },
      {
        'pet': {
          'name': 'Leo',
          'image': '/uploads/pets/41cea351beca8e603111007e.jpeg',
        },
        'name': 'Sophie Taylor',
        'contact': '9876543219',
        'address': 'Birgunj, Nepal',
        'status': 'pending',
      },
    ];

    // Only load pets from API
    _loadPets();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadAllData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await Future.wait([
        _loadUsers(),
        _loadPets(),
        _loadBookings(),
      ]);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Error loading data: $e";
      });
    }
  }

  Future<void> _loadUsers() async {
    try {
      final response =
          await _dio.get('${ApiEndpoints.baseUrl}user/get-all-users');
      if (response.statusCode == 200) {
        setState(() {
          _users = response.data['users'];
        });
      }
    } catch (e) {
      print("Error loading users: $e");
    }
  }

  Future<void> _loadPets() async {
    try {
      final response = await _dio.get('${ApiEndpoints.baseUrl}pets');
      if (response.statusCode == 200) {
        setState(() {
          _pets = response.data;
        });
      }
    } catch (e) {
      print("Error loading pets: $e");
    }
  }

  Future<void> _loadBookings() async {
    try {
      final response = await _dio.get('${ApiEndpoints.baseUrl}bookings');
      if (response.statusCode == 200) {
        setState(() {
          _bookings = response.data;
        });
      }
    } catch (e) {
      print("Error loading bookings: $e");
    }
  }

  Widget _buildUserList() {
    return Container(
      color: Colors.grey[100],
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Text(
                  user['name']?[0].toUpperCase() ?? '?',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                user['name'] ?? 'Unknown',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(user['email'] ?? 'No email'),
                  Text(user['phone'] ?? 'No phone'),
                  Text('Role: ${user['role']?.toUpperCase() ?? 'USER'}'),
                ],
              ),
              trailing: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: user['role'] == 'admin'
                      ? Colors.purple[50]
                      : Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  user['role'] ?? 'user',
                  style: TextStyle(
                    color:
                        user['role'] == 'admin' ? Colors.purple : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPetList() {
    return Container(
      color: Colors.grey[100],
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _pets.length,
        itemBuilder: (context, index) {
          final pet = _pets[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    'http://10.0.2.2:5000${pet['image']}',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 150,
                      color: Colors.grey[300],
                      child:
                          const Icon(Icons.pets, size: 50, color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pet['name'] ?? 'Unknown Pet',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: pet['available']
                                  ? Colors.green[50]
                                  : Colors.red[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              pet['available'] ? 'Available' : 'Booked',
                              style: TextStyle(
                                color: pet['available']
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('${pet['breed']} • ${pet['age']} years'),
                      Text('Type: ${pet['type']}'),
                      Text('Price: Rs.${pet['price']}'),
                      if (pet['vaccinated']) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.check_circle,
                                color: Colors.green[700], size: 16),
                            const SizedBox(width: 4),
                            Text(
                              'Vaccinated',
                              style: TextStyle(color: Colors.green[700]),
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
        },
      ),
    );
  }

  Widget _buildBookingList() {
    return Container(
      color: Colors.grey[100],
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _bookings.length,
        itemBuilder: (context, index) {
          final booking = _bookings[index];
          Color statusColor;
          IconData statusIcon;

          switch (booking['status']?.toLowerCase()) {
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
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'http://10.0.2.2:5000${booking['pet']['image']}',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[200],
                        child: const Icon(Icons.pets, color: Colors.grey),
                      ),
                    ),
                  ),
                  title: Text(
                    booking['pet']['name'] ?? 'Unknown Pet',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Booked by: ${booking['name']}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(statusIcon, size: 16, color: statusColor),
                        const SizedBox(width: 4),
                        Text(
                          booking['status']?.toUpperCase() ?? 'UNKNOWN',
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow(
                                Icons.phone_outlined, booking['contact']),
                            const SizedBox(height: 4),
                            _buildDetailRow(
                                Icons.location_on_outlined, booking['address']),
                          ],
                        ),
                      ),
                      if (booking['status']?.toLowerCase() == 'pending')
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // Handle confirm
                              },
                              icon: const Icon(Icons.check_circle_outline),
                              color: Colors.green,
                            ),
                            IconButton(
                              onPressed: () {
                                // Handle cancel
                              },
                              icon: const Icon(Icons.cancel_outlined),
                              color: Colors.red,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Users'),
            Tab(text: 'Pets'),
            Tab(text: 'Bookings'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAllData,
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _loadAllData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _buildUserList(),
                    _buildPetList(),
                    _buildBookingList(),
                  ],
                ),
    );
  }
}
