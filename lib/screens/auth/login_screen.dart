import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fruitvision/constants/app_colors.dart';
import 'package:fruitvision/providers/auth.dart';
import 'package:fruitvision/utils/context_extensions.dart';
import 'package:fruitvision/widgets/auth/signin_form.dart';
import 'package:fruitvision/widgets/common/custom_button.dart';
import 'package:fruitvision/widgets/common/loding_indicator.dart';
import 'package:fruitvision/widgets/common/soical_logo.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      context.showLoadingSnackBar('Signing in...');

      // نستقبل نتيجة تسجيل الدخول
      final error = await context.read<AuthProvider>().signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

      if (!mounted) return;

      // التحقق من وجود خطأ
      if (error != null) {
        context.showErrorSnackBar(error);
        return;
      }

      // نجاح تسجيل الدخول
      context.showSuccessSnackBar('Welcome back!');
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;
      context.go('/home');
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
                    Column(
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
                        Text(
                          "Sign in",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SignInForm(
                      formKey: _formKey,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      isPasswordVisible: _isPasswordVisible,
                      onTogglePassword: () => setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      }),
                    ),
                    const SizedBox(height: 20),
                    const SocialLoginButtons(),
                    const SizedBox(height: 20),
                    CustomButton(
                      onPressed: authProvider.isLoading ? null : _handleSignIn,
                      text: 'SIGN IN',
                      backgroundColor: AppColors.accent,
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () => context.push('/signup'),
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            const TextSpan(text: "Don't have an account? "),
                            TextSpan(
                              text: 'Sign up',
                              style: TextStyle(
                                color: AppColors.accent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
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
