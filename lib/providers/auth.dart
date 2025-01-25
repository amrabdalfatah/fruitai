import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fruitvision/constants/app_constants.dart';
import 'package:fruitvision/models/user.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  Future<String?> signUp(
    String email,
    String password,
    String name,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();

      try {
        final querySnapshot = await _firestore
            .collection('users')
            .where('email', isEqualTo: email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          return 'Email already registered';
        }
      } catch (e) {
        print('Error checking email: $e');
        return 'Error checking email availability';
      }

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'createdAt': DateTime.now(),
      });

      // إرسال بريد التحقق
      // await userCredential.user!.sendEmailVerification();

      // await _loadUserData();
      return null;
    } on FirebaseAuthException catch (e) {
      print('Firebase Error: ${e.code}'); // للتتبع
      return switch (e.code) {
        'email-already-in-use' => 'Email already exists',
        'weak-password' => 'Password is too weak',
        'invalid-email' => 'Invalid email format',
        _ => e.message
      };
    } catch (e) {
      print('General Error: $e'); // للتتبع
      return e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        return 'Failed to sign in';
      }
      final doc =
          await _firestore.collection('users').doc(credential.user!.uid).get();
      print("//////////////////");
      print(doc.id);
      print(doc.data());
      AppConstants.user = UserModel.fromFirestore(doc.id, doc.data()!);
      print('created user success');
      return null;
    } on FirebaseAuthException catch (e) {
      return switch (e.code) {
        'user-not-found' => 'user-not-found',
        'wrong-password' => 'wrong-password',
        _ => e.message
      };
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> _loadUserData() async {
  //   final user = _user.cred

  //     notifyListeners();

  // }
}
