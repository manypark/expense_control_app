import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/auth/presentation/presentation.dart';
import 'package:expense_control_app/shared/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  bool _isLogin = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);

    return auth.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(body: Center(child: Text('Error: $error'))),
      data: (session) {
        if (session != null) {
          return const AppShell();
        }

        final authState = ref.watch(authControllerProvider);
        final loading = authState.isLoading;
        final errorText = authState.hasError
            ? 'Error: ${authState.error}'
            : null;

        if (_isLogin) {
          return LoginScreen(
            emailController: _emailController,
            passwordController: _passwordController,
            loading: loading,
            errorText: errorText,
            onSubmit: _submit,
            onGoToRegister: () => setState(() => _isLogin = false),
          );
        }

        return RegisterScreen(
          emailController: _emailController,
          passwordController: _passwordController,
          loading: loading,
          errorText: errorText,
          onSubmit: _submit,
          onGoToLogin: () => setState(() => _isLogin = true),
        );
      },
    );
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (_isLogin) {
      await ref.read(authControllerProvider.notifier).login(email, password);
    } else {
      await ref.read(authControllerProvider.notifier).register(email, password);
    }
  }
}
