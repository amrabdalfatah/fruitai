class AnalysisRecord {
  final String id;
  final String fruitType;
  final String groupNumber;
  final DateTime analysisDate;
  final String quality;
  final int ripenessPercentage;
  final DateTime suggestedHarvestDate;
  final String imageUrl;

  AnalysisRecord({
    required this.id,
    required this.fruitType,
    required this.groupNumber,
    required this.analysisDate,
    required this.quality,
    required this.ripenessPercentage,
    required this.suggestedHarvestDate,
    required this.imageUrl,
  });

  factory AnalysisRecord.fromFirestore(Map<String, dynamic> data) {
    return AnalysisRecord(
      id: data['id'],
      fruitType: data['fruitType'],
      groupNumber: data['groupNumber'],
      analysisDate: DateTime.parse(data['analysisDate']),
      quality: data['quality'],
      ripenessPercentage: data['ripenessPercentage'],
      suggestedHarvestDate: DateTime.parse(data['suggestedHarvestDate']),
      imageUrl: data['imageUrl'],
    );
  }
}
