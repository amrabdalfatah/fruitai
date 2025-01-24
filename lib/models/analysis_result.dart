class AnalysisResult {
  final BasicInfo basicInfo;
  final FruitAnalysis fruitAnalysis;
  final Recommendations recommendations;
  final List<String> alerts;

  AnalysisResult({
    required this.basicInfo,
    required this.fruitAnalysis,
    required this.recommendations,
    this.alerts = const [],
  });
}

class BasicInfo {
  final int numberOfFruits;
  final String fruitType;
  final DateTime dateTime;
  final double accuracy;

  BasicInfo({
    required this.numberOfFruits,
    required this.fruitType,
    required this.dateTime,
    required this.accuracy,
  });
}

class FruitAnalysis {
  final int ripenessLevel;
  final String qualityLevel;
  final String condition;
  final String defects;
  final int expectedRipeningDays;
  final String size;

  FruitAnalysis({
    required this.ripenessLevel,
    required this.qualityLevel,
    required this.condition,
    required this.defects,
    required this.expectedRipeningDays,
    required this.size,
  });
}

class Recommendations {
  final DateTime harvestDate;
  final DateTime marketingDate;
  final String storageInstructions;
  final String temperature;

  Recommendations({
    required this.harvestDate,
    required this.marketingDate,
    required this.storageInstructions,
    required this.temperature,
  });
}
