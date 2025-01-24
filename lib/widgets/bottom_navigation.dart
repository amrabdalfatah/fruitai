import 'package:flutter/material.dart';
import 'package:fruitvision/constants/app_colors.dart';
import 'package:fruitvision/providers/navigation.dart';
import 'package:fruitvision/screens/analysis/analyze_screen.dart';
import 'package:fruitvision/screens/history.dart';
import 'package:fruitvision/screens/home/home.dart';
import 'package:fruitvision/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  // Add list of pages
  final List<Widget> _pages = [
    const HomeScreen(),
    const AnalysisPage(), 
    PreviousAnalysesScreen(),
    ProfileScreen(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: _pages[navigationProvider.currentIndex],
          bottomNavigationBar: CustomNavBar(
            selectedIndex: navigationProvider.currentIndex,
            onTap: (index) => navigationProvider.setIndex(index),
          ),
        );
      },
    );
  }
}

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home_outlined, 0),
          _buildNavItem(Icons.remove_red_eye_outlined, 1),
          _buildNavItem(Icons.bar_chart_outlined, 2),
          _buildNavItem(Icons.person_outline, 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (selectedIndex == index)
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryDark,
            ),
          ),
        IconButton(
          icon: Icon(
            icon,
            size: 35,
            color: selectedIndex == index
                ? const Color.fromARGB(255, 255, 255, 255)
                : Colors.grey,
          ),
          onPressed: () => onTap(index),
        ),
      ],
    );
  }
}
