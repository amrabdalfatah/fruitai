// models/analysis_record.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fruitvision/models/analysis_record.dart';
import 'package:fruitvision/services/analysis_service.dart';
import 'package:fruitvision/widgets/analysis/analysis_card.dart';

class PreviousAnalysesScreen extends StatelessWidget {
  final AnalysisService _analysisService = AnalysisService();

  PreviousAnalysesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: StreamBuilder<List<AnalysisRecord>>(
                stream: _analysisService.getAnalysisRecords(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final records = snapshot.data ?? [];
                  if (records.isEmpty) {
                    return const Center(
                      child: Text('No previous analyses found'),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      return AnalysisCard(
                        record: records[index],
                        onTap: () {
                          // Navigate to analysis details
                        },
                      );
                    },
                  );
                },
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
        'Previous Analyses',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
