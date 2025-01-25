// analysis_page.dart
import 'dart:io';
// import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fruitvision/models/analysis_result.dart';
import 'package:fruitvision/screens/analysis/result_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

final result = AnalysisResult(
  basicInfo: BasicInfo(
    numberOfFruits: 12,
    fruitType: 'Apple',
    dateTime: DateTime.now(),
    accuracy: 95.5,
  ),
  fruitAnalysis: FruitAnalysis(
    ripenessLevel: 75,
    qualityLevel: 'Good',
    condition: 'Healthy',
    defects: 'Minor scratches',
    expectedRipeningDays: 3,
    size: 'Medium',
  ),
  recommendations: Recommendations(
    harvestDate: DateTime.now().add(const Duration(days: 3)),
    marketingDate: DateTime.now().add(const Duration(days: 4)),
    storageInstructions: 'Store at temperature',
    temperature: '4-6 degrees Celsius',
  ),
);

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  String? selectedAnalysisType;
  String? selectedImage;
  // final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    // final interpreter =
    //     await Interpreter.fromAsset('assets/models/model.tflite');
    // String? result = await TfLite.loadModel(
    //   model: "assets/models/model.tflite",
    //   labels: "assets/models/labels.txt",
    // );
    // print("Model loaded: $result");
  }

  String? _result;

  Future<void> runModel() async {
    // var recognitions = await Tflite.runModelOnImage(
    //   path: selectedImage!,
    // );

    // setState(() {
    //   _result = recognitions.toString();
    // });
    // print(_result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
                width: double.infinity,
                child: _buildHeader(),
              ),
              SizedBox(
                height: 300,
                width: double.infinity,
                child: _buildImagePreview(),
              ),
              SizedBox(
                height: 692,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildAnalysisTypes(),
                      const SizedBox(height: 24),
                      _buildStartButton(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.green.shade800,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: const Column(
        children: [
          Text(
            'Available Analysis Types',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Available Analysis Types',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 200,
      width: double.infinity,
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
      child: selectedImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                File(selectedImage!),
                fit: BoxFit.cover,
              ),
            )
          : InkWell(
              onTap: _selectImage,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 48,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Select an image to analyze',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildAnalysisTypes() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildAnalysisCard(
                title: 'Damage detection',
                subtitle: 'Separating damaged fruits from healthy ones',
                icon: Icons.warning_rounded,
                isGreen: false,
                type: 'damage',
                features: [
                  'Identifying damaged fruits',
                  'Estimating damage percentage',
                  'Treatment recommendations',
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildAnalysisCard(
                title: 'Fruit Quality Analysis',
                subtitle: 'Determine fruit quality and classify them',
                icon: Icons.verified_rounded,
                isGreen: true,
                type: 'quality',
                features: [
                  'Fruit quality classification',
                  'Identification of defects and damage',
                  'Comprehensive crop evaluation',
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildAnalysisCard(
                title: 'Temporal Monitoring',
                subtitle: 'Track crop development over time',
                icon: Icons.timer_outlined,
                isGreen: false,
                type: 'temporal',
                features: [
                  'Identifying damaged fruits',
                  'Estimating damage percentage',
                  'Treatment recommendations',
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildAnalysisCard(
                title: 'Ripeness Analysis',
                subtitle: 'Evaluating fruit ripeness level',
                icon: Icons.eco_outlined,
                isGreen: true,
                type: 'ripeness',
                features: [
                  'Measuring ripeness level',
                  'Predicting optimal harvest date',
                  'Monitoring ripeness development',
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnalysisCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isGreen,
    required String type,
    required List<String> features,
  }) {
    final isSelected = selectedAnalysisType == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnalysisType = isSelected ? null : type;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? (isGreen ? Colors.green.shade800 : Colors.grey.shade700)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isGreen ? Colors.green.shade800 : Colors.grey.shade700,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isGreen ? Colors.green.shade800 : Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 12),
            ...features
                .map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: isGreen
                                    ? Colors.green.shade800
                                    : Colors.grey.shade700,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              feature,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStartButton() {
    bool canStartAnalysis =
        selectedImage != null && selectedAnalysisType != null;

    // void _startAnalysis() {
    //   if (selectedImage != null && selectedAnalysisType != null) {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => AnalysisResultsScreen(
    //           imagePath: selectedImage!,
    //           analysisType: selectedAnalysisType!, result: result,
    //         ),
    //       ),
    //     );
    //   }
    // }

    return Container(
      width: double.infinity,
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: canStartAnalysis
            ? () {
                runModel();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnalysisResultsScreen(result: result),
                  ),
                );
              }
            : null,

        //canStartAnalysis ? _startAnalysis : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade400,
          disabledBackgroundColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          'START ANALYSIS',
          style: TextStyle(
            color: canStartAnalysis ? Colors.white : Colors.grey.shade600,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    // Implement image picker functionality
    // You'll need to add image_picker package to pubspec.yaml
    print('Selected Image start');
    ImagePicker picker = ImagePicker();
    // final LostDataResponse response = await picker.retrieveLostData();
    // if (response.isEmpty) {
    //   print('resposne empty');
    //   return;
    // }
    print('Selected Image start');
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    print('Selected Image start');
    print('image');
    if (image != null) {
      setState(() {
        selectedImage = image.path;
      });
    }
  }

  void _startAnalysis() {
    if (selectedImage != null && selectedAnalysisType != null) {
      // Implement analysis logic
      print('Starting analysis of type: $selectedAnalysisType');
    }
  }
}
