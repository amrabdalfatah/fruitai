import 'package:flutter/material.dart';
import 'package:fruitvision/widgets/common/custom_text_field.dart';

class SignInForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final VoidCallback onTogglePassword;

  const SignInForm({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.onTogglePassword,
  }) : super(key: key);

  void _printUserInfo() {
    print('User Email: ${emailController.text}');
    print('User Password: ${passwordController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: emailController,
            label: 'Email/Phone number',
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Email is required';
              if (!value!.contains('@')) return 'Invalid email';
              _printUserInfo(); 
              return null;
            },
          ),
          const SizedBox(height: 15),
          PasswordField(
            controller: passwordController,
            label: 'Password',
            isVisible: isPasswordVisible,
            onToggleVisibility: onTogglePassword,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Password is required';
              _printUserInfo(); 
              return null;
            },
          ),
        ],
      ),
    );
  }
}
