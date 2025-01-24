import 'package:flutter/material.dart';
import 'package:fruitvision/constants/app_colors.dart';
import 'package:fruitvision/screens/welcome/body.dart';
import 'package:fruitvision/widgets/common/custom_button.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  final Animation<double> animation;
  final WelcomeSlide slide;

  const WelcomePage({super.key, 
    required this.animation,
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Transform.translate(
              offset: Offset(0, (1 - animation.value) * -100),
              child: child,
            ),
            child: Image.asset(
              slide.image,
              height: 120,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 40),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Transform.translate(
              offset: Offset(0, (1 - animation.value) * 100),
              child: child,
            ),
            child: Column(
              children: [
                Text(
                  slide.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  onPressed: () => context.push('/signin'),
                  text: 'SIGN IN',
                  backgroundColor: AppColors.primaryDark,
                ),

                const SizedBox(height: 16),
                CustomButton(
                  onPressed: () => context.push('/signup'),
                  text: 'CREATE ACCOUNT',
                  backgroundColor: AppColors.primaryDark,
                ),

                const SizedBox(height: 40),
                const Text(
                  'or Sign Up with',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialButton(
                      onPressed: () {
                        // Handle Apple sign in
                      },
                      icon: const Icon(
                        Icons.apple,
                        color: Color(0xFF2E7D32),
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 32),
                    _SocialButton(
                      onPressed: () {
                        // Handle Google sign in
                      },
                      icon: Image.asset(
                        'assets/images/2.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;

  const _SocialButton({
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      padding: EdgeInsets.zero,
      iconSize: 30,
    );
  }
}
