import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/user.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final user = authProvider.currentUser;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await authProvider.signOut();
                },
              ),
            ],
          ),
          body: user == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Text(
                          user.displayName?.substring(0, 1).toUpperCase() ?? 'U',
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.displayName ?? 'User',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        user.email ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 32),
                      const Text('Scan Credits: Coming Soon'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Navigate to settings
                        },
                        child: const Text('Settings'),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
