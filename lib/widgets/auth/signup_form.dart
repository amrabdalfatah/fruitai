// lib/screens/auth/widgets/signup_form.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fruitvision/widgets/common/custom_text_field.dart';

class SignUpForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;

  const SignUpForm({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: nameController,
            label: 'Name',
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Name is required';
              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: emailController,
            label: 'Email/Phone number',
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Email is required';
              if (!value!.contains('@')) return 'Invalid email';
              return null;
            },
          ),
          const SizedBox(height: 15),
          PasswordField(
            controller: passwordController,
            label: 'Create Password',
            isVisible: isPasswordVisible,
            onToggleVisibility: onTogglePassword, validator: (value) {
              return null;
              },
          ),
          const SizedBox(height: 15),
          PasswordField(
        
            controller: confirmPasswordController,
            label: 'Confirm Password',
            isVisible: isConfirmPasswordVisible,
            onToggleVisibility: onToggleConfirmPassword, validator: (value) {
              return null;
              },
          ),
        ],
      ),
    );
  }
}


