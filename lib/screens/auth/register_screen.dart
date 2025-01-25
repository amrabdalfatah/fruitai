

import 'package:flutter/material.dart';
import 'package:fruitvision/constants/app_colors.dart';
import 'package:fruitvision/providers/auth.dart';
import 'package:fruitvision/utils/context_extensions.dart';
import 'package:fruitvision/widgets/auth/signup_form.dart';
import 'package:fruitvision/widgets/common/custom_button.dart';
import 'package:fruitvision/widgets/common/loding_indicator.dart';
import 'package:fruitvision/widgets/common/soical_logo.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      context.showErrorSnackBar('Passwords do not match');
      return;
    }

    try {
      context.showLoadingSnackBar('Creating account...');

      await context.read<AuthProvider>().signUp(
            _emailController.text.trim(),
            _passwordController.text,
            _nameController.text.trim(),
          );

      if (!mounted) return;

      context.showSuccessSnackBar(
        'Account created successfully!',
      );

      // await Future.delayed(const Duration(seconds: 1));
      // if (!mounted) return;
      // context.go('/verification');
      context.go('/signin');
    } catch (e) {
      if (!mounted) return;
      context.showErrorSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return LoadingIndicator(
            isLoading: authProvider.isLoading,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Transform.scale(
                        scale: 3.0,
                        child: Transform.translate(
                          offset: const Offset(0, -50),
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 150,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'CREATE YOUR ACCOUNT',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    SignUpForm(
                      formKey: _formKey,
                      nameController: _nameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      isPasswordVisible: _isPasswordVisible,
                      isConfirmPasswordVisible: _isConfirmPasswordVisible,
                      onTogglePassword: () => setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      }),
                      onToggleConfirmPassword: () => setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      }),
                    ),
                    const SizedBox(height: 20),
                    const SocialLoginButtons(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () => context.go('/signin'),
                          child: const Text('Login',
                              style: TextStyle(color: AppColors.accent)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      onPressed: authProvider.isLoading ? null : _handleSignUp,
                      text: 'CREATE ACCOUNT',
                      backgroundColor: AppColors.accent,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
