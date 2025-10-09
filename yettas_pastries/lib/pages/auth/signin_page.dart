import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/auth_controller.dart';
import '../../theme/app_theme.dart';
import 'signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final auth = context.read<AuthController>();
    try {
      await auth.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } catch (e) {
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YETTAS PASTRIES')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welcome back',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _loading ? null : _submit,
                  child: _loading
                      ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Sign in'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _loading
                      ? null
                      : () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const SignUpPage()),
                          ),
                  child: const Text("Don't have an account? Sign up"),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _loading
                      ? null
                      : () async {
                          // Simulated Gmail sign-in via email entry.
                          final email = _emailController.text.trim().toLowerCase();
                          if (!email.endsWith('@gmail.com')) {
                            setState(() => _error = 'Enter your Gmail address to continue.');
                            return;
                          }
                          setState(() => _loading = true);
                          try {
                            // Try to sign up; if already exists, sign in.
                            await context.read<AuthController>().signUp(
                                  email: email,
                                  password: 'gmail-oauth-simulated',
                                );
                          } catch (_) {
                            try {
                              await context.read<AuthController>().signIn(
                                    email: email,
                                    password: 'gmail-oauth-simulated',
                                  );
                            } catch (e) {
                              setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
                            }
                          } finally {
                            if (mounted) setState(() => _loading = false);
                          }
                        },
                  icon: const Icon(Icons.mail_outline),
                  label: const Text('Continue with Gmail'),
                  style: ElevatedButton.styleFrom(backgroundColor: kDominantColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
