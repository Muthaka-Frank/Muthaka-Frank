import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/auth_controller.dart';
import '../widgets/bottom_nav_scaffold.dart';
import 'auth/auth_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = context.watch<AuthController>();
    if (!controller.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (!controller.isAuthenticated) {
      return const AuthPage();
    }
    return const BottomNavScaffold();
  }
}
