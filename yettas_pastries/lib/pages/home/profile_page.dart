import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/auth_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? email = context.watch<AuthController>().currentUserEmail;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 8),
        Text('Account', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(email ?? 'Guest'),
          subtitle: const Text('Signed in'),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () => context.read<AuthController>().signOut(),
          icon: const Icon(Icons.logout),
          label: const Text('Sign out'),
        ),
      ],
    );
  }
}
