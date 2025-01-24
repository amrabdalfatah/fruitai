import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruitvision/models/analysis_record.dart';

class AnalysisService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<AnalysisRecord>> getAnalysisRecords() {
    return _firestore
        .collection('analyses')
        .orderBy('analysisDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AnalysisRecord.fromFirestore(doc.data()))
          .toList();
    });
  }

  Future<void> deleteAnalysisRecord(String id) {
    return _firestore.collection('analyses').doc(id).delete();
  }
}