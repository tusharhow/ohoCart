import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oho_cart/src/controllers/auth_controller.dart';
import 'package:oho_cart/src/models/auth/request/login_request.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthController>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16 * 2),
            const CircleAvatar(
              radius: 70,
              child: Text('L'),
            ),
            const SizedBox(height: 16 * 2),
            TextField(
              controller: loginProvider.usernameController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Username or Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: loginProvider.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16 * 2),
            Consumer<AuthController>(builder: (context, loginProvider, child) {
              return loginProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        loginProvider
                            .login(
                          LoginRequest(
                            username: loginProvider.usernameController.text,
                            password: loginProvider.passwordController.text,
                          ),
                        )
                            .then((value) {
                          context.go('/');
                        });
                      },
                      child: const Text('Login'),
                    );
            }),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Password?'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
