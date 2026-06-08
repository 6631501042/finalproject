import 'package:flutter/material.dart';

import '../models/tracking_models.dart';
import '../widgets/inline_note.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.onSignedIn,
    required this.vehicle,
  });

  final UserProfile vehicle;
  final VoidCallback onSignedIn;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    if (!email.endsWith('@lamduan.mfu.ac.th')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please use your Lamduan Mail account')),
      );
      return;
    }

    // TODO:
    // Replace with real authentication later
    widget.onSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const _BrandHeader(),

                      const SizedBox(height: 24),

                      Text(
                        'Vehicle Self-Tracking',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: const Color(0xFF22312F),
                              fontWeight: FontWeight.w900,
                            ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Track your own vehicle around Mae Fah Luang University with CCTV detection and route history.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFF5E706C),
                          height: 1.35,
                        ),
                      ),

                      const SizedBox(height: 24),

                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      FilledButton.icon(
                        key: const ValueKey('login-button'),
                        onPressed: login,
                        icon: const Icon(Icons.login),
                        label: const Text('Login'),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Color(0xFF9AA7A3),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'OR',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: const Color(0xFF5E706C),
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Color(0xFF9AA7A3),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // -------------------------- Continue with Lamduan Mail button --------------------------
                      FilledButton.icon(
                        key: const ValueKey('lamduan-login-button'),
                        onPressed: widget.onSignedIn,
                        icon: const Icon(Icons.account_circle),
                        label: const Text('Continue with Lamduan Mail'),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                      InlineNote(
                        icon: Icons.verified_user_outlined,
                        text:
                            'MFU OAuth access is reserved for Mae Fah Luang University students.',
                        color: colorScheme.tertiary,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const SizedBox(
            width: 46,
            height: 46,
            child: Icon(Icons.two_wheeler, color: Colors.white),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MFU Vehicle Tracker',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF22312F),
                ),
              ),

              const SizedBox(height: 2),

              Text(
                'Mae Fah Luang University',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: const Color(0xFF6B7B77)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
