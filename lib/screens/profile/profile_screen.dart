import 'package:flutter/material.dart';
import 'package:fruitvision/models/user.dart';
import 'package:fruitvision/services/auth_services.dart';
import 'package:fruitvision/widgets/profile_menu.dart';


class ProfileScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: StreamBuilder<UserModel?>(
          stream: _authService.getUserStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final user = snapshot.data;
            if (user == null) {
              return const Center(child: Text('User not found'));
            }

            return Column(
              children: [
                _buildHeader(user),
                const SizedBox(height: 16),
                _buildMenuItems(context),
                const Spacer(),
                _buildSignOutButton(context),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(UserModel user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.shade800,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const Text(
            'PROFILE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.name.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        ProfileMenuItem(
          icon: Icons.person_outline,
          title: 'Your Profile',
          onTap: () => _navigateToProfile(context),
        ),
        ProfileMenuItem(
          icon: Icons.category_outlined,
          title: 'Categories',
          onTap: () => _navigateToCategories(context),
        ),
        ProfileMenuItem(
          icon: Icons.notifications_outlined,
          title: 'Alerts',
          onTap: () => _navigateToAlerts(context),
        ),
        ProfileMenuItem(
          icon: Icons.language,
          title: 'Language',
          onTap: () => _navigateToLanguage(context),
        ),
        ProfileMenuItem(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          onTap: () => _navigateToPrivacyPolicy(context),
        ),
        ProfileMenuItem(
          icon: Icons.contact_support_outlined,
          title: 'Contact Us',
          onTap: () => _navigateToContactUs(context),
        ),
      ],
    );
  }

  Widget _buildSignOutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton.icon(
        onPressed: () => _handleSignOut(context),
        icon: Icon(Icons.logout, color: Colors.red.shade400),
        label: Text(
          'SIGN OUT',
          style: TextStyle(
            color: Colors.red.shade400,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignOut(BuildContext context) async {
    try {
      await _authService.signOut();
      // Navigate to login screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }

  void _navigateToProfile(BuildContext context) {
    // Navigate to profile details screen
  }

  void _navigateToCategories(BuildContext context) {
    // Navigate to categories screen
  }

  void _navigateToAlerts(BuildContext context) {
    // Navigate to alerts screen
  }

  void _navigateToLanguage(BuildContext context) {
    // Navigate to language screen
  }

  void _navigateToPrivacyPolicy(BuildContext context) {
    // Navigate to privacy policy screen
  }

  void _navigateToContactUs(BuildContext context) {
    // Navigate to contact us screen
  }
}