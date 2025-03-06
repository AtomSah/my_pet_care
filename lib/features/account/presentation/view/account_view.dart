import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care/core/common/snackbar/my_snackbar.dart';
import 'package:pet_care/features/account/domain/entity/user_profile_entity.dart';
import 'package:pet_care/features/account/presentation/view/help_support_view.dart';
import 'package:pet_care/features/account/presentation/view_model/account_bloc.dart';
import 'package:pet_care/features/account/presentation/view_model/account_event.dart';
import 'package:pet_care/features/auth/presentation/view/login_view.dart';
import 'package:pet_care/features/booked_pets/presentation/view/bookings_list_view.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    context.read<AccountBloc>().add(GetUserProfileEvent());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      context.read<AccountBloc>().add(
            UploadProfilePictureEvent(filePath: image.path),
          );
    }
  }

  void _showEditDialog(UserProfileEntity profile) {
    _nameController.text = profile.name;
    _phoneController.text = profile.phone;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<AccountBloc>().add(
                      UpdateUserProfileEvent(
                        name: _nameController.text,
                        phone: _phoneController.text,
                      ),
                    );
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountError) {
          showMySnackBar(
            context: context,
            message: state.message,
            color: Colors.red,
          );
        }
        if (state is AccountUpdated) {
          showMySnackBar(
            context: context,
            message: 'Profile updated successfully',
            color: Colors.green,
          );
        }
        if (state is ProfilePictureUploaded) {
          showMySnackBar(
            context: context,
            message: 'Profile picture updated successfully',
            color: Colors.green,
          );
        }
        if (state is LogoutSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginView()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is AccountLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AccountLoaded || state is AccountUpdated) {
          final profile = (state is AccountLoaded)
              ? state.profile
              : (state as AccountUpdated).profile;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: profile.avatar != null
                          ? NetworkImage(
                              'http://10.0.2.2:5000/api${profile.avatar}')
                          : null,
                      child: profile.avatar == null
                          ? const Icon(Icons.person,
                              size: 50, color: Colors.black)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        radius: 18,
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  profile.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                Text(
                  profile.email,
                  style: TextStyle(
                    color: Colors.blueGrey[600],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 32),
                _buildProfileCard(profile),
                const SizedBox(height: 16),
                _buildActionButtons(context),
              ],
            ),
          );
        }

        return const Center(child: Text('Something went wrong'));
      },
    );
  }

  Widget _buildProfileCard(UserProfileEntity profile) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileItem(
              Icons.phone,
              'Phone',
              profile.phone,
            ),
            const Divider(),
            _buildProfileItem(
              Icons.badge,
              'Role',
              profile.role.toUpperCase(),
            ),
            const Divider(),
            _buildProfileItem(
              Icons.calendar_today,
              'Joined',
              profile.createdAt != null
                  ? '${profile.createdAt!.day}/${profile.createdAt!.month}/${profile.createdAt!.year}'
                  : 'N/A',
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showEditDialog(profile),
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey[600]),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.blueGrey[600],
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        bool isAdmin = false;
        if (state is AccountLoaded) {
          isAdmin = state.profile.role == 'admin';
        } else if (state is AccountUpdated) {
          isAdmin = state.profile.role == 'admin';
        }

        return Column(
          children: [
            ListTile(
              leading: const Icon(BoxIcons.bx_heart, color: Colors.blueAccent),
              title: const Text('My Favorites'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to favorites
              },
            ),
            ListTile(
              leading:
                  const Icon(BoxIcons.bx_history, color: Colors.blueAccent),
              title: const Text('Booking History'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BookingsListView()),
                );
              },
            ),
            if (isAdmin) ...[
              ListTile(
                leading: const Icon(BoxIcons.bx_cog, color: Colors.blueAccent),
                title: const Text('Admin Dashboard'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to admin dashboard
                },
              ),
            ],
            ListTile(
              leading:
                  const Icon(BoxIcons.bx_help_circle, color: Colors.blueAccent),
              title: const Text('Help & Support'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HelpSupportView()),
                );
              },
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<AccountBloc>().add(LogoutEvent());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        );
      },
    );
  }
}
