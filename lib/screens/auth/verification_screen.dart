// // lib/screens/verification_screen.dart

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:fruitvision/widgets/common/loding_indicator.dart';
// import 'package:provider/provider.dart';
// import 'package:fruitvision/providers/auth_provider.dart';
// import 'package:go_router/go_router.dart';
// import 'package:fruitvision/constants/app_colors.dart';

// class VerificationScreen extends StatefulWidget {
//   const VerificationScreen({super.key});

//   @override
//   State<VerificationScreen> createState() => _VerificationScreenState();
// }

// class _VerificationScreenState extends State<VerificationScreen> {
//   Timer? _timer;
//   bool _isChecking = false;

//   @override
//   void initState() {
//     super.initState();
//     // Start periodic check
//     _startVerificationCheck();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   void _startVerificationCheck() {
//     _timer = Timer.periodic(const Duration(minutes: 2), (timer) async {
//       if (!mounted) return;
//       final auth = context.read<AuthProvider>();
//       if (!_isChecking) {
//         _isChecking = true;
//         try {
//           final isVerified = await auth.checkEmailVerified();
//           if (isVerified) {
//             _timer?.cancel();
//             if (!mounted) return;
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Email verified successfully!'),
//                 backgroundColor: Colors.green,
//               ),
//             );
//             // Redirect to sign in after verification
//             if (!mounted) return;
//             context.go('/signin');
//           }
//         } finally {
//           _isChecking = false;
//         }
//       }
//     });
//   }

//   Future<void> _manualCheckVerification() async {
//     if (_isChecking) return;

//     setState(() => _isChecking = true);
//     try {
//       final isVerified =
//           await context.read<AuthProvider>().checkEmailVerified();

//       if (!mounted) return;

//       if (isVerified) {
//         _timer?.cancel();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Email verified successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//         context.go('/signin');
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//                 'Email not verified yet. Please check your email and click the verification link.'),
//             backgroundColor: Colors.orange,
//           ),
//         );
//       }
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(e.toString()),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       if (mounted) {
//         setState(() => _isChecking = false);
//       }
//     }
//   }

//   Future<void> _resendVerification() async {
//     try {
//       await context.read<AuthProvider>().resendVerificationEmail();
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Verification email resent. Please check your inbox.'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(e.toString()),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AuthProvider>(
//       builder: (context, auth, child) {
//         return Scaffold(
//           body: LoadingIndicator(
//             isLoading: auth.isLoading || _isChecking,
//             child: SafeArea(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     // Verification Icon
//                     Image.asset(
//                       'assets/images/verification.png',
//                       height: 150,
//                     ),
//                     const SizedBox(height: 20),

//                     // Title
//                     const Text(
//                       'VERIFY YOUR EMAIL',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.primaryDark,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 20),

//                     // Instructions
//                     const Text(
//                       'A verification link has been sent to your email.\nPlease check your inbox and spam folder.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     const SizedBox(height: 40),

//                     // Verification Status
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade100,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         _isChecking
//                             ? 'Checking verification status...'
//                             : 'Waiting for email verification',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: _isChecking ? Colors.blue : Colors.grey,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Check Verification Button
//                     ElevatedButton(
//                       onPressed: (_isChecking || auth.isLoading)
//                           ? null
//                           : _manualCheckVerification,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.accent,
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text(
//                         'CHECK VERIFICATION',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Resend Email Button
//                     TextButton(
//                       onPressed: (_isChecking || auth.isLoading)
//                           ? null
//                           : _resendVerification,
//                       child: const Text(
//                         'Resend Verification Email',
//                         style: TextStyle(color: AppColors.accent),
//                       ),
//                     ),

//                     const SizedBox(height: 20),
//                     // Help Text
//                     const Text(
//                       'Having trouble? Make sure to check your spam folder or click "Resend Verification Email"',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
