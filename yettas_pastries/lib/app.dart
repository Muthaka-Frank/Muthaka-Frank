import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/app_shell.dart';
import 'pages/auth/signin_page.dart';
import 'state/auth_controller.dart';
import 'theme/app_theme.dart';

class YettasPastriesApp extends StatelessWidget {
  const YettasPastriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YETTAS PASTRIES',
      theme: buildAppTheme(),
      home: Consumer<AuthController>(
        builder: (context, authController, _) {
          if (!authController.isInitialized) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return authController.isAuthenticated
              ? const AppShell()
              : const SignInPage();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
