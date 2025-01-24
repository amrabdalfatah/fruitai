import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fruitvision/models/analysis_record.dart';

class AnalysisProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<AnalysisRecord> _analyses = [];
  bool _isLoading = false;
  AnalysisRecord? _currentAnalysis;

  List<AnalysisRecord> get analyses => _analyses;
  bool get isLoading => _isLoading;
  AnalysisRecord? get currentAnalysis => _currentAnalysis;

  Future<void> loadAnalyses(String userId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final snapshot = await _firestore
          .collection('analyses')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      _analyses = snapshot.docs
          .map((doc) => AnalysisRecord.fromFirestore(doc.data()))
          .toList();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> performAnalysis(String imageUrl, String analysisType) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call to ML model
      await Future.delayed(const Duration(seconds: 2));
      _currentAnalysis = AnalysisRecord(
        id: DateTime.now().toString(),
        fruitType: analysisType,
        groupNumber: '1', // You might want to make this dynamic
        analysisDate: DateTime.now(),
        quality: 'Good', // This should come from ML model
        ripenessPercentage: 0, // This should come from ML model
        suggestedHarvestDate: DateTime.now().add(const Duration(days: 7)), // This should come from ML model
        imageUrl: imageUrl,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> saveAnalysis(AnalysisRecord analysis) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _firestore.collection('analyses').doc(analysis.id).set({
        'id': analysis.id,
        'fruitType': analysis.fruitType,
        'groupNumber': analysis.groupNumber,
        'analysisDate': analysis.analysisDate.toIso8601String(),
        'quality': analysis.quality,
        'ripenessPercentage': analysis.ripenessPercentage,
        'suggestedHarvestDate': analysis.suggestedHarvestDate.toIso8601String(),
        'imageUrl': analysis.imageUrl,
      }
      );

      _analyses.insert(0, analysis);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
