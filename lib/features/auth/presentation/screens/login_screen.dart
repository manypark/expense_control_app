import 'package:flutter/material.dart';

import '../widgets/texts/common_text.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool loading;
  final VoidCallback onSubmit;
  final VoidCallback onGoToRegister;
  final String? errorText;

  const LoginScreen({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.loading,
    required this.onSubmit,
    required this.onGoToRegister,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    CommonTexts(
                      title: 'Iniciar sesión',
                    ),

                    const SizedBox(height: 16),

                    CommonInputText(emailController: emailController),

                    const SizedBox(height: 8),

                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: loading ? null : onSubmit,
                        child: const Text('Entrar'),
                      ),
                    ),

                    TextButton(
                      onPressed: loading ? null : onGoToRegister,
                      child: const Text('No tengo cuenta, registrarme'),
                    ),

                    if (errorText != null)
                      Text(
                        errorText!,
                        style: const TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommonInputText extends StatelessWidget {
  const CommonInputText({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(labelText: 'Email'),
    );
  }
}