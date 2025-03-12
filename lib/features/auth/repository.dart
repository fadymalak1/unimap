import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';


class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<String, UserModel>> login(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final User user = userCredential.user!;

      // Fetch user data from Firestore
      final DocumentSnapshot userDoc = await _firestore.collection("users").doc(user.uid).get();
      if (!userDoc.exists) {
        return left("User data not found");
      }

      final UserModel userModel = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);

      // Store user session locally
      await _storeUserSession(userModel);

      return right(userModel);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? "An error occurred");
    }
  }

  Future<Either<String, UserModel>> register(String firstName, String lastName, String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final User user = userCredential.user!;

      final UserModel userModel = UserModel(
        uid: user.uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        favoritePlaces: [],
        createdAt: DateTime.now(),
      );

      // Store user details in Firestore
      await _firestore.collection("users").doc(user.uid).set(userModel.toMap());

      // Store user session locally
      await _storeUserSession(userModel);

      return right(userModel);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? "An error occurred");
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("userSession");
  }

  Future<void> _storeUserSession(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userSession", user.uid); // Store only UID
  }

 Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.delete();
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("userSession");
 }

 Future<void> changePassword (String newPassword) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
    }
 }
// Fetch user session on app start
  Future<Either<String, UserModel>> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? uid = prefs.getString("userSession");

    if (uid == null) {
      return left("No user session found");
    }

    final DocumentSnapshot userDoc = await _firestore.collection("users").doc(uid).get();
    if (!userDoc.exists) {
      return left("User data not found");
    }

    final UserModel userModel = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    return right(userModel);
  }

}
