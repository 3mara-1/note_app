import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_cubit.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_state.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorStyle = Theme.of(context).colorScheme;

    return Drawer(
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorStyle.primaryContainer,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(22),
                    ),
                    image: state.user.profilPic != null
                        ? DecorationImage(
                            image: FileImage(File(state.user.profilPic!)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Stack(
                    alignment: AlignmentGeometry.bottomLeft,
                    children: [
                      Container(
                        width: 110,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0x88ffffff),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Align(
                          alignment: AlignmentGeometry.center,
                          child: Text(
                            state.user.name,
                            style: textStyle.bodyLarge?.copyWith(
                              color: const Color(0xFF000000),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit, size: 28),
                        title: Text(
                          'Edit Profile',
                          style: textStyle.bodyMedium,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          _showEditProfileDialog(context, state.user);
                        },
                      ),
                      const Divider(indent: 16, endIndent: 16),

                      ListTile(
                        leading: const Icon(Icons.settings, size: 28),
                        title: Text('Settings', style: textStyle.bodyMedium),
                        onTap: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Settings coming soon!'),
                            ),
                          );
                        },
                      ),
                      const Divider(indent: 16, endIndent: 16),

                      // About
                      ListTile(
                        leading: const Icon(Icons.info_outline, size: 28),
                        title: Text('About', style: textStyle.bodyMedium),
                        onTap: () {
                          Navigator.pop(context);
                          _showAboutDialog(context);
                        },
                      ),
                      const Divider(indent: 16, endIndent: 16),

                      // Logout
                      ListTile(
                        leading: const Icon(
                          Icons.logout,
                          size: 28,
                          color: Colors.red,
                        ),
                        title: Text(
                          'Logout',
                          style: textStyle.bodyMedium?.copyWith(
                            color: Colors.red,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          _showLogoutDialog(context);
                        },
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Note App v1.0.0',
                    style: textStyle.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, user) {
    final nameController = TextEditingController(text: user.name);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Profile'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              nameController.dispose();
              Navigator.pop(dialogContext);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                context.read<UserCubit>().updateUser(name: nameController.text);
                nameController.dispose();
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile updated!')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // Dialog for About
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Note App'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Note App v1.0.0'),
            SizedBox(height: 8),
            Text('A simple and beautiful note-taking app.'),
            SizedBox(height: 16),
            Text('Features:'),
            Text('• Create and edit notes'),
            Text('• Color-coded notes'),
            Text('• User profiles'),
            Text('• Local storage with Hive'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Dialog for Logout Confirmation
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<UserCubit>().logoutUser();
              Navigator.pop(dialogContext);
              context.go('/register');
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
