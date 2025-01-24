import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fruitvision/models/analysis_result.dart';
import 'package:fruitvision/widgets/analysis/info_card.dart';
import 'package:intl/intl.dart';

class AnalysisResultsScreen extends StatelessWidget {
  final AnalysisResult result;

  const AnalysisResultsScreen({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildBasicInfo(),
                    _buildFruitAnalysis(),
                    _buildRecommendations(),
                    if (result.alerts.isNotEmpty) _buildAlerts(),
                    _buildActions(),
                    _buildBackButton(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade800,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: const Text(
        'ANALYSIS RESULTS DASHBOARD',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return InfoCard(
      title: 'Basic Information',
      icon: Icons.info_outline,
      items: [
        MapEntry(
            'Number of fruits', result.basicInfo.numberOfFruits.toString()),
        MapEntry('Fruit type', result.basicInfo.fruitType),
        MapEntry(
          'Date and time',
          DateFormat('yyyy-MM-dd HH:mm').format(result.basicInfo.dateTime),
        ),
        MapEntry('Analysis accuracy', '${result.basicInfo.accuracy}%'),
      ],
    );
  }

  Widget _buildFruitAnalysis() {
    return InfoCard(
      title: 'Fruit Analysis',
      icon: Icons.analytics_outlined,
      items: [
        MapEntry('Ripeness level', '${result.fruitAnalysis.ripenessLevel}%'),
        MapEntry('Quality level', result.fruitAnalysis.qualityLevel),
        MapEntry('Condition', result.fruitAnalysis.condition),
        MapEntry('Defects', result.fruitAnalysis.defects),
        MapEntry(
          'Expected ripening time',
          '${result.fruitAnalysis.expectedRipeningDays} days',
        ),
        MapEntry('Size', result.fruitAnalysis.size),
      ],
    );
  }

  Widget _buildRecommendations() {
    return InfoCard(
      title: 'Recommendations and Predictions',
      icon: Icons.recommend,
      items: [
        MapEntry(
          'Suggested harvest date',
          DateFormat('yyyy-MM-dd').format(result.recommendations.harvestDate),
        ),
        MapEntry(
          'Best time for marketing',
          DateFormat('yyyy-MM-dd').format(result.recommendations.marketingDate),
        ),
        MapEntry(
          'Storage instructions',
          result.recommendations.storageInstructions,
        ),
        MapEntry('', result.recommendations.temperature),
      ],
    );
  }

  Widget _buildAlerts() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red.shade400),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              result.alerts.isEmpty
                  ? 'No special alerts'
                  : result.alerts.join('\n'),
              style: TextStyle(
                color: Colors.red.shade400,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildActionButton(
            icon: Icons.save,
            onTap: () {
              // Implement save functionality
            },
          ),
          const SizedBox(width: 32),
          _buildActionButton(
            icon: Icons.share,
            onTap: () {
              // Implement share functionality
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.shade800,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'BACK TO HOME',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
