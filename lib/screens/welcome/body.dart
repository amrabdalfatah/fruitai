import 'package:flutter/material.dart';
import 'package:fruitvision/constants/app_colors.dart';
import 'package:fruitvision/screens/welcome/welcome_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _animationController;
  late final Animation<double> _slideAnimation;

  int _currentPage = 0;

  static const List<WelcomeSlide> slides = [
    WelcomeSlide(
      title: 'Smart Fruit Analysis',
      description:
          'Discover advanced technology that uses artificial intelligence to analyze fruit quality with over 90% accuracy. All you need is one photo for instant evaluation.',
      image: 'assets/images/1.png',
    ),
    WelcomeSlide(
      title: 'Automated Quality Check',
      description:
          'An integrated system that detects damaged fruits and automatically classifies their quality. Saves you time and effort in sorting and classification.',
      image: 'assets/images/2.png',
    ),
    WelcomeSlide(
      title: 'Ripeness Prediction',
      description:
          'Get accurate predictions for fruit ripening times and development stages. Helps you improve crop management and reduce waste.',
      image: 'assets/images/3.png',
    ),
    WelcomeSlide(
        title: 'WELCOME', description: '', image: 'assets/images/logo.png'),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handlePageChange(int page) async {
    setState(() => _currentPage = page);
    await _animationController.forward(from: 0);
  }

  void _navigateToNextPage() {
    if (_currentPage < slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipToEnd() {
    _pageController.animateToPage(
      slides.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentPage == slides.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: _handlePageChange,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: slides.length,
              itemBuilder: (context, index) => _buildPage(index),
            ),
            if (isLastPage)
              Positioned(
                top: 16,
                left: 16,
                child: IconButton(
                  onPressed: _navigateToPreviousPage,
                  icon: const Icon(
                    Icons.chevron_left,
                    color: AppColors.primaryDark,
                    size: 32,
                  ),
                ),
              ),
            if (!isLastPage)
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Column(
                  children: [
                    _PageIndicator(
                      currentPage: _currentPage,
                      totalPages: slides.length - 1,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_currentPage > 0)
                            IconButton(
                              onPressed: _navigateToPreviousPage,
                              icon: const Icon(
                                Icons.chevron_left,
                                color: AppColors.primaryDark,
                                size: 32,
                              ),
                            )
                          else
                            const SizedBox(width: 48),
                          TextButton(
                            onPressed: _skipToEnd,
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                color: AppColors.primaryDark,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: _navigateToNextPage,
                            icon: const Icon(
                              Icons.chevron_right,
                              color: AppColors.primaryDark,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    final bool isWelcomePage = index == slides.length - 1;

    if (isWelcomePage) {
      return WelcomePage(
        animation: _slideAnimation,
        slide: slides[index],
      );
    }

    return _OnboardingPage(
      animation: _slideAnimation,
      slide: slides[index],
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final Animation<double> animation;
  final WelcomeSlide slide;

  const _OnboardingPage({
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
              height: 250,
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
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  slide.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const _PageIndicator({
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: currentPage == index ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: currentPage == index
                ? AppColors.primaryDark
                : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}

class WelcomeSlide {
  final String title;
  final String description;
  final String image;

  const WelcomeSlide({
    required this.title,
    required this.description,
    required this.image,
  });
}
